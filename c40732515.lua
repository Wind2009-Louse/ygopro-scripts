--神聖魔導王 エンディミオン
---@param c Card
function c40732515.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	e1:SetCondition(c40732515.spcon)
	e1:SetOperation(c40732515.spop)
	e1:SetValue(SUMMON_VALUE_SELF)
	c:RegisterEffect(e1)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(40732515,0))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCondition(c40732515.condition)
	e2:SetTarget(c40732515.target)
	e2:SetOperation(c40732515.operation)
	c:RegisterEffect(e2)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(40732515,1))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCost(c40732515.descost)
	e3:SetTarget(c40732515.destg)
	e3:SetOperation(c40732515.desop)
	c:RegisterEffect(e3)
end
function c40732515.spcfilter(c,tp)
	return c:IsCode(39910367) and c:IsCanRemoveCounter(tp,0x1,1,REASON_COST)
end
function c40732515.spcon(e,c)
	if c==nil then return true end
	if c:IsHasEffect(EFFECT_NECRO_VALLEY) then return false end
	local tp=c:GetControler()
	local g=Duel.GetMatchingGroup(c40732515.spcfilter,tp,LOCATION_ONFIELD,0,nil,tp)
	local ct=0
	for tc in aux.Next(g) do
		ct=ct+tc:GetCounter(0x1)
	end
	return ct>=6 and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
end
function c40732515.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.GetMatchingGroup(c40732515.spcfilter,tp,LOCATION_ONFIELD,0,nil,tp)
	if #g==1 then
		g:GetFirst():RemoveCounter(tp,0x1,6,REASON_COST)
	else
		for i=1,6 do
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(40732515,2))
		local tg=Duel.SelectMatchingCard(tp,c40732515.spcfilter,tp,LOCATION_ONFIELD,0,1,1,nil,tp)
		tg:GetFirst():RemoveCounter(tp,0x1,1,REASON_COST)
		end
	end
end
function c40732515.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_SPECIAL+SUMMON_VALUE_SELF
end
function c40732515.filter(c)
	return c:IsType(TYPE_SPELL) and c:IsAbleToHand()
end
function c40732515.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c40732515.filter(chkc) end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c40732515.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,g:GetCount(),0,0)
end
function c40732515.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ShuffleHand(tp)
	end
end
function c40732515.cfilter(c)
	return c:IsType(TYPE_SPELL) and c:IsDiscardable()
end
function c40732515.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c40732515.cfilter,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.DiscardHand(tp,c40732515.cfilter,1,1,REASON_COST+REASON_DISCARD)
end
function c40732515.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() end
	if chk==0 then return Duel.IsExistingTarget(aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c40732515.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
