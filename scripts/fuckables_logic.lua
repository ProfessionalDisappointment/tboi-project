characterdirectory = {
	--NOTES = 
	--* Invalid textures for Head & Body come up as transparent/invisible in the game
	--* Current max amount of coins is capped at 30. I am too lazy to make frames.
	Isaac = {HeadSkin = "gfx/screwable/fb_isaac_head_part.png",
				BodySkin = "gfx/screwable/fb_torso_male.png",

				PriceOfCharacter = 5,

				UnlockRequirements = nil
				},
	Magdalene = {HeadSkin = "gfx/screwable/fb_magdalene_head_part.png",
				BodySkin = "gfx/screwable/fb_torso_female.png",

				PriceOfCharacter = 7,

				UnlockRequirements = nil
				},
	Cain = {HeadSkin = "gfx/screwable/fb_cain_head_part.png",
				BodySkin = "gfx/screwable/fb_torso_male.png",

				PriceOfCharacter = 7,

				UnlockRequirements = nil
				},
	 Eve = {HeadSkin = "gfx/screwable/fb_eve_head_part.png",
				BodySkin = "gfx/screwable/fb_torso_female.png",

				PriceOfCharacter = 3,

				UnlockRequirements = nil
				},
	Bethany = {HeadSkin = "gfx/screwable/fb_bethany_head_part.png",
				BodySkin = "gfx/screwable/fb_torso_female.png",

				PriceOfCharacter = 15,

				UnlockRequirements = nil
				},
	FemIsaac = {HeadSkin = "gfx/screwable/fb_femisaac_head_part.png",
				BodySkin = "gfx/screwable/fb_torso_female.png",

				PriceOfCharacter = 5,

				UnlockRequirements = nil
				},
	FemCain = {HeadSkin = "gfx/screwable/fb_femcain_head_part.png",
				BodySkin = "gfx/screwable/fb_torso_female.png",

				PriceOfCharacter = 5,

				UnlockRequirements = nil
				},
	FemLaz = {HeadSkin = "gfx/screwable/fb_femlaz_head_part.png",
				BodySkin = "gfx/screwable/fb_torso_female.png",

				PriceOfCharacter = 10,

				UnlockRequirements = nil
				},
}

--convert existing indexes to numbers instead manually doing it
--thank you lua in general for not allowing me to just use the # symbol... NooOoo they need to be specifically key-d so it works
local vi = 0
for i in pairs(characterdirectory) do
	vi = vi + 1
	characterdirectory[vi] = i
end


local hotkeyUIEnabled = false
local numberUIEnabled = false

local fb = nil
local p = false --i hate this i need this for the position check but i hate this i hate this
local paidCharacter = false
local pointsuntilfinish = 0
local inputdisabled = false

--preload UIs and stuff meant specifically for the fuckening
local hotkeyUI = Sprite()
hotkeyUI:Load("gfx/ui/uiHotkeys.anm2")

local numberUI = Sprite()
numberUI:Load("gfx/ui/uiHotkeys_numbers.anm2")

local sexbarUI = Sprite()
sexbarUI:Load("gfx/ui/uiProgressBar.anm2")

