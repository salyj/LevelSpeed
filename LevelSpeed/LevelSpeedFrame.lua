local numberOfElements = 0
local currentPoint = {}
LVLSPD_hideTitle = false
LVLSPD_numberCreatedElements = 0

function LVLSPD_getHideTitle()
    return LVLSPD_hideTitle
end

function LVLSPD_LSGetNumberOfElements()
    numberOfElements = 0
    for element, value in pairs(LVLSPD_lsElements) do
        if value == true then
            numberOfElements = numberOfElements + 1
        end
    end
end

function LVLSPD_resetPointsList(list)
    for i=0, #list do
        list[i][3] = false
    end
end

function LVLSPD_calculateElementPoint()
    LVLSPD_pointsList = {}
    LVLSPD_returnArray = {"CENTER", 0, 0}
    LVLSPD_foundPoint = false
    LVLSPD_loopIterator = 0

    if( not LVLSPD_hideTitle ) then
        if numberOfElements == 1 then
            LVLSPD_pointsList = LVLSPD_lsOneElePoints
        elseif numberOfElements == 2 then
            LVLSPD_pointsList = LVLSPD_lsTwoElePoints
        elseif numberOfElements == 3 then
            LVLSPD_pointsList = LVLSPD_lsThreeElePoints
        elseif numberOfElements == 4 then
            LVLSPD_pointsList = LVLSPD_lsFourElePoints
        elseif numberOfElements == 5 then
            LVLSPD_pointsList = LVLSPD_lsFiveElePoints
        elseif numberOfElements == 6 then
            LVLSPD_pointsList = LVLSPD_lsSixElePoints
        end
    else
        if numberOfElements == 1 then
            LVLSPD_pointsList = LVLSPD_lsOneElePointCom
        elseif numberOfElements == 2 then
            LVLSPD_pointsList = LVLSPD_lsTwoElePointsCom
        elseif numberOfElements == 3 then
            LVLSPD_pointsList = LVLSPD_lsThreeElePointsCom
        elseif numberOfElements == 4 then
            LVLSPD_pointsList = LVLSPD_lsFourElePointsCom
        elseif numberOfElements == 5 then
            LVLSPD_pointsList = LVLSPD_lsFiveElePointsCom
        elseif numberOfElements == 6 then
            LVLSPD_pointsList = LVLSPD_lsSixElePointsCom
        end
    end

    while(LVLSPD_foundPoint == false) do
        if LVLSPD_pointsList[LVLSPD_loopIterator][3] == false then
            LVLSPD_returnArray[0] = "CENTER"
            LVLSPD_returnArray[1] = LVLSPD_pointsList[LVLSPD_loopIterator][1]
            LVLSPD_returnArray[2] = LVLSPD_pointsList[LVLSPD_loopIterator][2]
            LVLSPD_pointsList[LVLSPD_loopIterator][3] = true
            LVLSPD_foundPoint = true
        else
            LVLSPD_loopIterator = LVLSPD_loopIterator + 1
        end
    end

    return LVLSPD_returnArray
end

function LVLSPD_setMainFrameSize()
    if( not LVLSPD_hideTitle ) then
        if numberOfElements <= 2 then
            LVLSPD_mainFrame:SetSize(235,75)
        elseif numberOfElements <= 4 then
            LVLSPD_mainFrame:SetSize(235,115)
        else
            LVLSPD_mainFrame:SetSize(320,115)
        end
    else
        if numberOfElements <= 2 then
            LVLSPD_mainFrame:SetSize(235,50)
        elseif numberOfElements <= 4 then
            LVLSPD_mainFrame:SetSize(235,90)
        else
            LVLSPD_mainFrame:SetSize(320,90)
        end
    end
end

LVLSPD_mainFrame = CreateFrame("Frame", "mainFrame_LocationMove", UIParent,"InsetFrameTemplate3")
LVLSPD_mainFrame:SetPoint("TOP",0,-10)

LVLSPD_mainFrame:SetMovable(true)
LVLSPD_mainFrame:EnableMouse(true)
LVLSPD_mainFrame:RegisterForDrag("LeftButton")
LVLSPD_mainFrame:SetScript("OnDragStart", function(self)
    self:StartMoving()
  end)
