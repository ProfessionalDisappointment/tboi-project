function DEGENMOD:RegisterWardrobeModSupport(_DEGENMOD)
	if WardrobePlus ~= nil then
		OWRP.AddNewCostume("DMFacial", "Facial", "gfx/characters/wcostume_004_facial.anm2",false,false)
		OWRP.AddNewCostume("DMDonger", "Regular Male", "gfx/characters/wcostume_005_fat_schlonger.anm2",false,false)
		OWRP.AddNewCostume("DMBoober", "Regular Female", "gfx/characters/wcostume_006_fat_booba.anm2",false,false)
		OWRP.AddNewCostume("DMElaSet", "Special Ops Set", "gfx/characters/wcostume_007_ela_set.anm2",false,false)
		OWRP.AddNewCostume("DMElaHat", "Special Ops Hair", "gfx/characters/wcostume_008_ela_hair.anm2",false,false)
		OWRP.AddNewCostume("DMJenHat", "Robo Hair", "gfx/characters/wcostume_009_jenny_hair.anm2",false,false)
		OWRP.AddNewCostume("DMJenSet", "Robo Set", "gfx/characters/wcostume_010_jenny_set.anm2",false,false)
	end
end

DEGENMOD:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, DEGENMOD.RegisterWardrobeModSupport)