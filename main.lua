DEGENMOD = RegisterMod("Degenerate Mod", 1)

--BEWARE YE WHO ALL TREK HERE
--This code is cursed. It works, but it's cursed. Written in spaghetti.

local achievement_display_api = require("scripts/achievement_display_api")
local fuckables_logic = require("scripts/fuckables_logic")
local configfile = require("scripts/dgm_config")
local achbook = require("scripts/achievement_book")
local cosmetics = require("scripts/cosmetics")
local wardrobe_mod_support = require("scripts/wardrobe_mod_support")
local json = require("json")

sound = SFXManager()
GameState = {}

currentCharSessID = nil

--############ SAVES & LOADING ############
function DEGENMOD:onStart()
	if DEGENMOD:HasData() then
		GameState = json.decode(DEGENMOD:LoadData())
	else
		GameState = DEGENMOD.ConfigMod
	end
end
DEGENMOD:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, DEGENMOD.onStart)

function DEGENMOD:onExit(save)
	DEGENMOD:SaveData(json.encode(GameState))
end

DEGENMOD:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, DEGENMOD.getCurrentCharID)
DEGENMOD:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, DEGENMOD.onExit)
DEGENMOD:AddCallback(ModCallbacks.MC_POST_GAME_END, DEGENMOD.onExit)