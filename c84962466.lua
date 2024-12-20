--ビーストライザー
---@param c Card
function c84962466.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--atk
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(84962466,1))
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetHintTiming(TIMING_DAMAGE_STEP)
	e2:SetCountLimit(1)
	e2:SetCondition(aux.dscon)
	e2:SetCost(c84962466.cost)
	e2:SetTarget(c84962466.target)
	e2:SetOperation(c84962466.operation)
	c:RegisterEffect(e2)
end
function c84962466.cfilter(c,tp)
	return c:IsFaceup() and c:IsRace(RACE_BEAST+RACE_BEASTWARRIOR) and c:IsAbleToRemoveAsCost()
		and Duel.IsExistingTarget(c84962466.filter,tp,LOCATION_MZONE,0,1,c)
end
function c84962466.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_BEAST+RACE_BEASTWARRIOR)
end
function c84962466.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c84962466.cfilter,tp,LOCATION_MZONE,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local rg=Duel.SelectMatchingCard(tp,c84962466.cfilter,tp,LOCATION_MZONE,0,1,1,nil,tp)
	e:SetLabel(rg:GetFirst():GetBaseAttack())
	Duel.Remove(rg,POS_FACEUP,REASON_COST)
end
function c84962466.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c84962466.filter(chkc) end
	if chk==0 then return e:IsCostChecked() end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c84962466.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c84962466.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(e:GetLabel())
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
	end
end