LVLSPD_mainFrame:SetScript("OnDragStop", function(self)
    self:StopMovingOrSizing()
  end)

if( not LVLSPD_hideTitle ) then
    LVLSPD_titleFrame = CreateFrame("Frame", nil, LVLSPD_mainFrame,"InsetFrameTemplate3")
    LVLSPD_titleFrame:SetPoint("TOP",0,0)
    LVLSPD_titleFrame:SetSize(200,25)

    LVLSPD_titleMain = LVLSPD_titleFrame:CreateFontString("ARTWORK", nil, "GameFontRed")
    LVLSPD_titleMain:SetPoint("CENTER")
    LVLSPD_titleMain:SetText("Level Speed")
end

function LVLSPD_LSCreate_Elements()

    LVLSPD_LSGetNumberOfElements()
    LVLSPD_setMainFrameSize()

    if LVLSPD_lsElements.showAllXPS and LVLSPD_numberCreatedElements < 6 then
        LVLSPD_xpps1 = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontGreen")
        currentPoint = LVLSPD_calculateElementPoint()
        LVLSPD_xpps1:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
        LVLSPD_xpps1:SetText("XP/s (All)")

        LVLSPD_xpps = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
        currentPoint = LVLSPD_calculateElementPoint()
        LVLSPD_xpps:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
        LVLSPD_xpps:SetText(0)

        LVLSPD_numberCreatedElements = LVLSPD_numberCreatedElements + 1
    end

    if LVLSPD_lsElements.showFarmXPS and LVLSPD_numberCreatedElements < 6 then
        LVLSPD_xpps4 = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontGreen")
        currentPoint = LVLSPD_calculateElementPoint()
        LVLSPD_xpps4:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
        LVLSPD_xpps4:SetText("XP/s (Farm)")

        LVLSPD_xpps3 = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
        currentPoint = LVLSPD_calculateElementPoint()
        LVLSPD_xpps3:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
        LVLSPD_xpps3:SetText(0)

        LVLSPD_numberCreatedElements = LVLSPD_numberCreatedElements + 1
    end

    if LVLSPD_lsElements.showTimeToLevel and LVLSPD_numberCreatedElements < 6 then
        LVLSPD_kills_toLevel1 = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontGreen")
        currentPoint = LVLSPD_calculateElementPoint()
        LVLSPD_kills_toLevel1:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
        LVLSPD_kills_toLevel1:SetText("Next Level (m)")

        LVLSPD_kills_toLevel = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
        currentPoint = LVLSPD_calculateElementPoint()
        LVLSPD_kills_toLevel:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
        LVLSPD_kills_toLevel:SetText(0)

        LVLSPD_numberCreatedElements = LVLSPD_numberCreatedElements + 1
    end

    if LVLSPD_lsElements.showKillsToLevel and LVLSPD_numberCreatedElements < 6 then
        LVLSPD_kills_toLevel3 = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontGreen")
        currentPoint = LVLSPD_calculateElementPoint()
        LVLSPD_kills_toLevel3:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
        LVLSPD_kills_toLevel3:SetText("Kills Left:")

        LVLSPD_kills_toLevel2 = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
        currentPoint = LVLSPD_calculateElementPoint()
        LVLSPD_kills_toLevel2:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
        LVLSPD_kills_toLevel2:SetText(0)

        LVLSPD_numberCreatedElements = LVLSPD_numberCreatedElements + 1
    end

    if LVLSPD_lsElements.showLastKillXP and LVLSPD_numberCreatedElements < 6 then
        LVLSPD_lastKillXPText = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontGreen")
        currentPoint = LVLSPD_calculateElementPoint()
        LVLSPD_lastKillXPText:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
        LVLSPD_lastKillXPText:SetText("Last Kill XP:")

        LVLSPD_lastKillXPValue = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
        currentPoint = LVLSPD_calculateElementPoint()
        LVLSPD_lastKillXPValue:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
        LVLSPD_lastKillXPValue:SetText(0)

        LVLSPD_numberCreatedElements = LVLSPD_numberCreatedElements + 1
    end

    if LVLSPD_lsElements.showTotalXP and LVLSPD_numberCreatedElements < 6 then
        LVLSPD_totalXPText = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontGreen")
        currentPoint = LVLSPD_calculateElementPoint()
        LVLSPD_totalXPText:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
        LVLSPD_totalXPText:SetText("Total XP:")

        LVLSPD_totalXPValue = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
        currentPoint = LVLSPD_calculateElementPoint()
        LVLSPD_totalXPValue:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
        LVLSPD_totalXPValue:SetText(LVLSPD_calculateTotalXP())

        LVLSPD_numberCreatedElements = LVLSPD_numberCreatedElements + 1
    end

    if LVLSPD_lsElements.showGoldPerHour and LVLSPD_numberCreatedElements < 6 then
        LVLSPD_goldPerHourText = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontGreen")
        currentPoint = LVLSPD_calculateElementPoint()
        LVLSPD_goldPerHourText:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
        LVLSPD_goldPerHourText:SetText("Gold/Hour:")

        LVLSPD_goldPerHourValue = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
        currentPoint = LVLSPD_calculateElementPoint()
        LVLSPD_goldPerHourValue:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
        LVLSPD_goldPerHourValue:SetText(GetMoneyString(0))

        LVLSPD_numberCreatedElements = LVLSPD_numberCreatedElements + 1
    end

    if LVLSPD_lsElements.showSessionGold and LVLSPD_numberCreatedElements < 6 then
        LVLSPD_sessionGoldText = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontGreen")
        currentPoint = LVLSPD_calculateElementPoint()
        LVLSPD_sessionGoldText:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
        LVLSPD_sessionGoldText:SetText("Session Gold:")

        LVLSPD_sessionGoldValue = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
        currentPoint = LVLSPD_calculateElementPoint()
        LVLSPD_sessionGoldValue:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
        LVLSPD_sessionGoldValue:SetText(GetMoneyString(0))

        LVLSPD_numberCreatedElements = LVLSPD_numberCreatedElements + 1
    end

    if LVLSPD_lsElements.showPlayerDeaths and LVLSPD_numberCreatedElements < 6 then
        LVLSPD_playerDeathsText = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontGreen")
        currentPoint = LVLSPD_calculateElementPoint()
        LVLSPD_playerDeathsText:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
        LVLSPD_playerDeathsText:SetText("Player Deaths:")

        LVLSPD_playerDeathsValue = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
        currentPoint = LVLSPD_calculateElementPoint()
        LVLSPD_playerDeathsValue:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
        LVLSPD_playerDeathsValue:SetText(LVLSPD_deathCount)

        LVLSPD_numberCreatedElements = LVLSPD_numberCreatedElements + 1
    end

    LVLSPD_getStuff()
