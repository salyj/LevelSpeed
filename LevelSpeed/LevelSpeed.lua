LevelSpeed = LibStub("AceAddon-3.0"):NewAddon("LevelSpeed")

function LevelSpeed:OnInitialize()
	LSCreate_Elements()
end

function OnLogin()
	loginTime = time()
	loginMoney = GetMoney()
	if lsElements.showTotalXP then
		totalXPValue:SetText(calculateTotalXP())
	end
end

round = false
lastKillXP = 0
justLeveledUp = false
currentMoney = 0
deltaMoney = 0

function getStuff()
_XP = 0
start = time()
--

start2 = 0
mob_xp = 0
lastKill = 0
countKills = 0
reset = 0
currentMoney = GetMoney()
deltaMoney = 0

loginMoney = GetMoney()
loginTime = time()
--
updateNums()
print("\124cffff0000Level Speed: Reset complete.\124r")

end

function getStuff2()
	start2 = time()
	mob_xp = 0
	lastKill = 0
	countKills = 0

end

function calculateTotalXP()
	local levelIterator = 1
	local totalXP = 0
	
	while(levelIterator < UnitLevel("player")) do
		totalXP = totalXP + lsTBCLevelMaxXP[levelIterator]
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
		if lsElements.showKillsToLevel then
			if mob_xp > 0 and countKills > 0 then
				kills_toLevel2:SetText(math.ceil(math.floor((UnitXPMax("player") - (UnitXP("player")))/(mob_xp / countKills)*100)/100))
				--xpps3:SetText(math.floor(mob_xp / (time() -start2)*100)/100)
			else
				kills_toLevel2:SetText(0)
			end
		end
	end
	
end
if b == "PLAYER_LEVEL_UP" then
	justLeveledUp = true
	
end

if b == "PLAYER_XP_UPDATE" then
	if justLeveledUp == true then
		local newLevelMaxXP = UnitXPMax("player")
		
		if lsElements.showTimeToLevel then
			if _XPS > 0 then
				kills_toLevel:SetText( math.floor(newLevelMaxXP / _XPS / 60*100)/100 )
			end
		end
		if lsElements.showKillsToLevel then
			if mob_xp > 0 and countKills > 0 then
				kills_toLevel2:SetText(math.ceil(math.floor((newLevelMaxXP/(mob_xp / countKills)*100)/100)))
			end
		end
		
		-- Reset the flag
		justLeveledUp = false
	end

	if lsElements.showTotalXP then
		totalXPValue:SetText(calculateTotalXP())
	end
end

if b == "PLAYER_REGEN_DISABLED" then
	if start2 == 0 then
		start2 = time()
	end
	if time() - lastKill > 45 then
		
		if lsElements.showFarmXPS then
			xpps3:SetText("Start..")
		end
		getStuff2()
	end
end

if b == "CHAT_MSG_COMBAT_XP_GAIN"then
	if string.find(c, " dies," ) then
		_,c  = string.split(",",c,2)
		_,_,_,c,_ = string.split(" ",c,5)
		_XP = _XP + c
		mob_xp = mob_xp + c

		if lsElements.showLastKillXP then
			lastKillXP = c;
			lastKillXPValue:SetText(lastKillXP)
		end
		
		lastKill = time()
		countKills = countKills + 1

		if lsElements.showKillsToLevel then
			kills_toLevel2:SetText(math.ceil(math.floor((UnitXPMax("player") - (UnitXP("player")+c))/(mob_xp / countKills)*100)/100))
		end

		if lsElements.showFarmXPS then
			xpps3:SetText(math.floor(mob_xp / (time() -start2)*100)/100)
		end
		updateNums()
	else
		_,_,c,_ = string.split(" ",c,4)
		_XP = _XP + c
		
		updateNums()

	end
end

if b == "ADDON_LOADED" and c == "LevelSpeed" then
	OnLogin()
end

if b == "PLAYER_MONEY" then
	-- print("You earned "..GetMoney() - currentMoney.." copper at"..time()..".")
	-- print("You have earned "..(((GetMoney() - loginMoney) / (time() - loginTime)) * 60 * 60).." copper per hour since login.")

	deltaMoney = (((GetMoney() - loginMoney) / (time() - loginTime)) * 60 * 60)

	deltaGold = math.floor(deltaMoney / 10000)
	deltaSilver = math.floor((deltaMoney % 10000) / 100)
	deltaCopper = math.floor(deltaMoney % 100)

	if lsElements.showGoldPerHour then
		goldPerHourValue:SetText(deltaGold.."g "..deltaSilver.."s "..deltaCopper.."c")
	end

    currentMoney = GetMoney()
end

end)
function updateNums()

	if reset == 0 then
		if lsElements.showTimeToLevel then
			kills_toLevel:SetText(0)
		end
		if lsElements.showAllXPS then
			xpps:SetText(0)
		end
		if lsElements.showKillsToLevel then
			kills_toLevel2:SetText(0)
		end
		if lsElements.showFarmXPS then
			xpps3:SetText(0)
		end
		if lsElements.showLastKillXP then
			lastKillXPValue:SetText(0)
		end
		if lsElements.showTotalXP then
			totalXPValue:SetText(calculateTotalXP())
		end
		if lsElements.showGoldPerHour then
			goldPerHourValue:SetText("0g 0s 0c")
		end
		
		reset = reset +1
	else



	diffTime = time() - start 
	_XPS = _XP / diffTime
	if lsElements.showAllXPS then
		xpps:SetText(math.floor(_XPS*100)/100)
	end
	
	maxXP = UnitXPMax("player")
	currXP = UnitXP("player")
	xpLeft = maxXP - currXP

	if lsElements.showTimeToLevel then
		kills_toLevel:SetText(math.floor(xpLeft / _XPS / 60*100)/100)
	end
	
	end
end