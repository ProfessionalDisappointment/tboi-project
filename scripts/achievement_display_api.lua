CCO = CCO or {}

if CCO.AchievementDisplayAPI then return end

CCO.AchievementDisplayAPI = RegisterMod("Achievement Display API", 1)
local game = Game()
local sound = SFXManager()
local AchievementQueue = {}
local AchievementSpr = Sprite()
AchievementSpr:Load("gfx/ui/achievement display api/achievements.anm2")
AchievementSpr.PlaybackSpeed = 0.5

local function GetScreenSize() -- By Kilburn himself.
    local room = game:GetRoom()
    local pos = Isaac.WorldToScreen(Vector(0,0)) - room:GetRenderScrollOffset() - game.ScreenShakeOffset
    
    local rx = pos.X + 60 * 26 / 40
    local ry = pos.Y + 140 * (26 / 40)
    
    return rx*2 + 13*26, ry*2 + 7*26
end

local OldTimer
local OverwrittenPause = false
local AddedPauseCallback = false
local function OverridePause(_, player, hook, action)
	if OverwrittenPause then
		OverwrittenPause = false
		AddedPauseCallback = false
		CCO.AchievementDisplayAPI:RemoveCallback(ModCallbacks.MC_INPUT_ACTION, OverridePause)
		return
	end

	if action == ButtonAction.ACTION_SHOOTRIGHT then
		OverwrittenPause = true
		for _, ember in ipairs(Isaac.FindByType(EntityType.ENTITY_EFFECT, EffectVariant.FALLING_EMBER, -1)) do
			ember:Remove()
		end
		for _, rain in ipairs(Isaac.FindByType(EntityType.ENTITY_EFFECT, EffectVariant.RAIN_DROP, -1)) do
			rain:Remove()
		end
		return 0.3
	end
end

local CallbackAdded = false
function CCO.AchievementDisplayAPI:OverrideControls(player, hook, action)
	if action >= ButtonAction.ACTION_BOMB
	and action <= ButtonAction.ACTION_MENUTAB then
		return false
	end
end

function CCO.AchievementDisplayAPI.PlayAchievement(gfxroot, duration)
	table.insert(AchievementQueue, {GfxRoot = gfxroot, Duration = duration or 90})
end

CCO.AchievementDisplayAPI:AddCallback(ModCallbacks.MC_POST_RENDER, function()
	if AchievementQueue[1] then
		if not game:IsPaused() then
			if (ModConfigMenu and ModConfigMenu.IsVisible) then
				ModConfigMenu.CloseConfigMenu()
			end
			if (DeadSeaScrollsMenu and DeadSeaScrollsMenu.OpenedMenu) then
				DeadSeaScrollsMenu:CloseMenu(true, true)
			end
			
			if not CallbackAdded then
				CallbackAdded = true
				CCO.AchievementDisplayAPI:AddCallback(ModCallbacks.MC_INPUT_ACTION, CCO.AchievementDisplayAPI.OverrideControls, InputHook.IS_ACTION_TRIGGERED)
				
				for p = 0, game:GetNumPlayers() - 1 do
					local player = Isaac.GetPlayer(p)
					local data = player:GetData()
					
					if not data.AchievementDisplayAPIControls then
						data.AchievementDisplayAPIControls = player.Velocity
						data.MenuDisabledControls = nil
						player.ControlsEnabled = false
						player.Velocity = Vector.Zero
					end
				end
			end
		
			if not AchievementQueue[1].Appear then
				AchievementSpr:Play("Appear", true)
				AchievementQueue[1].Appear = true
				
				if AchievementQueue[1].GfxRoot then
					AchievementSpr:ReplaceSpritesheet(3, AchievementQueue[1].GfxRoot)
					AchievementSpr:LoadGraphics()
				end
			end
			
			if AchievementSpr:IsFinished("Appear") then
				if not AchievementQueue[1].SoundPlayed then
					sound:Play(SoundEffect.SOUND_BOOK_PAGE_TURN_12, 1, 0, false, 1)
					AchievementQueue[1].SoundPlayed = true
				end
			
				if AchievementQueue[1].Duration <= 0 then
					AchievementSpr:Play("Dissapear", true)
				else
					AchievementQueue[1].Duration = AchievementQueue[1].Duration - 1
				end
			end
		
			if AchievementSpr:IsFinished("Dissapear") then
				table.remove(AchievementQueue, 1)
				
				if (not AchievementQueue[1]) and CallbackAdded then
					CallbackAdded = false
					CCO.AchievementDisplayAPI:RemoveCallback(ModCallbacks.MC_INPUT_ACTION, CCO.AchievementDisplayAPI.OverrideControls)
					
					for p = 0, game:GetNumPlayers() - 1 do
						local player = Isaac.GetPlayer(p)
						local data = player:GetData()
						
						if data.AchievementDisplayAPIControls then
							player.ControlsEnabled = true
							player.Velocity = data.AchievementDisplayAPIControls
							data.AchievementDisplayAPIControls = nil
						end
					end
				end
				
				return
			end
		end
		
		local CenterX, CenterY = GetScreenSize()
		AchievementSpr:Render(Vector(CenterX / 2, CenterY / 2), Vector.Zero, Vector.Zero)
		AchievementSpr:Update()
	end
end)