end

-----------------------------------------------
-- There is probably a better way to do this --
-----------------------------------------------
function LVLSPD_LSHideAllElements()
    if(LVLSPD_xpps1 ~= nil) then
        LVLSPD_xpps1:Hide()
    end
    if(LVLSPD_xpps ~= nil) then
        LVLSPD_xpps:Hide()
    end
    if(LVLSPD_xpps4 ~= nil) then
        LVLSPD_xpps4:Hide()
    end
    if(LVLSPD_xpps3 ~= nil) then
        LVLSPD_xpps3:Hide()
    end
    if(LVLSPD_kills_toLevel1 ~= nil) then
        LVLSPD_kills_toLevel1:Hide()
    end
    if(LVLSPD_kills_toLevel ~= nil) then
        LVLSPD_kills_toLevel:Hide()
    end
    if(LVLSPD_kills_toLevel3 ~= nil) then
        LVLSPD_kills_toLevel3:Hide()
    end
    if(LVLSPD_kills_toLevel2 ~= nil) then
        LVLSPD_kills_toLevel2:Hide()
    end
    if(LVLSPD_lastKillXPText ~= nil) then
        LVLSPD_lastKillXPText:Hide()
    end
    if(LVLSPD_lastKillXPValue ~= nil) then
        LVLSPD_lastKillXPValue:Hide()
    end
    if(LVLSPD_totalXPText ~= nil) then
        LVLSPD_totalXPText:Hide()
    end
    if(LVLSPD_totalXPValue ~= nil) then
        LVLSPD_totalXPValue:Hide()
    end
    if(LVLSPD_goldPerHourText ~= nil) then
        LVLSPD_goldPerHourText:Hide()
    end
    if(LVLSPD_goldPerHourValue ~= nil) then
        LVLSPD_goldPerHourValue:Hide()
    end
    if(LVLSPD_sessionGoldText ~= nil) then
        LVLSPD_sessionGoldText:Hide()
    end
    if(LVLSPD_sessionGoldValue ~= nil) then
        LVLSPD_sessionGoldValue:Hide()
    end
    if(LVLSPD_playerDeathsText ~= nil) then
        LVLSPD_playerDeathsText:Hide()
    end
    if(LVLSPD_playerDeathsValue ~= nil) then
        LVLSPD_playerDeathsValue:Hide()
    end
