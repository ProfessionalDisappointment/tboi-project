DEGENMOD.ConfigMod = {
	
	--QOL features
	["Enable Hotkey Reminder"] = false,

	["Shader Zooming"] = true,

	-- 0 : NONE
	-- 1 : MALE
	-- 2 : FEMALE
	["Isaac Skin Type"] = 2,
	["Magdalene Skin Type"] = 2,
	["Cain Skin Type"] = 2,
	["Judas Skin Type"] = 2,
	["Eve Skin Type"] = 2,
 	
	--EXPERIMENTAL OR UNFINISHED FEATURES. These are not guaranteed to work or are iffy to deal with.
	["Enable Achievement Tracker"] = false,
	["Character Replace during Scene"] = false, --Has not been finished, only supports Isaac / Maggie / Cain for now (too lazy for sprites lol). playing any other character will cause issues

	--::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::DO NOT EDIT ANYTHING BEYOND THIS POINT WITHOUT KNOWING WHAT YOU'RE DOING::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

	--unlocks part 1
	["Unlocked Main Pack"] = true,
	["Unlocked R63 Pack"] = true,
		
	--unlocks part 2 electric boogaloo
	["Unlocked Isaac Collectible"] = false,
	["Unlocked Eve Collectible"] = false,
	["Unlocked FemLaz Collectible"] = false,
	["Unlocked Cain Collectible"] = false,
	["Unlocked Shygal Collectible"] = false,
	["Unlocked Frisk Collectible"] = false,
	["Unlocked Bethany Collectible"] = false,
	
	--variables for special unlocks
	["100 Completion Unlock"] = true,
	["Joke Unlock"] = true,
	
	--code specific variables
	["autoTimerMaxRate"] = 20,
	["autoTimerFallMultiplier"] = 1,
	["shaderZoomInMultiplier"] = 0.6,

	--Character Heads and Character Torsos
	["MaleTorso"] = "gfx/screwable/fb_torso_male.png",
	["FemaleTorso"] = "gfx/screwable/fb_torso_female.png"
}