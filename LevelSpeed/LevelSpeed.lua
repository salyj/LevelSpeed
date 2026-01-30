LevelSpeed = LibStub("AceAddon-3.0"):NewAddon("LevelSpeed")

function LevelSpeed:OnInitialize()
	LVLSPD_LSCreate_Elements()
end

function LVLSPD_OnLogin()
	LVLSPD_loginTime = time()
	LVLSPD_loginMoney = GetMoney()
	if LVLSPD_lsElements.showTotalXP then
		LVLSPD_totalXPValue:SetText(LVLSPD_calculateTotalXP())
	end
end

LVLSPD_round = false
LVLSPD_lastKillXP = 0
LVLSPD_justLeveledUp = false
LVLSPD_currentMoney = 0
LVLSPD_deltaMoney = 0

function LVLSPD_getStuff()
LVLSPD_XP = 0
LVLSPD_start = time()
--

LVLSPD_start2 = 0
LVLSPD_mob_xp = 0
LVLSPD_lastKill = 0
LVLSPD_countKills = 0
LVLSPD_reset = 0
LVLSPD_currentMoney = GetMoney()
LVLSPD_deltaMoney = 0

LVLSPD_loginMoney = GetMoney()
LVLSPD_loginTime = time()
--
LVLSPD_updateNums()

end

function LVLSPD_getStuff2()
	LVLSPD_start2 = time()
	LVLSPD_mob_xp = 0
	LVLSPD_lastKill = 0
	LVLSPD_countKills = 0

end

function LVLSPD_calculateTotalXP()
	local levelIterator = 1
	local totalXP = 0
	
	while(levelIterator < UnitLevel("player")) do
		totalXP = totalXP + LVLSPD_lsTBCLevelMaxXP[levelIterator]
		levelIterator = levelIterator + 1
	end

	totalXP = totalXP + UnitXP("player")

	return totalXP
end



