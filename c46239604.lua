--魔知ガエル
---@param c Card
function c46239604.initial_effect(c)
	--change code
	aux.EnableChangeCode(c,84451804)
	--search
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(46239604,0))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e2:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCondition(c46239604.condition)
	e2:SetTarget(c46239604.target)
	e2:SetOperation(c46239604.operation)
	c:RegisterEffect(e2)
	--atlimit
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(0,LOCATION_MZONE)
	e3:SetValue(c46239604.atlimit)
	c:RegisterEffect(e3)
end
function c46239604.atlimit(e,c)
	return c~=e:GetHandler()
end
function c46239604.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c46239604.filter(c)
	return c:IsSetCard(0x12) and not c:IsCode(46239604) and c:IsAbleToHand()
end
function c46239604.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c46239604.filter,tp,LOCATION_GRAVE+LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_GRAVE+LOCATION_DECK)
end
function c46239604.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c46239604.filter),tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
