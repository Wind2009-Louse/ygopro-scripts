--真紅眼の遡刻竜
---@param c Card
function c53485634.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(53485634,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_GRAVE_SPSUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_CUSTOM+53485634)
	e1:SetRange(LOCATION_HAND)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetTarget(c53485634.sptg)
	e1:SetOperation(c53485634.spop)
	c:RegisterEffect(e1)
	aux.RegisterMergedDelayedEvent(c,53485634,EVENT_TO_GRAVE)
	--extra summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(53485634,1))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c53485634.sumcon)
	e2:SetCost(c53485634.sumcost)
	e2:SetTarget(c53485634.sumtg)
	e2:SetOperation(c53485634.sumop)
	c:RegisterEffect(e2)
end
function c53485634.spfilter(c,e,tp)
	return c:IsPreviousPosition(POS_FACEUP) and c:IsPreviousControler(tp) and c:IsPreviousLocation(LOCATION_MZONE) and c:IsReason(REASON_DESTROY)
		and (c:IsReason(REASON_EFFECT) and c:GetReasonPlayer()==1-tp or c:IsReason(REASON_BATTLE) and Duel.GetAttacker():IsControler(1-tp))
		and c:IsSetCard(0x3b) and c:IsLevelBelow(7) and c:IsControler(tp)
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false,c:GetPreviousPosition())
end
function c53485634.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not Duel.IsPlayerAffectedByEffect(tp,59822133)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE)
		and eg:IsExists(c53485634.spfilter,1,nil,e,tp) end
	local g=eg:Filter(c53485634.spfilter,nil,e,tp)
	Duel.SetTargetCard(g)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,g,g:GetCount(),0,0)
end
function c53485634.filter(c,e,tp)
	return c:IsRelateToEffect(e) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,c:GetPreviousPosition())
end
function c53485634.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(c53485634.filter,nil,e,tp)
	if c:IsRelateToEffect(e) then
		if Duel.SpecialSummonStep(c,0,tp,tp,false,false,POS_FACEUP_DEFENSE) then
			local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
			if ft>0 and g:GetCount()>0 and not Duel.IsPlayerAffectedByEffect(tp,59822133) then
				if g:GetCount()>ft then
					Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
					g=g:Select(tp,ft,ft,nil)
				end
				local tc=g:GetFirst()
				while tc do
					Duel.SpecialSummonStep(tc,0,tp,tp,false,false,tc:GetPreviousPosition())
					tc=g:GetNext()
				end
			end
		end
		Duel.SpecialSummonComplete()
	end
end
function c53485634.sumcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFlagEffect(tp,53485634)==0
end
function c53485634.sumcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c53485634.sumtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanSummon(tp) and Duel.IsPlayerCanAdditionalSummon(tp) end
end
function c53485634.sumop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetDescription(aux.Stringid(53485634,2))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_EXTRA_SUMMON_COUNT)
	e1:SetTargetRange(LOCATION_HAND+LOCATION_MZONE,0)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x3b))
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	Duel.RegisterFlagEffect(tp,53485634,RESET_PHASE+PHASE_END,0,1)
end
