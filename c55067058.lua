--No.19 フリーザードン
---@param c Card
function c55067058.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,5,2)
	c:EnableReviveLimit()
	--remove overlay replace
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(55067058,0))
	e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_OVERLAY_REMOVE_REPLACE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c55067058.rcon)
	e1:SetOperation(c55067058.rop)
	c:RegisterEffect(e1)
end
aux.xyz_number[55067058]=19
function c55067058.rcon(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(r,REASON_COST)~=0 and re:IsActivated() and re:IsActiveType(TYPE_XYZ)
		and e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_EFFECT)
		and ep==e:GetOwnerPlayer() and re:GetHandler():GetOverlayCount()>=ev-1
end
function c55067058.rop(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_EFFECT)
end
