--0 == NONE
--1 == M
--2 == F

--todo : efficient nullcostume adding
function DEGENMOD:PlayerCostumesInit(currentCharSessID)
	if GameState["Character Skin Type"] ~= 0 then
		if currentCharSessID == 0 then --Isaac
			if GameState["Isaac Skin Type"] == 1 then
				local Head = Isaac.GetCostumeIdByPath("gfx/characters/costume_001m_isaac_head.anm2")
				local Body = Isaac.GetCostumeIdByPath("gfx/characters/costume_001m_isaac_body.anm2")
				DEGENMOD:CallSkinApplication(Head, Body)
			elseif GameState["Isaac Skin Type"] == 2 then
				local Head = Isaac.GetCostumeIdByPath("gfx/characters/costume_001f_isaac_head.anm2")
				local Body = Isaac.GetCostumeIdByPath("gfx/characters/costume_001f_isaac_body.anm2")
				DEGENMOD:CallSkinApplication(Head, Body)
			end
		elseif currentCharSessID == 1 then --Magdalene
			if GameState["Magdalene Skin Type"] == 1 then
				local Head = Isaac.GetCostumeIdByPath("gfx/characters/costume_002m_magdalene_head.anm2")
				local Body = Isaac.GetCostumeIdByPath("gfx/characters/costume_002m_magdalene_body.anm2")
				DEGENMOD:CallSkinApplication(Head, Body)
			elseif GameState["Magdalene Skin Type"] == 2 then
				local Head = Isaac.GetCostumeIdByPath("gfx/characters/costume_002f_magdalene_head.anm2")
				local Body = Isaac.GetCostumeIdByPath("gfx/characters/costume_002f_magdalene_body.anm2")
				DEGENMOD:CallSkinApplication(Head, Body)
			end
		elseif currentCharSessID == 2 then --Cain
			if GameState["Cain Skin Type"] == 1 then
				local Head = Isaac.GetCostumeIdByPath("gfx/characters/costume_003m_cain_head.anm2")
				local Body = Isaac.GetCostumeIdByPath("gfx/characters/costume_003m_cain_body.anm2")
				DEGENMOD:CallSkinApplication(Head, Body)
			elseif GameState["Cain Skin Type"] == 2 then
				local Head = Isaac.GetCostumeIdByPath("gfx/characters/costume_003f_cain_head.anm2")
				local Body = Isaac.GetCostumeIdByPath("gfx/characters/costume_003f_cain_body.anm2")
				DEGENMOD:CallSkinApplication(Head, Body)
			end
		elseif currentCharSessID == 3 then --Cain
			if GameState["Judas Skin Type"] == 1 then
				local Head = Isaac.GetCostumeIdByPath("gfx/characters/costume_004m_judas_head.anm2")
				local Body = Isaac.GetCostumeIdByPath("gfx/characters/costume_004m_judas_body.anm2")
				DEGENMOD:CallSkinApplication(Head, Body)
			elseif GameState["Judas Skin Type"] == 2 then
				local Head = Isaac.GetCostumeIdByPath("gfx/characters/costume_004f_judas_head.anm2")
				local Body = Isaac.GetCostumeIdByPath("gfx/characters/costume_004f_judas_body.anm2")
				DEGENMOD:CallSkinApplication(Head, Body)
			end
		end
	end
end

function DEGENMOD:CallSkinApplication(head, body, cosmetic)
	Isaac.GetPlayer():AddNullCostume(head)
	Isaac.GetPlayer():AddNullCostume(body)
	if cosmetic then
		Isaac.GetPlayer():AddNullCostume(cosmetic)
	end
end