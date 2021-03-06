--水月のアデュラリア
---
--Script by Trishula9
function c100200219.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,100200219+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c100200219.spcon)
	c:RegisterEffect(e1)
	--atkup
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetValue(c100200219.atkval)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e3)
	--to grave
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_TOGRAVE)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1,100200219)
	e4:SetCost(c100200219.tgcost)
	e4:SetTarget(c100200219.tgtg)
	e4:SetOperation(c100200219.tgop)
	c:RegisterEffect(e4)
end
function c100200219.spcfilter(c)
	return c:IsFaceup() and c:GetSequence()<5
end
function c100200219.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c100200219.spcfilter,tp,LOCATION_SZONE,0,1,nil)
end
function c100200219.atkfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsFaceup()
end
function c100200219.atkval(e,c)
	return Duel.GetMatchingGroupCount(c100200219.atkfilter,c:GetControler(),LOCATION_ONFIELD,LOCATION_ONFIELD,nil)*600
end
function c100200219.cfilter(c)
	return c:IsFaceup() and c:IsAbleToGraveAsCost() and c:GetSequence()<5
end
function c100200219.tgcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c100200219.cfilter,tp,LOCATION_SZONE,0,2,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c100200219.cfilter,tp,LOCATION_SZONE,0,2,2,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c100200219.tgfilter(c)
	return c:IsLevelBelow(4) and c:IsAbleToGrave()
end
function c100200219.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c100200219.tgfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c100200219.tgop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c100200219.tgfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
end