DEGENMOD = RegisterMod("Degenerate Mod", 1)

local fuckables_logic = require("scripts/fuckables_logic")
local configfile = require("scripts/dgm_config")
local achbook = require("scripts/achievement_book")
local cosmetics = require("scripts/cosmetics")
local wardrobe_mod_support = require("scripts/wardrobe_mod_support")

local json = require("json")

sound = SFXManager()
GameState = {}


DEGENMOD:AddCallback(ModCallbacks.MC_POST_RENDER, function()
	if GameState["Debug"] then
		local DebugMenu = false
		if Input.IsButtonPressed(Keyboard.KEY_O, 0) and DebugMenu == false then
			DebugMenu = true
			Isaac.RenderText("Brothel RNG: ".. cachedfbType_Brothel, Isaac.GetScreenWidth() / 3, Isaac.GetScreenHeight() / 2 + 55, 255, 255, 255, 255)
			Isaac.RenderText("Brothel Head Graphics: ".. cachedfbType_Head_Brothel, Isaac.GetScreenWidth() / 3, Isaac.GetScreenHeight() / 2 + 35, 255, 255, 255, 255)
			Isaac.RenderText("Brothel Body Graphics: ".. cachedfbType_Body_Brothel, Isaac.GetScreenWidth() / 3, Isaac.GetScreenHeight() / 2 + 15, 255, 255, 255, 255)
		elseif Input.IsButtonPressed(Keyboard.KEY_O, 0) and DebugMenu == true then
			DebugMenu = false
		end
	end
end)

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

DEGENMOD:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, DEGENMOD.onExit)
DEGENMOD:AddCallback(ModCallbacks.MC_POST_GAME_END, DEGENMOD.onExit)