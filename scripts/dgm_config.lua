DEGENMOD.ConfigMod = {
	--unlocks part 1
	["Unlocked Storepack"] = false,
	["Unlocked Specialpack"] = false,
	["Unlocked Sinspack"] = false,
	["Unlocked Mainpack"] = false,
	["Unlocked Genderbendpack"] = false,
	["Unlocked Taintedpack"] = false,
	
	["Unlocked Brothels"] = false,
	["Unlocked Shop"] = false,
	
	--unlocks part 2 electric boogaloo
	--TODO : think up collectibles for all the characters n toss em here
	["Unlocked Isaac Collectible"] = false,
	["Unlocked Eve Collectible"] = false,
	["Unlocked FemLaz Collectible"] = false,
	
	--variables for special unlocks
	["100 Completion Unlock"] = true,
	["Joke Unlock"] = true,
	
	--debug features
	["Debug"] = true,
	
	--compatibility and other (disable these if it's conflicting, or not... i'm not your dad)
	["Enable Achievement Tracker"] = false, --UNFINISHED UNFINISHED UNFINISHED
	["Enable Body Costumes"] = true, --does nothing
	
	--::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::DO NOT EDIT ANYTHING BEYOND THIS POINT WITHOUT KNOWING WHAT YOU'RE DOING::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	--note for myself: if this proves to be too tedious or impede probably just try porting the saving & loading to fuckables_logic.lua file as a seperate thing
	--for some reason tboi wants to be very stinky when it comes to multiple json files... either that or my pisspoor sphagetti bullshit doesn't want to run
	--Character Torsos
	
	--Character Heads
	["IsaacHead"] = "gfx/screwable/fb_isaac_head_part.png",
	["IsaacTorso"] = "gfx/screwable/fb_isaac_torso_sprites.png",
	["CainHead"] = "gfx/screwable/fb_cain_head_part.png",
	["CainTorso"] = "gfx/screwable/fb_cain_torso_sprites.png",
	["EveHead"] = "gfx/screwable/fb_eve_head_part.png",
	["EveTorso"] = "gfx/screwable/fb_eve_torso_sprites.png",
	["BethanyHead"] = "gfx/screwable/fb_bethany_head_part.png",
	["BethanyTorso"] = "gfx/screwable/fb_bethany_torso_sprites.png",
	["FemLazHead"] = "gfx/screwable/fb_femlaz_head_part.png",
	["FemLazTorso"] = "gfx/screwable/fb_femlaz_torso_sprites.png",
	["ShygalHead"] = "gfx/screwable/fb_shygal_head_part.png",
	["ShygalTorso"] = "gfx/screwable/fb_shygal_torso_sprites.png",
	["FriskHead"] = "gfx/screwable/fb_frisk_head_part.png",
	["FriskTorso"] = "gfx/screwable/fb_frisk_torso_sprites.png",
	
	["BethanyCosmetic"] = "gfx/screwable/fb_bethany_cosmetic_part.png",
	["FemLazCosmetic"] = "gfx/screwable/fb_femlaz_cosmetic_part.png",
	
	--Price Attributes
	["Price"] = 5,
	["NewTag"] = false,
	["SaleTag"] = false
}