local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("CHAT_MSG_COMBAT_XP_GAIN")
eventFrame:RegisterEvent("CHAT_MSG_SYSTEM")
eventFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
eventFrame:RegisterEvent("PLAYER_LEVEL_UP")
eventFrame:RegisterEvent("PLAYER_XP_UPDATE")
eventFrame:RegisterEvent("PLAYER_MONEY")
eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:SetScript("OnEvent", function(a,b,c,d,e,f,g,h,i,j)

if  b == "CHAT_MSG_SYSTEM" and string.find(c, "Experience gained:") then
	_,c = string.split(":", c,2)
	c,_ = string.split(".",c,2)
	
	if (UnitXPMax("player") - UnitXP("player")) > tonumber(c) then
		if LVLSPD_lsElements.showKillsToLevel then
			if LVLSPD_mob_xp > 0 and LVLSPD_countKills > 0 then
				LVLSPD_kills_toLevel2:SetText(math.ceil(math.floor((UnitXPMax("player") - (UnitXP("player")))/(LVLSPD_mob_xp / LVLSPD_countKills)*100)/100))
				--xpps3:SetText(math.floor(mob_xp / (time() -start2)*100)/100)
			else
				LVLSPD_kills_toLevel2:SetText(0)
			end
		end
	end
	
end
if b == "PLAYER_LEVEL_UP" then
	LVLSPD_justLeveledUp = true
	
end

if b == "PLAYER_XP_UPDATE" then
	if LVLSPD_justLeveledUp == true then
		local newLevelMaxXP = UnitXPMax("player")
		
		if LVLSPD_lsElements.showTimeToLevel then
			if LVLSPD_XPS > 0 then
				LVLSPD_kills_toLevel:SetText( math.floor(newLevelMaxXP / LVLSPD_XPS / 60*100)/100 )
			end
		end
		if LVLSPD_lsElements.showKillsToLevel then
			if LVLSPD_mob_xp > 0 and LVLSPD_countKills > 0 then
				LVLSPD_kills_toLevel2:SetText(math.ceil(math.floor((newLevelMaxXP/(LVLSPD_mob_xp / LVLSPD_countKills)*100)/100)))
			end
		end
		
		-- Reset the flag
		LVLSPD_justLeveledUp = false
	end

	if LVLSPD_lsElements.showTotalXP then
		LVLSPD_totalXPValue:SetText(LVLSPD_calculateTotalXP())
	end
end

if b == "PLAYER_REGEN_DISABLED" then
	if LVLSPD_start2 == 0 then
		LVLSPD_start2 = time()
	end
	if time() - LVLSPD_lastKill > 45 then
		
		if LVLSPD_lsElements.showFarmXPS then
			LVLSPD_xpps3:SetText("Start..")
		end
		LVLSPD_getStuff2()
	end
end

if b == "CHAT_MSG_COMBAT_XP_GAIN"then
	if string.find(c, " dies," ) then
		_,c  = string.split(",",c,2)
		_,_,_,c,_ = string.split(" ",c,5)
		LVLSPD_XP = LVLSPD_XP + c
		LVLSPD_mob_xp = LVLSPD_mob_xp + c

		if LVLSPD_lsElements.showLastKillXP then
			LVLSPD_lastKillXP = c;
			LVLSPD_lastKillXPValue:SetText(LVLSPD_lastKillXP)
		end
		
		LVLSPD_lastKill = time()
		LVLSPD_countKills = LVLSPD_countKills + 1

		if LVLSPD_lsElements.showKillsToLevel then
			LVLSPD_kills_toLevel2:SetText(math.ceil(math.floor((UnitXPMax("player") - (UnitXP("player")+c))/(LVLSPD_mob_xp / LVLSPD_countKills)*100)/100))
		end

		if LVLSPD_lsElements.showFarmXPS then
			LVLSPD_xpps3:SetText(math.floor(LVLSPD_mob_xp / (time() -LVLSPD_start2)*100)/100)
		end
		LVLSPD_updateNums()
	else
		_,_,c,_ = string.split(" ",c,4)
		LVLSPD_XP = LVLSPD_XP + c
		
		LVLSPD_updateNums()

	end
end

if b == "ADDON_LOADED" and c == "LevelSpeed" then
	LVLSPD_OnLogin()
end

if b == "PLAYER_MONEY" then
	-- print("You earned "..GetMoney() - currentMoney.." copper at"..time()..".")
	-- print("You have earned "..(((GetMoney() - loginMoney) / (time() - loginTime)) * 60 * 60).." copper per hour since login.")

	LVLSPD_deltaMoney = (((GetMoney() - LVLSPD_loginMoney) / (time() - LVLSPD_loginTime)) * 60 * 60)

	LVLSPD_deltaGold = math.floor(LVLSPD_deltaMoney / 10000)
	LVLSPD_deltaSilver = math.floor((LVLSPD_deltaMoney % 10000) / 100)
	LVLSPD_deltaCopper = math.floor(LVLSPD_deltaMoney % 100)

	if LVLSPD_lsElements.showGoldPerHour then
		LVLSPD_goldPerHourValue:SetText(LVLSPD_deltaGold.."g "..LVLSPD_deltaSilver.."s "..LVLSPD_deltaCopper.."c")
	end

    LVLSPD_currentMoney = GetMoney()
end

end)
function LVLSPD_updateNums()

	if LVLSPD_reset == 0 then
		if LVLSPD_lsElements.showTimeToLevel then
			LVLSPD_kills_toLevel:SetText(0)
		end
		if LVLSPD_lsElements.showAllXPS then
			LVLSPD_xpps:SetText(0)
		end
		if LVLSPD_lsElements.showKillsToLevel then
			LVLSPD_kills_toLevel2:SetText(0)
		end
		if LVLSPD_lsElements.showFarmXPS then
			LVLSPD_xpps3:SetText(0)
		end
		if LVLSPD_lsElements.showLastKillXP then
			LVLSPD_lastKillXPValue:SetText(0)
		end
		if LVLSPD_lsElements.showTotalXP then
			LVLSPD_totalXPValue:SetText(LVLSPD_calculateTotalXP())
		end
		if LVLSPD_lsElements.showGoldPerHour then
			LVLSPD_goldPerHourValue:SetText("0g 0s 0c")
		end
		
		LVLSPD_reset = LVLSPD_reset +1
	else



	LVLSPD_diffTime = time() - LVLSPD_start 
	LVLSPD_XPS = LVLSPD_XP / LVLSPD_diffTime
	if LVLSPD_lsElements.showAllXPS then
		LVLSPD_xpps:SetText(math.floor(LVLSPD_XPS*100)/100)
	end
	
	LVLSPD_maxXP = UnitXPMax("player")
	LVLSPD_currXP = UnitXP("player")
	LVLSPD_xpLeft = LVLSPD_maxXP - LVLSPD_currXP

	if LVLSPD_lsElements.showTimeToLevel then
		LVLSPD_kills_toLevel:SetText(math.floor(LVLSPD_xpLeft / LVLSPD_XPS / 60*100)/100)
	end
	
	end
end