end

function LVLSPD_LSRebuild_Elements()
    LVLSPD_LSGetNumberOfElements()
    LVLSPD_setMainFrameSize()
    LVLSPD_LSHideAllElements()
    LVLSPD_resetPointsList(LVLSPD_pointsList)
    LVLSPD_numberCreatedElements = 0

    if(LVLSPD_lsElements.showAllXPS and LVLSPD_numberCreatedElements < 6) then
        if(LVLSPD_xpps1) then
            currentPoint = LVLSPD_calculateElementPoint()
            LVLSPD_xpps1:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            LVLSPD_xpps1:Show()
        else
            LVLSPD_xpps1 = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontGreen")
            currentPoint = LVLSPD_calculateElementPoint()
            LVLSPD_xpps1:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            LVLSPD_xpps1:SetText("XP/s (All)")
        end

        if(LVLSPD_xpps) then
            currentPoint = LVLSPD_calculateElementPoint()
            LVLSPD_xpps:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            LVLSPD_xpps:Show()
        else
            LVLSPD_xpps = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
            currentPoint = LVLSPD_calculateElementPoint()
            LVLSPD_xpps:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            LVLSPD_xpps:SetText(0)    
        end
        
        LVLSPD_numberCreatedElements = LVLSPD_numberCreatedElements + 1
    end
    if(LVLSPD_lsElements.showFarmXPS and LVLSPD_numberCreatedElements < 6) then
        if(LVLSPD_xpps4) then
            currentPoint = LVLSPD_calculateElementPoint()
            LVLSPD_xpps4:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            LVLSPD_xpps4:Show()
        else
            LVLSPD_xpps4 = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontGreen")
            currentPoint = LVLSPD_calculateElementPoint()
            LVLSPD_xpps4:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            LVLSPD_xpps4:SetText("XP/s (Farm)")
        end
        if(LVLSPD_xpps3) then
            currentPoint = LVLSPD_calculateElementPoint()
            LVLSPD_xpps3:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            LVLSPD_xpps3:Show()
        else
            LVLSPD_xpps3 = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
            currentPoint = LVLSPD_calculateElementPoint()
            LVLSPD_xpps3:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            LVLSPD_xpps3:SetText(0)
        end

        LVLSPD_numberCreatedElements = LVLSPD_numberCreatedElements + 1
    end
    if(LVLSPD_lsElements.showTimeToLevel and LVLSPD_numberCreatedElements < 6) then
        if(LVLSPD_kills_toLevel1) then
            currentPoint = LVLSPD_calculateElementPoint()
            LVLSPD_kills_toLevel1:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            LVLSPD_kills_toLevel1:Show()
        else
            LVLSPD_kills_toLevel1 = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontGreen")
            currentPoint = LVLSPD_calculateElementPoint()
            LVLSPD_kills_toLevel1:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            LVLSPD_kills_toLevel1:SetText("Next Level (m)")
        end
        if(LVLSPD_kills_toLevel) then
            currentPoint = LVLSPD_calculateElementPoint()
            LVLSPD_kills_toLevel:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            LVLSPD_kills_toLevel:Show()
        else
            LVLSPD_kills_toLevel = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
            currentPoint = LVLSPD_calculateElementPoint()
            LVLSPD_kills_toLevel:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            LVLSPD_kills_toLevel:SetText(0)
        end

        LVLSPD_numberCreatedElements = LVLSPD_numberCreatedElements + 1
    end
    if(LVLSPD_lsElements.showKillsToLevel and LVLSPD_numberCreatedElements < 6) then
        if(LVLSPD_kills_toLevel3) then
            currentPoint = LVLSPD_calculateElementPoint()
            LVLSPD_kills_toLevel3:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            LVLSPD_kills_toLevel3:Show()
        else
            LVLSPD_kills_toLevel3 = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontGreen")
            currentPoint = LVLSPD_calculateElementPoint()
            LVLSPD_kills_toLevel3:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            LVLSPD_kills_toLevel3:SetText("Kills Left:")
        end
        if(LVLSPD_kills_toLevel2) then
            currentPoint = LVLSPD_calculateElementPoint()
            LVLSPD_kills_toLevel2:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            LVLSPD_kills_toLevel2:Show()
        else
            LVLSPD_kills_toLevel2 = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
            currentPoint = LVLSPD_calculateElementPoint()
            LVLSPD_kills_toLevel2:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            LVLSPD_kills_toLevel2:SetText(0)
        end

        LVLSPD_numberCreatedElements = LVLSPD_numberCreatedElements + 1
    end
    if(LVLSPD_lsElements.showLastKillXP and LVLSPD_numberCreatedElements < 6) then
        if(LVLSPD_lastKillXPText) then
            currentPoint = LVLSPD_calculateElementPoint()
            LVLSPD_lastKillXPText:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            LVLSPD_lastKillXPText:Show()
        else
            LVLSPD_lastKillXPText = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontGreen")
            currentPoint = LVLSPD_calculateElementPoint()
            LVLSPD_lastKillXPText:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            LVLSPD_lastKillXPText:SetText("Last Kill XP:")
        end
        if(LVLSPD_lastKillXPValue) then
            currentPoint = LVLSPD_calculateElementPoint()
            LVLSPD_lastKillXPValue:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            LVLSPD_lastKillXPValue:Show()
        else
            LVLSPD_lastKillXPValue = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
            currentPoint = LVLSPD_calculateElementPoint()
            LVLSPD_lastKillXPValue:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            LVLSPD_lastKillXPValue:SetText(0)
        end

        LVLSPD_numberCreatedElements = LVLSPD_numberCreatedElements + 1
    end
    if(LVLSPD_lsElements.showTotalXP and LVLSPD_numberCreatedElements < 6) then
        if(LVLSPD_totalXPText) then
            currentPoint = LVLSPD_calculateElementPoint()
            LVLSPD_totalXPText:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            LVLSPD_totalXPText:Show()
        else
            LVLSPD_totalXPText = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontGreen")
            currentPoint = LVLSPD_calculateElementPoint()
            LVLSPD_totalXPText:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            LVLSPD_totalXPText:SetText("Total XP:")
        end
        if(LVLSPD_totalXPValue) then
            currentPoint = LVLSPD_calculateElementPoint()
            LVLSPD_totalXPValue:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            LVLSPD_totalXPValue:Show()
        else
            LVLSPD_totalXPValue = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
            currentPoint = LVLSPD_calculateElementPoint()
            LVLSPD_totalXPValue:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            LVLSPD_totalXPValue:SetText(LVLSPD_calculateTotalXP())
        end

        LVLSPD_numberCreatedElements = LVLSPD_numberCreatedElements + 1
    end
    if(LVLSPD_lsElements.showGoldPerHour and LVLSPD_numberCreatedElements < 6) then
        if(LVLSPD_goldPerHourText) then
            currentPoint = LVLSPD_calculateElementPoint()
            LVLSPD_goldPerHourText:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            LVLSPD_goldPerHourText:Show()
        else
            LVLSPD_goldPerHourText = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontGreen")
            currentPoint = LVLSPD_calculateElementPoint()
            LVLSPD_goldPerHourText:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            LVLSPD_goldPerHourText:SetText("Gold/Hour:")
        end
        if(LVLSPD_goldPerHourValue) then
            currentPoint = LVLSPD_calculateElementPoint()
            LVLSPD_goldPerHourValue:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            LVLSPD_goldPerHourValue:Show()
        else
            LVLSPD_goldPerHourValue = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
            currentPoint = LVLSPD_calculateElementPoint()
            LVLSPD_goldPerHourValue:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            LVLSPD_goldPerHourValue:SetText(GetMoneyString(0))
        end

        LVLSPD_numberCreatedElements = LVLSPD_numberCreatedElements + 1
    end
    if(LVLSPD_lsElements.showSessionGold and LVLSPD_numberCreatedElements < 6) then
        if(LVLSPD_sessionGoldText) then
            currentPoint = LVLSPD_calculateElementPoint()
            LVLSPD_sessionGoldText:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            LVLSPD_sessionGoldText:Show()
        else
            LVLSPD_sessionGoldText = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontGreen")
            currentPoint = LVLSPD_calculateElementPoint()
            LVLSPD_sessionGoldText:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            LVLSPD_sessionGoldText:SetText("Session Gold:")
        end
        if(LVLSPD_sessionGoldValue) then
            currentPoint = LVLSPD_calculateElementPoint()
            LVLSPD_sessionGoldValue:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            LVLSPD_sessionGoldValue:Show()
        else
            LVLSPD_sessionGoldValue = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
            currentPoint = LVLSPD_calculateElementPoint()
            LVLSPD_sessionGoldValue:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            LVLSPD_sessionGoldValue:SetText(GetMoneyString(0))
        end

        LVLSPD_numberCreatedElements = LVLSPD_numberCreatedElements + 1
    end
    if(LVLSPD_lsElements.showPlayerDeaths and LVLSPD_numberCreatedElements < 6) then
        if(LVLSPD_playerDeathsText) then
            currentPoint = LVLSPD_calculateElementPoint()
            LVLSPD_playerDeathsText:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            LVLSPD_playerDeathsText:Show()
        else
            LVLSPD_playerDeathsText = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontGreen")
            currentPoint = LVLSPD_calculateElementPoint()
            LVLSPD_playerDeathsText:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            LVLSPD_playerDeathsText:SetText("Player Deaths:")
        end
        if(LVLSPD_playerDeathsValue) then
            currentPoint = LVLSPD_calculateElementPoint()
            LVLSPD_playerDeathsValue:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            LVLSPD_playerDeathsValue:Show()
        else
            LVLSPD_playerDeathsValue = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
            currentPoint = LVLSPD_calculateElementPoint()
            LVLSPD_playerDeathsValue:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            LVLSPD_playerDeathsValue:SetText(LVLSPD_deathCount)
        end

        LVLSPD_numberCreatedElements = LVLSPD_numberCreatedElements + 1
    end
end

function LVLSPD_toggleHideTitle()
    if (LVLSPD_titleFrame) then
        if (LVLSPD_hideTitle) then
            LVLSPD_titleFrame:Hide()
            LVLSPD_titleMain:Hide()
        else
            LVLSPD_titleFrame:Show()
            LVLSPD_titleMain:Show()
        end
    else
        if (not LVLSPD_hideTitle) then
            LVLSPD_titleFrame = CreateFrame("Frame", nil, LVLSPD_mainFrame,"InsetFrameTemplate3")
            LVLSPD_titleFrame:SetPoint("TOP",0,0)
            LVLSPD_titleFrame:SetSize(200,25)

            LVLSPD_titleMain = LVLSPD_titleFrame:CreateFontString("ARTWORK", nil, "GameFontRed")
            LVLSPD_titleMain:SetPoint("CENTER")
            LVLSPD_titleMain:SetText("Level Speed")
        end
    end
end

function LVLSPD_setHideTitle(value)
    LVLSPD_hideTitle = value
end