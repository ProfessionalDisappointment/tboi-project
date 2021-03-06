AchievementBook = Sprite()
AchievementBookHotkey = Sprite()
AchievementBookOpen = false
AchievementBookPage = 0
AchievementBookHotkeyTimer = 0
guiopen = false
AchievementBook:Load("gfx/ui/achievement_book.anm2")
AchievementBookHotkey:Load("gfx/ui/uiBookIndicator.anm2")

--todo : condense
function DEGENMOD:PageInit(_DEGENMOD)
	if AchievementBookPage == 0 then
		AchievementBook:SetFrame("Pages", 0)
	elseif AchievementBookPage == 1 and GameState["Unlocked Eve Collectible"] == true and GameState["Unlocked Bethany Collectible"] == true then
		AchievementBook:SetFrame("Pages", 1)
	elseif AchievementBookPage == 1 and GameState["Unlocked Eve Collectible"] == false and GameState["Unlocked Bethany Collectible"] == true then
		AchievementBook:SetFrame("Pages", 2)
	elseif AchievementBookPage == 1 and GameState["Unlocked Eve Collectible"] == true and GameState["Unlocked Bethany Collectible"] == false then
		AchievementBook:SetFrame("Pages", 3)
	elseif AchievementBookPage == 1 and GameState["Unlocked Eve Collectible"] == false and GameState["Unlocked Bethany Collectible"] == false then
		AchievementBook:SetFrame("Pages", 4)
		
	elseif AchievementBookPage == 2 and GameState["Unlocked Isaac Collectible"] == true and GameState["Unlocked Frisk Collectible"] == true then
		AchievementBook:SetFrame("Pages", 5)
	elseif AchievementBookPage == 2 and GameState["Unlocked Isaac Collectible"] == false and GameState["Unlocked Frisk Collectible"] == true then
		AchievementBook:SetFrame("Pages", 6)
	elseif AchievementBookPage == 2 and GameState["Unlocked Isaac Collectible"] == true and GameState["Unlocked Frisk Collectible"] == false then
		AchievementBook:SetFrame("Pages", 7)
	elseif AchievementBookPage == 2 and GameState["Unlocked Isaac Collectible"] == false and GameState["Unlocked Frisk Collectible"] == false then
		AchievementBook:SetFrame("Pages", 8)
		
	elseif AchievementBookPage == 3 and GameState["Unlocked FemLaz Collectible"] == true and GameState["Unlocked Cain Collectible"] == true then
		AchievementBook:SetFrame("Pages", 9)
	elseif AchievementBookPage == 3 and GameState["Unlocked FemLaz Collectible"] == true and GameState["Unlocked Cain Collectible"] == false then
		AchievementBook:SetFrame("Pages", 10)
	elseif AchievementBookPage == 3 and GameState["Unlocked FemLaz Collectible"] == false and GameState["Unlocked Cain Collectible"] == true then
		AchievementBook:SetFrame("Pages", 11)
	elseif AchievementBookPage == 3 and GameState["Unlocked FemLaz Collectible"] == false and GameState["Unlocked Cain Collectible"] == false then
		AchievementBook:SetFrame("Pages", 12)
	end
end

function DEGENMOD:onUpdateAchievementBook(_DEGENMOD)
	if GameState["Enable Achievement Tracker"] and globalAchievementBookLock ~= true then
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
			if Input.IsButtonTriggered(Keyboard.KEY_U, 0) and AchievementBookPage ~= 3 then --max pages
				AchievementBookPage = AchievementBookPage + 1
				AchievementBook:Play("TurnPageRight", false)
			elseif Input.IsButtonTriggered(Keyboard.KEY_Y, 0) and AchievementBookPage ~= 0 then
				AchievementBookPage = AchievementBookPage - 1
				AchievementBook:Play("TurnPageLeft", false)
			end
			
			if AchievementBook:IsFinished("TurnPageRight") then
				sound:Play(SoundEffect.SOUND_PAPER_IN, 1, 0, false, 1)
				DEGENMOD:PageInit()
			elseif AchievementBook:IsFinished("TurnPageLeft") then
				sound:Play(SoundEffect.SOUND_PAPER_OUT, 1, 0, false, 1)
				DEGENMOD:PageInit()
			end
		end
		
		if achievementBookHotkeyTimer <= 135 then
			AchievementBookHotkey:Play("Notif", false)
			AchievementBookHotkey:Render(Vector(Isaac.GetScreenWidth() / 1.25, Isaac.GetScreenHeight() / 1.10), Vector.Zero, Vector.Zero)
			AchievementBookHotkey:Update()
		end

		AchievementBook:Render(Vector(Isaac.GetScreenWidth() / 2, Isaac.GetScreenHeight() / 2), Vector.Zero, Vector.Zero)
		AchievementBook:Update()
	end
end

function DEGENMOD:RegisterNewCollectible(currentCachedChar)
	-- I am going to kill myself (currentChar = cachedFbType_Brothel that's initialized)
	if currentCachedChar == 0 and GameState["Unlocked Isaac Collectible"] == false then
		GameState["Unlocked Isaac Collectible"] = true
	end
end

function DEGENMOD:StartBookHotkeyTimer(_DEGENMOD)
	if GameState["Enable Hotkey Reminder"] then
		achievementBookHotkeyTimer = 140
	end
end

function DEGENMOD:ShowBookHotkey(_DEGENMOD)
	if achievementBookHotkeyTimer >= 0 then
		achievementBookHotkeyTimer = achievementBookHotkeyTimer - 1
	end
end

DEGENMOD:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, DEGENMOD.StartBookHotkeyTimer)
DEGENMOD:AddCallback(ModCallbacks.MC_POST_UPDATE, DEGENMOD.ShowBookHotkey)
DEGENMOD:AddCallback(ModCallbacks.MC_POST_RENDER, DEGENMOD.onUpdateAchievementBook)