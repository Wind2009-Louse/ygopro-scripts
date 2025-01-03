--悪魔の手鏡
---@param c Card
function c58607704.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c58607704.tgcon)
	e1:SetTarget(c58607704.tgtg)
	e1:SetOperation(c58607704.tgop)
	c:RegisterEffect(e1)
end
function c58607704.tgcon(e,tp,eg,ep,ev,re,r,rp)
	if rp==tp or not re:IsHasType(EFFECT_TYPE_ACTIVATE) or not re:IsActiveType(TYPE_SPELL)
		or not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return false end
	local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	if not g or g:GetCount()~=1 then return false end
	local tc=g:GetFirst()
	e:SetLabelObject(tc)
	return tc:IsOnField() and tc:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c58607704.filter(c,ct)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and Duel.CheckChainTarget(ct,c)
end
function c58607704.tgtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc~=e:GetLabelObject() and chkc:IsOnField() and c58607704.filter(chkc,ev) end
	if chk==0 then return Duel.IsExistingTarget(c58607704.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,e:GetLabelObject(),ev) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c58607704.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,e:GetLabelObject(),ev)
end
function c58607704.tgop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if g and g:GetFirst():IsRelateToEffect(e) then
		Duel.ChangeTargetCard(ev,g)
	end
end