function DEGENMOD:resetVariables(softResetFlag)
	if softResetFlag then
		--zoom stats
		zoomLevelFloat = 1
		zoomXPosFloat = 0.2
		zoomYPosFloat = -0.1

		--character related assets
		paidcharacter = false
		p = false

		--ui related assets
		hotkeyUI_ID = 0
		hotkeyUIEnabled = false
		numberUIEnabled = false
		pointsuntilfinish = 0
		sexbarUI:SetFrame("Idle", 0)
		numberUI:SetFrame("Idle", 0)
		hotkeyUI:SetFrame("Idle", 0)
		autoTimer = GameState["autoTimerMaxRate"]
		auto_enable = false

		--misc assets, locking / more UI
		globalAchievementBookLock = false
		AchievementBookOpen = false
		AchievementBookPage = 0
		guiopen = false
		if AchievementBook then
			AchievementBook:SetFrame("Close", 40)
		end
	else
		--zoom stats
		zoomLevelFloat = 1
		zoomXPosFloat = 0.2
		zoomYPosFloat = -0.1

		--character related assets
		fb = nil
		paidCharacter = false
		p = false

		--ui related assets
		hotkeyUI_ID = 0
		hotkeyUIEnabled = false
		numberUIEnabled = false
		sexbarUI:SetFrame("Idle", 0)
		numberUI:SetFrame("Idle", 0)
		hotkeyUI:SetFrame("Idle", 0)

		--action assets
		pointsuntilfinish = 0
		auto_enable = false

		--cache assets
		cachedfbType_Anim = 0

		--misc assets, locking / more UI
		globalAchievementBookLock = false
		AchievementBookPage = 0
		guiopen = false
		achievementBookHotkeyTimer = 0
		if AchievementBook then
			AchievementBook:SetFrame("Close", 40)
		end
	end
end

--WHY
function DEGENMOD:getCurrentCharID(player)
	if player:GetPlayerType() == PlayerType.PLAYER_ISAAC then --Isaac
		currentCharSessID = 0
	elseif player:GetPlayerType() == PlayerType.PLAYER_MAGDALENA then
		currentCharSessID = 1
	elseif player:GetPlayerType() == PlayerType.PLAYER_CAIN then
		currentCharSessID = 2
	elseif player:GetPlayerType() == PlayerType.PLAYER_JUDAS then
		currentCharSessID = 3
	elseif player:GetPlayerType() == PlayerType.PLAYER_BLUEBABY then
		currentCharSessID = 4
	elseif player:GetPlayerType() == PlayerType.PLAYER_EVE then
		currentCharSessID = 5
	elseif player:GetPlayerType() == PlayerType.PLAYER_SAMSON then
		currentCharSessID = 6
	elseif player:GetPlayerType() == PlayerType.PLAYER_AZAZEL then
		currentCharSessID = 7
	elseif player:GetPlayerType() == PlayerType.PLAYER_LAZARUS then
		currentCharSessID = 8
	elseif player:GetPlayerType() == PlayerType.PLAYER_EDEN then
		currentCharSessID = 9
	elseif player:GetPlayerType() == PlayerType.PLAYER_THELOST then
		currentCharSessID = 10
	end
	DEGENMOD:PlayerCostumesInit(currentCharSessID, player)
end

