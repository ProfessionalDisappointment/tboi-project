local AchievementBook = Sprite()
local AchievementBookOpen = false
AchievementBook:Load("gfx/ui/achievement_book.anm2")
guiopen = false

local function GetScreenSize() -- By Kilburn himself.
  local room = Game():GetRoom()
  local pos = Isaac.WorldToScreen(Vector(0, 0)) - room:GetRenderScrollOffset() - Game().ScreenShakeOffset

  local rx = pos.X + 60 * 26 / 40
  local ry = pos.Y + 140 * (26 / 40)

  return rx * 2 + 13 * 26, ry * 2 + 7 * 26
end

local posx, posy = GetScreenSize()

function DEGENMOD:PageInit(_DEGENMOD)
	AchievementBook:Play("Idle", true)
end

function DEGENMOD:onUpdateAchievementBook(_DEGENMOD)
	if GameState["Enable Achievement Tracker"] then
		if Input.IsButtonTriggered(Keyboard.KEY_C, 0) then
			if guiopen == false then
				sound:Play(SoundEffect.SOUND_BOOK_PAGE_TURN_12, 1, 0, false, 1)
				guiopen = true
				AchievementBook:Play("Open", true)
			elseif guiopen == true then
				sound:Play(SoundEffect.SOUND_BOOK_PAGE_TURN_12, 1, 0, false, 1)
				guiopen = false
				AchievementBook:Play("Close", true)
			end
		end
		
		if AchievementBook:IsFinished("Open") then
			DEGENMOD:PageInit()
		end
		
		if guiopen == true then
			if Input.IsButtonTriggered(Keyboard.KEY_U, 0) and AchievementBookPage ~= 5 then
				AchievementBook:Play("TurnPageRight", false)
			elseif Input.IsButtonTriggered(Keyboard.KEY_Y, 0) and AchievementBookPage ~= 1 then
				AchievementBook:Play("TurnPageLeft", false)
			end
			if AchievementBook:IsFinished("TurnPageRight") then
				sound:Play(SoundEffect.SOUND_PAPER_IN, 1, 0, false, 1)
				AchievementBookPage = AchievementBookPage + 1
				DEGENMOD:PageInit()
			elseif AchievementBook:IsFinished("TurnPageLeft") then
				sound:Play(SoundEffect.SOUND_PAPER_OUT, 1, 0, false, 1)
				AchievementBookPage = AchievementBookPage - 1
				DEGENMOD:PageInit()
			end
		end
		local CenterX, CenterY = GetScreenSize()
		AchievementBook:Render(Vector(CenterX / 2, CenterY / 2), Vector.Zero, Vector.Zero)
		AchievementBook:Update()
	end
end

function DEGENMOD:RegisterNew(_DEGENMOD)
	if fb.Variant == 0 then
		CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievements/achievement_image_unlock.png")
		--GameState["Unlocked 1st Polaroid"] = true
	end
end

DEGENMOD:AddCallback(ModCallbacks.MC_POST_RENDER, DEGENMOD.onUpdateAchievementBook)