--hello past me i hope you're proud i fixed this sphagetti shit
function DEGENMOD:initFloor()
	--holy SHIT why do I need to do this for seed specific randomness??????? why do I have to manually declare this when it's an important part of mods??
	local seed = Game():GetSeeds():GetStartSeed()
	local rng = RNG()
	rng:SetSeed(seed, 35)

	print(rng:RandomInt(100))
	runCurrPlayerCharIndex = characterdirectory[Isaac.GetPlayer(0):GetPlayerType() + 1] --(+1) to compensate for the list starting at 1
	randCurrBrothelCharIndex = characterdirectory[rng:RandomInt(#characterdirectory) + 1] --(+1) to compensate for RandomInt going from 0 to max-1
end

function DEGENMOD:checkforCharactersInRoom()
	for i,fuckableCharacter in pairs(Isaac.GetRoomEntities()) do
		if fuckableCharacter.Type == 979 then
			fb = fuckableCharacter
			fbSprite = fb:GetSprite()
			fbCurrPos = fb.Position

			--what a misleading name... "replacespritesheet"... turns out that it actually doesn't replace spritesheets in anim files and instead makes a new one which it replaces and attaches to a layer ID inside the anm2.
			--this is actual vomit oh my god
			fbSprite:ReplaceSpritesheet(1, characterdirectory[randCurrBrothelCharIndex].HeadSkin)
			fbSprite:ReplaceSpritesheet(3, characterdirectory[randCurrBrothelCharIndex].HeadSkin)
			fbSprite:ReplaceSpritesheet(0, characterdirectory[randCurrBrothelCharIndex].BodySkin)
			fbSprite:ReplaceSpritesheet(2, characterdirectory[randCurrBrothelCharIndex].BodySkin)
			
			if GameState["Character Replace during Scene"] == true then
				fbSprite:ReplaceSpritesheet(9, characterdirectory[runCurrPlayerCharIndex].HeadSkin)
				fbSprite:ReplaceSpritesheet(4, characterdirectory[runCurrPlayerCharIndex].HeadSkin)
				fbSprite:ReplaceSpritesheet(6, characterdirectory[runCurrPlayerCharIndex].HeadSkin)
				fbSprite:ReplaceSpritesheet(8, characterdirectory[runCurrPlayerCharIndex].BodySkin)
				fbSprite:ReplaceSpritesheet(5, characterdirectory[runCurrPlayerCharIndex].BodySkin)
				fbSprite:ReplaceSpritesheet(7, characterdirectory[runCurrPlayerCharIndex].BodySkin)
			end

			fbSprite:LoadGraphics()
			fbSprite:Play("idle", true)
		else
			DEGENMOD:resetVariables(true)
		end
	end
	
	--custom backdrops are a pain in the ass so i'm checking whether the room qualifies as a brothel room by searching for the brothel bed entity and spawning the entire backdrop entity way back in depthoffset.
	--i WOULD change it to a system where room IDs are checked instead but that'd interfere with a bunch of mods that would add in new rooms and shit due to incrementing so... mightaswell anchor detection onto smn else
	for i,brothelAssets in pairs(Isaac.GetRoomEntities()) do
		if brothelAssets.Type == 981 then
			brothelBed = brothelAssets
			brothelBedSprite = brothelBed:GetSprite()

			BrothelBackdropWall = Isaac.Spawn(982, 0, 0, Vector(320,280), Vector(0,0), nil)
			BrothelBackdropWall.EntityCollisionClass = EntityCollisionClass.ENTCOLL_NONE
			BrothelBackdropWall.DepthOffset = -999

			BrothelBackdropWall:GetSprite():SetFrame(math.random(0,3))
		elseif brothelAssets.Type == 980 then
			brothelPriceIndicator = brothelAssets

			brothelPriceIndicator:GetSprite():SetFrame(characterdirectory[randCurrBrothelCharIndex].PriceOfCharacter)
			brothelPriceIndicator.DepthOffset = -998
		end
	end
end

function DEGENMOD:onFuckableCharacter(_DEGENMOD)
	if fb then
		fb.EntityCollisionClass = EntityCollisionClass.ENTCOLL_PLAYERONLY

		--pay animation & retract coins
		DEGENMOD:setPriceofCharacter(brothelPriceIndicator, characterdirectory[randCurrBrothelCharIndex].PriceOfCharacter)
		
		--qualifies for the big sex after payment n shit
		if paidCharacter == true then
			--call new collectible register flag n shit
			--DEGENMOD:RegisterNewCollectible(TYPE/ID HERE)
			
			if fbSprite:IsEventTriggered("paySfx") then
				sound:Play(SoundEffect.SOUND_SCAMPER, 1, 0, false, 1)
			end

			if fbSprite:IsFinished("pay") and p == false then
				p = true
				fb.Position = Vector(fb.Position.X, fb.Position.Y - 115)
				fbCurrPos = Vector(fb.Position.X - 40, fb.Position.Y - 115)
				fbSprite:Play("idlealt", true)
				brothelBedSprite:SetFrame(1)
			end
			
			if p == true then
				--key type, animid, animation type, locks character, increases points, quit flag
				DEGENMOD:switchAnimations(Keyboard.KEY_1, 1, "cowgirlanim", true, true, false)
				DEGENMOD:switchAnimations(Keyboard.KEY_2, 2, "frombackanim", true, true, false)
				DEGENMOD:switchAnimations(Keyboard.KEY_3, 3, "missionaryanim", true, true, false)
				DEGENMOD:switchAnimations(Keyboard.KEY_Y, 5, "idlealt", false, false, true) --5 is slotted to nothing
				DEGENMOD:finishAnimations(Keyboard.KEY_I, true)
				
				if fbSprite:IsEventTriggered("smackSfx") then
					sound:Play(Isaac.GetSoundIdByName("SMACK_REGULAR"), 1, 0, false, 1)
				end
				
				if fbSprite:IsEventTriggered("cumSfx") then
					sound:Play(Isaac.GetSoundIdByName("SMACK_SLOPPY"), 1, 0, false, 1)
				end
				
				--Enable and Disable UI during Brothel Sex
				if Input.IsButtonTriggered(Keyboard.KEY_T, 0) then
					if hotkeyUIEnabled == false then
						hotkeyUIEnabled = true
						numberUIEnabled = true
						hotkeyUI:Play("Appear", true)
						numberUI:Play("Appear", true)
						hotkeyUI_ID = 1
					elseif hotkeyUIEnabled == true then
						hotkeyUIEnabled = false
						numberUIEnabled = false
						hotkeyUI:Play("Disappear", true)
						numberUI:Play("Disappear", true)
						hotkeyUI_ID = 0
					end
				end
				
				--AUTO MODE
				if Input.IsButtonTriggered(Keyboard.KEY_V, 0) and cachedfbType_Anim ~= 5 then
					DEGENMOD:manageAutoMode(true)
				end

				if pointsuntilfinish >= 101 then
					pointsuntilfinish = 101
				end
				
				if hotkeyUI:IsFinished("Appear") or hotkeyUI:IsFinished("Disappear")  then
					hotkeyUI:SetFrame("Idle", hotkeyUI_ID)
				end
				
				hotkeyUI:Render(Vector(fbCurrPos.X, fbCurrPos.Y), Vector.Zero, Vector.Zero)
				hotkeyUI:Update()
				numberUI:Render(Vector(fbCurrPos.X, fbCurrPos.Y), Vector.Zero, Vector.Zero)
				numberUI:Update()
				sexbarUI:Render(Vector(fbCurrPos.X, fbCurrPos.Y), Vector.Zero, Vector.Zero)
				sexbarUI:Update()
			end
		end
	end
end

function DEGENMOD:setPriceofCharacter(priceEntity, Price)
	local player = Isaac.GetPlayer()
	if player:GetNumCoins() >= Price then
		if (fb.Position - player.Position):Length() <= fb.Size + player.Size and paidCharacter == false then
			fbSprite:Play("pay", true)
			player:AddCoins(-Price)
			paidCharacter = true
			priceEntity:Remove()
		end
	end
end

function DEGENMOD:switchAnimations(KeyboardHotkey, fbanimID, fbanimSprite, playerToggleInput, increasePoints, quitExcept)
	if Input.IsButtonTriggered(KeyboardHotkey, 0) then
		if increasePoints == true then
			pointsuntilfinish = pointsuntilfinish + 1
		end
		if numberUIEnabled == true then
			numberUI:SetFrame("Idle", fbanimID)
		end
		if quitExcept == true then
			globalAchievementBookLock = false
			auto_enable = false
			zoomLevelFloat = 1
		else
			brothelBedSprite:Play("Move", true)
			if GameState["Shader Zooming"] == true then
				zoomLevelFloat = GameState["shaderZoomInMultiplier"]
			end
		end

		sexbarUI:SetFrame("Idle", pointsuntilfinish)
		globalAchievementBookLock = true
		DEGENMOD:ToggleInputFX(playerToggleInput)
		DEGENMOD:manageAutoMode()
		fbSprite:Play(fbanimSprite, true)

		cachedfbType_Anim = fbanimID
		print(cachedfbType_Anim)
	end
end

--todo : flesh out so it's not aids, find a solution for animtype 0
function DEGENMOD:finishAnimations(KeyboardHotkey, playerToggleInput)
	if Input.IsButtonTriggered(KeyboardHotkey, 0) and pointsuntilfinish >= 101 then
		pointsuntilfinish = 1
		auto_enable = false
		brothelBedSprite:SetFrame(3)

		DEGENMOD:manageAutoMode()
		sexbarUI:SetFrame("Idle", pointsuntilfinish)

		if cachedfbType_Anim == 1 then
			fbSprite:Play("cowgirlanimfinish", true)
		elseif cachedfbType_Anim == 2 then
			fbSprite:Play("frombackanimfinish", true)
		elseif cachedfbType_Anim == 3 then
			fbSprite:Play("missionaryanimfinish", true)
		end
	end
end

function DEGENMOD:ToggleInputFX(locked)
	if locked == false then
		Isaac.GetPlayer().ControlsEnabled = true
		Isaac.GetPlayer().Visible = true
	elseif locked == true then
		Isaac.GetPlayer().ControlsEnabled = false
		Isaac.GetPlayer().Visible = false
	end
end

--3,4 unlock
--1,2 lock

--flag is used to check if it needs to be toggled or not
function DEGENMOD:manageAutoMode(toggle)
	if toggle then
		if auto_enable == false then
			auto_enable = true
		elseif auto_enable == true then
			auto_enable = false
		end
	end

	if hotkeyUIEnabled == true then
		if auto_enable == false then
			if pointsuntilfinish >= 101 then
				hotkeyUI:SetFrame("Idle", 3)
			elseif pointsuntilfinish < 101 then
				hotkeyUI:SetFrame("Idle", 1)
			end
		elseif auto_enable == true then
			if pointsuntilfinish >= 101 then
				hotkeyUI:SetFrame("Idle", 4)
			elseif pointsuntilfinish < 101 then
				hotkeyUI:SetFrame("Idle", 2)
			end
		end
	end
end

function DEGENMOD:autoTimerLogic()
	if auto_enable == true then
		if autoTimer >= 0 then
			autoTimer = autoTimer - 1
		elseif autoTimer < 0 then
			autoTimer = GameState["autoTimerMaxRate"]
		end

		if autoTimer == GameState["autoTimerMaxRate"] - 10 then
			brothelBedSprite:Play("Move", true)
			if cachedfbType_Anim == 1 then
				fbSprite:Play("cowgirlanim", true)
			elseif cachedfbType_Anim == 2 then
				fbSprite:Play("frombackanim", true)
			elseif cachedfbType_Anim == 3 then
				fbSprite:Play("missionaryanim", true)
			end
			if cachedfbType_Anim ~= 5 then
				pointsuntilfinish = pointsuntilfinish + 1
				sexbarUI:SetFrame("Idle", pointsuntilfinish)
			end
		end
	end
end

function DEGENMOD:GetShaderParams(shaderName)
    if shaderName == 'ZoomInShader' then
		local params = {
			ZoomPos = 0.25,
			ZoomLevel = zoomLevelFloat
		}
        return params;
    end
end

DEGENMOD:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, DEGENMOD.resetVariables)
DEGENMOD:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, DEGENMOD.checkforCharactersInRoom)
DEGENMOD:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, DEGENMOD.initFloor)
DEGENMOD:AddCallback(ModCallbacks.MC_POST_RENDER, DEGENMOD.onFuckableCharacter)
DEGENMOD:AddCallback(ModCallbacks.MC_POST_RENDER, DEGENMOD.autoTimerLogic)
DEGENMOD:AddCallback(ModCallbacks.MC_GET_SHADER_PARAMS, DEGENMOD.GetShaderParams)