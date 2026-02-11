local _, ls = ...
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
    if list ~= nil then
        for i=0, #list do
            list[i][3] = false
        end
    end
end

function LVLSPD_calculateElementPoint()
    LVLSPD_pointsList = {}
    LVLSPD_returnArray = {"CENTER", 0, 0}
    LVLSPD_foundPoint = false
    LVLSPD_loopIterator = 0

    if( not LVLSPD_lsElements.showAsBar) then
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
    else
        LVLSPD_pointsList = LVLSPD_lsBarPoints
    end

    while(LVLSPD_foundPoint == false and LVLSPD_loopIterator < 12) do
        if LVLSPD_pointsList[LVLSPD_loopIterator][3] == false then
            if (not LVLSPD_lsElements.showAsBar) then
                LVLSPD_returnArray[0] = "CENTER"
                LVLSPD_returnArray[1] = LVLSPD_pointsList[LVLSPD_loopIterator][1]
                LVLSPD_returnArray[2] = LVLSPD_pointsList[LVLSPD_loopIterator][2]
                LVLSPD_pointsList[LVLSPD_loopIterator][3] = true
                LVLSPD_foundPoint = true
            else
                LVLSPD_returnArray[0] = LVLSPD_pointsList[LVLSPD_loopIterator][1]
                LVLSPD_returnArray[1] = LVLSPD_pointsList[LVLSPD_loopIterator][2]
                LVLSPD_pointsList[LVLSPD_loopIterator][3] = true
                LVLSPD_foundPoint = true
            end
        else
            LVLSPD_loopIterator = LVLSPD_loopIterator + 1
        end
    end

    return LVLSPD_returnArray
end

function LVLSPD_setMainFrameSize()
    if (not LVLSPD_lsElements.showAsBar) then
        if( not LVLSPD_hideTitle ) then
            if numberOfElements <= 2 then
                LVLSPD_mainFrame:SetSize(280,65)
            elseif numberOfElements <= 4 then
                LVLSPD_mainFrame:SetSize(280,100)
            else
                LVLSPD_mainFrame:SetSize(365,100)
            end
        else
            if numberOfElements <= 2 then
                LVLSPD_mainFrame:SetSize(280,40)
            elseif numberOfElements <= 4 then
                LVLSPD_mainFrame:SetSize(280,80)
            else
                LVLSPD_mainFrame:SetSize(365,80)
            end
        end
    else
        LVLSPD_mainFrame:SetSize(GetScreenWidth(), 25)
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
    LVLSPD_windowLocation = {self:GetPoint()}
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
        if ( not LVLSPD_lsElements.showAsBar ) then
            LVLSPD_xpps1 = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontGreen")
            LVLSPD_xpps1:SetFontHeight(11)
            currentPoint = LVLSPD_calculateElementPoint()
            LVLSPD_xpps1:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            LVLSPD_xpps1:SetText("XP/s (All)")

            LVLSPD_xpps = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
            LVLSPD_xpps:SetFontHeight(14)
            currentPoint = LVLSPD_calculateElementPoint()
            LVLSPD_xpps:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            LVLSPD_xpps:SetText(0)
        else
            LVLSPD_xpps1 = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontGreen")
            LVLSPD_xpps1:SetFontHeight(11)
            currentPoint = LVLSPD_calculateElementPoint()
            LVLSPD_xpps1:SetPoint(currentPoint[0], currentPoint[1], 0)
            LVLSPD_xpps1:SetText("XP/s (All)")

            LVLSPD_xpps = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
            LVLSPD_xpps:SetFontHeight(14)
            local valuePoint = currentPoint[1] + LVLSPD_elementDeviation.xppsA
            LVLSPD_xpps:SetPoint(currentPoint[0], valuePoint, 0)
            LVLSPD_xpps:SetText(0)
        end

        LVLSPD_numberCreatedElements = LVLSPD_numberCreatedElements + 1
    end

    if LVLSPD_lsElements.showFarmXPS and LVLSPD_numberCreatedElements < 6 then
        if ( not LVLSPD_lsElements.showAsBar ) then
            LVLSPD_xpps4 = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontGreen")
            LVLSPD_xpps4:SetFontHeight(11)
            currentPoint = LVLSPD_calculateElementPoint()
            LVLSPD_xpps4:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            LVLSPD_xpps4:SetText("XP/s (Farm)")

            LVLSPD_xpps3 = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
            LVLSPD_xpps3:SetFontHeight(14)
            currentPoint = LVLSPD_calculateElementPoint()
            LVLSPD_xpps3:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            LVLSPD_xpps3:SetText(0)
        else
            LVLSPD_xpps4 = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontGreen")
            LVLSPD_xpps4:SetFontHeight(11)
            currentPoint = LVLSPD_calculateElementPoint()
            LVLSPD_xpps4:SetPoint(currentPoint[0], currentPoint[1], 0)
            LVLSPD_xpps4:SetText("XP/s (Farm)")

            LVLSPD_xpps3 = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
            LVLSPD_xpps3:SetFontHeight(14)
            local valuePoint = currentPoint[1] + LVLSPD_elementDeviation.xppsF
            LVLSPD_xpps3:SetPoint(currentPoint[0], valuePoint, 0)
            LVLSPD_xpps3:SetText(0)
        end

        LVLSPD_numberCreatedElements = LVLSPD_numberCreatedElements + 1
    end

    if LVLSPD_lsElements.showTimeToLevel and LVLSPD_numberCreatedElements < 6 then
        if ( not LVLSPD_lsElements.showAsBar ) then
            LVLSPD_kills_toLevel1 = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontGreen")
            LVLSPD_kills_toLevel1:SetFontHeight(11)
            currentPoint = LVLSPD_calculateElementPoint()
            LVLSPD_kills_toLevel1:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            LVLSPD_kills_toLevel1:SetText("Next Level (m)")

            LVLSPD_kills_toLevel = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
            LVLSPD_kills_toLevel:SetFontHeight(14)
            currentPoint = LVLSPD_calculateElementPoint()
            LVLSPD_kills_toLevel:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            LVLSPD_kills_toLevel:SetText(0)
        else
            LVLSPD_kills_toLevel1 = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontGreen")
            LVLSPD_kills_toLevel1:SetFontHeight(11)
            currentPoint = LVLSPD_calculateElementPoint()
            LVLSPD_kills_toLevel1:SetPoint(currentPoint[0], currentPoint[1], 0)
            LVLSPD_kills_toLevel1:SetText("Next Level (m)")

            LVLSPD_kills_toLevel = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
            LVLSPD_kills_toLevel:SetFontHeight(14)
            local valuePoint = currentPoint[1] + LVLSPD_elementDeviation.nextLevel
            LVLSPD_kills_toLevel:SetPoint(currentPoint[0], valuePoint, 0)
            LVLSPD_kills_toLevel:SetText(0)
        end

        LVLSPD_numberCreatedElements = LVLSPD_numberCreatedElements + 1
    end

    if LVLSPD_lsElements.showKillsToLevel and LVLSPD_numberCreatedElements < 6 then
        if ( not LVLSPD_lsElements.showAsBar ) then
            LVLSPD_kills_toLevel3 = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontGreen")
            LVLSPD_kills_toLevel3:SetFontHeight(11)
            currentPoint = LVLSPD_calculateElementPoint()
            LVLSPD_kills_toLevel3:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            LVLSPD_kills_toLevel3:SetText("Kills Left:")

            LVLSPD_kills_toLevel2 = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
            LVLSPD_kills_toLevel2:SetFontHeight(14)
            currentPoint = LVLSPD_calculateElementPoint()
            LVLSPD_kills_toLevel2:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            LVLSPD_kills_toLevel2:SetText(0)
        else
            LVLSPD_kills_toLevel3 = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontGreen")
            LVLSPD_kills_toLevel3:SetFontHeight(11)
            currentPoint = LVLSPD_calculateElementPoint()
            LVLSPD_kills_toLevel3:SetPoint(currentPoint[0], currentPoint[1], 0)
            LVLSPD_kills_toLevel3:SetText("Kills Left:")

            LVLSPD_kills_toLevel2 = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
            LVLSPD_kills_toLevel2:SetFontHeight(14)
            local valuePoint = currentPoint[1] + LVLSPD_elementDeviation.killsLeft
            LVLSPD_kills_toLevel2:SetPoint(currentPoint[0], valuePoint, 0)
            LVLSPD_kills_toLevel2:SetText(0)
        end

        LVLSPD_numberCreatedElements = LVLSPD_numberCreatedElements + 1
    end

    if LVLSPD_lsElements.showLastKillXP and LVLSPD_numberCreatedElements < 6 then
        if ( not LVLSPD_lsElements.showAsBar ) then
            LVLSPD_lastKillXPText = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontGreen")
            LVLSPD_lastKillXPText:SetFontHeight(11)
            currentPoint = LVLSPD_calculateElementPoint()
            LVLSPD_lastKillXPText:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            LVLSPD_lastKillXPText:SetText("Last Kill XP:")

            LVLSPD_lastKillXPValue = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
            LVLSPD_lastKillXPValue:SetFontHeight(14)
            currentPoint = LVLSPD_calculateElementPoint()
            LVLSPD_lastKillXPValue:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            LVLSPD_lastKillXPValue:SetText(0)
        else
            LVLSPD_lastKillXPText = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontGreen")
            LVLSPD_lastKillXPText:SetFontHeight(11)
            currentPoint = LVLSPD_calculateElementPoint()
            LVLSPD_lastKillXPText:SetPoint(currentPoint[0], currentPoint[1], 0)
            LVLSPD_lastKillXPText:SetText("Last Kill XP:")

            LVLSPD_lastKillXPValue = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
            LVLSPD_lastKillXPValue:SetFontHeight(14)
            local valuePoint = currentPoint[1] + LVLSPD_elementDeviation.lastKill
            LVLSPD_lastKillXPValue:SetPoint(currentPoint[0], valuePoint, 0)
            LVLSPD_lastKillXPValue:SetText(0)
        end

        LVLSPD_numberCreatedElements = LVLSPD_numberCreatedElements + 1
    end

    if LVLSPD_lsElements.showTotalXP and LVLSPD_numberCreatedElements < 6 then
        if ( not LVLSPD_lsElements.showAsBar ) then
            LVLSPD_totalXPText = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontGreen")
            LVLSPD_totalXPText:SetFontHeight(11)
            currentPoint = LVLSPD_calculateElementPoint()
            LVLSPD_totalXPText:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            LVLSPD_totalXPText:SetText("Total XP:")

            LVLSPD_totalXPValue = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
            LVLSPD_totalXPValue:SetFontHeight(14)
            currentPoint = LVLSPD_calculateElementPoint()
            LVLSPD_totalXPValue:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            LVLSPD_totalXPValue:SetText(LVLSPD_calculateTotalXP())
        else
            LVLSPD_totalXPText = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontGreen")
            LVLSPD_totalXPText:SetFontHeight(11)
            currentPoint = LVLSPD_calculateElementPoint()
            LVLSPD_totalXPText:SetPoint(currentPoint[0], currentPoint[1], 0)
            LVLSPD_totalXPText:SetText("Total XP:")

            LVLSPD_totalXPValue = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
            LVLSPD_totalXPValue:SetFontHeight(14)
            local valuePoint = currentPoint[1] + LVLSPD_elementDeviation.totalXP
            LVLSPD_totalXPValue:SetPoint(currentPoint[0], valuePoint, 0)
            LVLSPD_totalXPValue:SetText(LVLSPD_calculateTotalXP())
        end

        LVLSPD_numberCreatedElements = LVLSPD_numberCreatedElements + 1
    end

    if LVLSPD_lsElements.showGoldPerHour and LVLSPD_numberCreatedElements < 6 then
        if ( not LVLSPD_lsElements.showAsBar ) then
            LVLSPD_goldPerHourText = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontGreen")
            LVLSPD_goldPerHourText:SetFontHeight(11)
            currentPoint = LVLSPD_calculateElementPoint()
            LVLSPD_goldPerHourText:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            LVLSPD_goldPerHourText:SetText("Gold/Hour:")

            LVLSPD_goldPerHourValue = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
            LVLSPD_goldPerHourValue:SetFontHeight(14)
            currentPoint = LVLSPD_calculateElementPoint()
            LVLSPD_goldPerHourValue:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            LVLSPD_goldPerHourValue:SetText(GetMoneyString(0))
        else
            LVLSPD_goldPerHourText = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontGreen")
            LVLSPD_goldPerHourText:SetFontHeight(11)
            currentPoint = LVLSPD_calculateElementPoint()
            LVLSPD_goldPerHourText:SetPoint(currentPoint[0], currentPoint[1], 0)
            LVLSPD_goldPerHourText:SetText("Gold/Hour:")

            LVLSPD_goldPerHourValue = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
            LVLSPD_goldPerHourValue:SetFontHeight(14)
            local valuePoint = currentPoint[1] + LVLSPD_elementDeviation.goldPerHour
            LVLSPD_goldPerHourValue:SetPoint(currentPoint[0], valuePoint, 0)
            LVLSPD_goldPerHourValue:SetText(GetMoneyString(0))
        end

        LVLSPD_numberCreatedElements = LVLSPD_numberCreatedElements + 1
    end

    if LVLSPD_lsElements.showSessionGold and LVLSPD_numberCreatedElements < 6 then
        if ( not LVLSPD_lsElements.showAsBar ) then
            LVLSPD_sessionGoldText = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontGreen")
            LVLSPD_sessionGoldText:SetFontHeight(11)
            currentPoint = LVLSPD_calculateElementPoint()
            LVLSPD_sessionGoldText:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            LVLSPD_sessionGoldText:SetText("Session Gold:")

            LVLSPD_sessionGoldValue = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
            LVLSPD_sessionGoldValue:SetFontHeight(14)
            currentPoint = LVLSPD_calculateElementPoint()
            LVLSPD_sessionGoldValue:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            LVLSPD_sessionGoldValue:SetText(GetMoneyString(0))
        else
            LVLSPD_sessionGoldText = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontGreen")
            LVLSPD_sessionGoldText:SetFontHeight(11)
            currentPoint = LVLSPD_calculateElementPoint()
            LVLSPD_sessionGoldText:SetPoint(currentPoint[0], currentPoint[1], 0)
            LVLSPD_sessionGoldText:SetText("Session Gold:")

            LVLSPD_sessionGoldValue = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
            LVLSPD_sessionGoldValue:SetFontHeight(14)
            local valuePoint = currentPoint[1] + LVLSPD_elementDeviation.sessionGold
            LVLSPD_sessionGoldValue:SetPoint(currentPoint[0], valuePoint, 0)
            LVLSPD_sessionGoldValue:SetText(GetMoneyString(0))
        end

        LVLSPD_numberCreatedElements = LVLSPD_numberCreatedElements + 1
    end

    if LVLSPD_lsElements.showPlayerDeaths and LVLSPD_numberCreatedElements < 6 then
        if ( not LVLSPD_lsElements.showAsBar ) then
            LVLSPD_playerDeathsText = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontGreen")
            LVLSPD_playerDeathsText:SetFontHeight(11)
            currentPoint = LVLSPD_calculateElementPoint()
            LVLSPD_playerDeathsText:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            LVLSPD_playerDeathsText:SetText("Player Deaths:")

            LVLSPD_playerDeathsValue = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
            LVLSPD_playerDeathsValue:SetFontHeight(14)
            currentPoint = LVLSPD_calculateElementPoint()
            LVLSPD_playerDeathsValue:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            LVLSPD_playerDeathsValue:SetText(LVLSPD_deathCount)
        else
            LVLSPD_playerDeathsText = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontGreen")
            LVLSPD_playerDeathsText:SetFontHeight(11)
            currentPoint = LVLSPD_calculateElementPoint()
            LVLSPD_playerDeathsText:SetPoint(currentPoint[0], currentPoint[1], 0)
            LVLSPD_playerDeathsText:SetText("Player Deaths:")

            LVLSPD_playerDeathsValue = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
            LVLSPD_playerDeathsValue:SetFontHeight(14)
            local valuePoint = currentPoint[1] + LVLSPD_elementDeviation.playerDeaths
            LVLSPD_playerDeathsValue:SetPoint(currentPoint[0], valuePoint, 0)
            LVLSPD_playerDeathsValue:SetText(LVLSPD_deathCount)
        end

        LVLSPD_numberCreatedElements = LVLSPD_numberCreatedElements + 1
    end

    if LVLSPD_lsElements.showSessionHonor and LVLSPD_numberCreatedElements < 6 then
        if ( not LVLSPD_lsElements.showAsBar ) then
            LVLSPD_sessionHonorText = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontGreen")
            LVLSPD_sessionHonorText:SetFontHeight(11)
            currentPoint = LVLSPD_calculateElementPoint()
            LVLSPD_sessionHonorText:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            LVLSPD_sessionHonorText:SetText("Session Honor:")

            LVLSPD_sessionHonorValue = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
            LVLSPD_sessionHonorValue:SetFontHeight(14)
            currentPoint = LVLSPD_calculateElementPoint()
            LVLSPD_sessionHonorValue:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            LVLSPD_sessionHonorValue:SetText(ls.sessionHonor)
        else
            LVLSPD_sessionHonorText = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontGreen")
            LVLSPD_sessionHonorText:SetFontHeight(11)
            currentPoint = LVLSPD_calculateElementPoint()
            LVLSPD_sessionHonorText:SetPoint(currentPoint[0], currentPoint[1], 0)
            LVLSPD_sessionHonorText:SetText("Session Honor:")

            LVLSPD_sessionHonorValue = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
            LVLSPD_sessionHonorValue:SetFontHeight(14)
            local valuePoint = currentPoint[1] + LVLSPD_elementDeviation.sessionHonor
            LVLSPD_sessionHonorValue:SetPoint(currentPoint[0], valuePoint, 0)
            LVLSPD_sessionHonorValue:SetText(ls.sessionHonor)
        end
    end

    if LVLSPD_lsElements.showFarmXpPerMin and LVLSPD_numberCreatedElements < 6 then
        if ( not LVLSPD_lsElements.showAsBar ) then
            LVLSPD_farmXpPerMinText = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontGreen")
            LVLSPD_farmXpPerMinText:SetFontHeight(11)
            currentPoint = LVLSPD_calculateElementPoint()
            LVLSPD_farmXpPerMinText:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            LVLSPD_farmXpPerMinText:SetText("XP/m (Farm):")

            LVLSPD_farmXpPerMinValue = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
            LVLSPD_farmXpPerMinValue:SetFontHeight(14)
            currentPoint = LVLSPD_calculateElementPoint()
            LVLSPD_farmXpPerMinValue:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            LVLSPD_farmXpPerMinValue:SetText(0)
        else
            LVLSPD_farmXpPerMinText = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontGreen")
            LVLSPD_farmXpPerMinText:SetFontHeight(11)
            currentPoint = LVLSPD_calculateElementPoint()
            LVLSPD_farmXpPerMinText:SetPoint(currentPoint[0], currentPoint[1], 0)
            LVLSPD_farmXpPerMinText:SetText("XP/m (Farm):")

            LVLSPD_farmXpPerMinValue = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
            LVLSPD_farmXpPerMinValue:SetFontHeight(14)
            local valuePoint = currentPoint[1] + LVLSPD_elementDeviation.farmXpPerMin
            LVLSPD_farmXpPerMinValue:SetPoint(currentPoint[0], valuePoint, 0)
            LVLSPD_farmXpPerMinValue:SetText(0)
        end

        LVLSPD_numberCreatedElements = LVLSPD_numberCreatedElements + 1
    end

    if LVLSPD_lsElements.showXpPerMin and LVLSPD_numberCreatedElements < 6 then
        if ( not LVLSPD_lsElements.showAsBar ) then
            LVLSPD_xpPerMinText = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontGreen")
            LVLSPD_xpPerMinText:SetFontHeight(11)
            currentPoint = LVLSPD_calculateElementPoint()
            LVLSPD_xpPerMinText:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            LVLSPD_xpPerMinText:SetText("XP/m (All):")

            LVLSPD_xpPerMinValue = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
            LVLSPD_xpPerMinValue:SetFontHeight(14)
            currentPoint = LVLSPD_calculateElementPoint()
            LVLSPD_xpPerMinValue:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            LVLSPD_xpPerMinValue:SetText(0)
        else
            LVLSPD_xpPerMinText = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontGreen")
            LVLSPD_xpPerMinText:SetFontHeight(11)
            currentPoint = LVLSPD_calculateElementPoint()
            LVLSPD_xpPerMinText:SetPoint(currentPoint[0], currentPoint[1], 0)
            LVLSPD_xpPerMinText:SetText("XP/m (All):")

            LVLSPD_xpPerMinValue = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
            LVLSPD_xpPerMinValue:SetFontHeight(14)
            local valuePoint = currentPoint[1] + LVLSPD_elementDeviation.xpPerMin
            LVLSPD_xpPerMinValue:SetPoint(currentPoint[0], valuePoint, 0)
            LVLSPD_xpPerMinValue:SetText(0)
        end

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
    if(LVLSPD_sessionHonorText ~= nil) then
        LVLSPD_sessionHonorText:Hide()
    end
    if(LVLSPD_sessionHonorValue ~= nil) then
        LVLSPD_sessionHonorValue:Hide()
    end
    if(LVLSPD_farmXpPerMinText ~= nil) then
        LVLSPD_farmXpPerMinText:Hide()
    end
    if(LVLSPD_farmXpPerMinValue ~= nil) then
        LVLSPD_farmXpPerMinValue:Hide()
    end
    if(LVLSPD_xpPerMinText ~= nil) then
        LVLSPD_xpPerMinText:Hide()
    end
    if(LVLSPD_xpPerMinValue ~= nil) then
        LVLSPD_xpPerMinValue:Hide()
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
            if ( not LVLSPD_lsElements.showAsBar ) then
                LVLSPD_xpps1:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            else
                LVLSPD_xpps1:SetPoint(currentPoint[0], currentPoint[1], 0)
            end
            LVLSPD_xpps1:Show()
        else
            LVLSPD_xpps1 = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontGreen")
            LVLSPD_xpps1:SetFontHeight(11)
            currentPoint = LVLSPD_calculateElementPoint()
            if ( not LVLSPD_lsElements.showAsBar ) then
                LVLSPD_xpps1:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            else
                LVLSPD_xpps1:SetPoint(currentPoint[0], currentPoint[1], 0)
            end
            LVLSPD_xpps1:SetText("XP/s (All)")
        end

        if(LVLSPD_xpps) then
            if ( not LVLSPD_lsElements.showAsBar ) then
                currentPoint = LVLSPD_calculateElementPoint()
                LVLSPD_xpps:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            else
                local valuePoint = currentPoint[1] + LVLSPD_elementDeviation.xppsA
                LVLSPD_xpps:SetPoint(currentPoint[0], valuePoint, 0)
            end
            LVLSPD_xpps:Show()
        else
            LVLSPD_xpps = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
            LVLSPD_xpps:SetFontHeight(14)
            if ( not LVLSPD_lsElements.showAsBar ) then
                currentPoint = LVLSPD_calculateElementPoint()
                LVLSPD_xpps:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            else
                local valuePoint = currentPoint[1] + LVLSPD_elementDeviation.xppsA
                LVLSPD_xpps:SetPoint(currentPoint[0], valuePoint, 0)
            end
            LVLSPD_xpps:SetText(0)
        end
        
        LVLSPD_numberCreatedElements = LVLSPD_numberCreatedElements + 1
    end
    if(LVLSPD_lsElements.showFarmXPS and LVLSPD_numberCreatedElements < 6) then
        if(LVLSPD_xpps4) then
            currentPoint = LVLSPD_calculateElementPoint()
            if ( not LVLSPD_lsElements.showAsBar ) then
                LVLSPD_xpps4:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            else
                LVLSPD_xpps4:SetPoint(currentPoint[0], currentPoint[1], 0)
            end
            LVLSPD_xpps4:Show()
        else
            LVLSPD_xpps4 = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontGreen")
            LVLSPD_xpps4:SetFontHeight(11)
            currentPoint = LVLSPD_calculateElementPoint()
            if ( not LVLSPD_lsElements.showAsBar ) then
                LVLSPD_xpps4:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            else
                LVLSPD_xpps4:SetPoint(currentPoint[0], currentPoint[1], 0)
            end
            LVLSPD_xpps4:SetText("XP/s (Farm)")
        end
        if(LVLSPD_xpps3) then
            if ( not LVLSPD_lsElements.showAsBar ) then
                currentPoint = LVLSPD_calculateElementPoint()
                LVLSPD_xpps3:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            else
                local valuePoint = currentPoint[1] + LVLSPD_elementDeviation.xppsF
                LVLSPD_xpps3:SetPoint(currentPoint[0], valuePoint, 0)
            end
            LVLSPD_xpps3:Show()
        else
            LVLSPD_xpps3 = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
            LVLSPD_xpps3:SetFontHeight(14)
            if ( not LVLSPD_lsElements.showAsBar ) then
                currentPoint = LVLSPD_calculateElementPoint()
                LVLSPD_xpps3:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            else
                local valuePoint = currentPoint[1] + LVLSPD_elementDeviation.xppsF
                LVLSPD_xpps3:SetPoint(currentPoint[0], valuePoint, 0)

            end
            LVLSPD_xpps3:SetText(0)
        end

        LVLSPD_numberCreatedElements = LVLSPD_numberCreatedElements + 1
    end
    if(LVLSPD_lsElements.showTimeToLevel and LVLSPD_numberCreatedElements < 6) then
        if(LVLSPD_kills_toLevel1) then
            currentPoint = LVLSPD_calculateElementPoint()
            if ( not LVLSPD_lsElements.showAsBar ) then
                LVLSPD_kills_toLevel1:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            else
                LVLSPD_kills_toLevel1:SetPoint(currentPoint[0], currentPoint[1], 0)
            end
            LVLSPD_kills_toLevel1:Show()
        else
            LVLSPD_kills_toLevel1 = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontGreen")
            LVLSPD_kills_toLevel1:SetFontHeight(11)
            currentPoint = LVLSPD_calculateElementPoint()
            if ( not LVLSPD_lsElements.showAsBar ) then
                LVLSPD_kills_toLevel1:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            else
                LVLSPD_kills_toLevel1:SetPoint(currentPoint[0], currentPoint[1], 0)
            end
            LVLSPD_kills_toLevel1:SetText("Next Level (m)")
        end
        if(LVLSPD_kills_toLevel) then
            if ( not LVLSPD_lsElements.showAsBar ) then
                currentPoint = LVLSPD_calculateElementPoint()
                LVLSPD_kills_toLevel:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            else
                local valuePoint = currentPoint[1] + LVLSPD_elementDeviation.nextLevel
                LVLSPD_kills_toLevel:SetPoint(currentPoint[0], valuePoint, 0)
            end
            LVLSPD_kills_toLevel:Show()
        else
            LVLSPD_kills_toLevel = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
            LVLSPD_kills_toLevel:SetFontHeight(14)
            if ( not LVLSPD_lsElements.showAsBar ) then
                currentPoint = LVLSPD_calculateElementPoint()
                LVLSPD_kills_toLevel:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            else
                local valuePoint = currentPoint[1] + LVLSPD_elementDeviation.nextLevel
                LVLSPD_kills_toLevel:SetPoint(currentPoint[0], valuePoint, 0)
            end
            LVLSPD_kills_toLevel:SetText(0)
        end

        LVLSPD_numberCreatedElements = LVLSPD_numberCreatedElements + 1
    end
    if(LVLSPD_lsElements.showKillsToLevel and LVLSPD_numberCreatedElements < 6) then
        if(LVLSPD_kills_toLevel3) then
            currentPoint = LVLSPD_calculateElementPoint()
            if ( not LVLSPD_lsElements.showAsBar ) then
                LVLSPD_kills_toLevel3:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            else
                LVLSPD_kills_toLevel3:SetPoint(currentPoint[0], currentPoint[1], 0)
            end
            LVLSPD_kills_toLevel3:Show()
        else
            LVLSPD_kills_toLevel3 = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontGreen")
            LVLSPD_kills_toLevel3:SetFontHeight(11)
            currentPoint = LVLSPD_calculateElementPoint()
            if ( not LVLSPD_lsElements.showAsBar ) then
                LVLSPD_kills_toLevel3:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            else
                LVLSPD_kills_toLevel3:SetPoint(currentPoint[0], currentPoint[1], 0)
            end
            LVLSPD_kills_toLevel3:SetText("Kills Left:")
        end
        if(LVLSPD_kills_toLevel2) then
            if ( not LVLSPD_lsElements.showAsBar ) then
                currentPoint = LVLSPD_calculateElementPoint()
                LVLSPD_kills_toLevel2:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            else
                local valuePoint = currentPoint[1] + LVLSPD_elementDeviation.killsLeft
                LVLSPD_kills_toLevel2:SetPoint(currentPoint[0], valuePoint, 0)
            end
            LVLSPD_kills_toLevel2:Show()
        else
            LVLSPD_kills_toLevel2 = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
            LVLSPD_kills_toLevel2:SetFontHeight(14)
            if ( not LVLSPD_lsElements.showAsBar ) then
                currentPoint = LVLSPD_calculateElementPoint()
                LVLSPD_kills_toLevel2:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            else
                local valuePoint = currentPoint[1] + LVLSPD_elementDeviation.killsLeft
                LVLSPD_kills_toLevel2:SetPoint(currentPoint[0], valuePoint, 0)
            end
            LVLSPD_kills_toLevel2:SetText(0)
        end

        LVLSPD_numberCreatedElements = LVLSPD_numberCreatedElements + 1
    end
    if(LVLSPD_lsElements.showLastKillXP and LVLSPD_numberCreatedElements < 6) then
        if(LVLSPD_lastKillXPText) then
            currentPoint = LVLSPD_calculateElementPoint()
            if ( not LVLSPD_lsElements.showAsBar ) then
                LVLSPD_lastKillXPText:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            else
                LVLSPD_lastKillXPText:SetPoint(currentPoint[0], currentPoint[1], 0)
            end
            LVLSPD_lastKillXPText:Show()
        else
            LVLSPD_lastKillXPText = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontGreen")
            LVLSPD_lastKillXPText:SetFontHeight(11)
            currentPoint = LVLSPD_calculateElementPoint()
            if ( not LVLSPD_lsElements.showAsBar ) then
                LVLSPD_lastKillXPText:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            else
                LVLSPD_lastKillXPText:SetPoint(currentPoint[0], currentPoint[1], 0)
            end
            LVLSPD_lastKillXPText:SetText("Last Kill XP:")
        end
        if(LVLSPD_lastKillXPValue) then
            if ( not LVLSPD_lsElements.showAsBar ) then
                currentPoint = LVLSPD_calculateElementPoint()
                LVLSPD_lastKillXPValue:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            else
                local valuePoint = currentPoint[1] + LVLSPD_elementDeviation.lastKill
                LVLSPD_lastKillXPValue:SetPoint(currentPoint[0], valuePoint, 0)
            end
            LVLSPD_lastKillXPValue:Show()
        else
            LVLSPD_lastKillXPValue = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
            LVLSPD_lastKillXPValue:SetFontHeight(14)
            if ( not LVLSPD_lsElements.showAsBar ) then
                currentPoint = LVLSPD_calculateElementPoint()
                LVLSPD_lastKillXPValue:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            else
                local valuePoint = currentPoint[1] + LVLSPD_elementDeviation.lastKill
                LVLSPD_lastKillXPValue:SetPoint(currentPoint[0], valuePoint, 0)
            end
            LVLSPD_lastKillXPValue:SetText(0)
        end

        LVLSPD_numberCreatedElements = LVLSPD_numberCreatedElements + 1
    end
    if(LVLSPD_lsElements.showTotalXP and LVLSPD_numberCreatedElements < 6) then
        if(LVLSPD_totalXPText) then
            currentPoint = LVLSPD_calculateElementPoint()
            if ( not LVLSPD_lsElements.showAsBar ) then
                LVLSPD_totalXPText:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            else
                LVLSPD_totalXPText:SetPoint(currentPoint[0], currentPoint[1], 0)
            end
            LVLSPD_totalXPText:Show()
        else
            LVLSPD_totalXPText = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontGreen")
            LVLSPD_totalXPText:SetFontHeight(11)
            currentPoint = LVLSPD_calculateElementPoint()
            if ( not LVLSPD_lsElements.showAsBar ) then
                LVLSPD_totalXPText:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            else
                LVLSPD_totalXPText:SetPoint(currentPoint[0], currentPoint[1], 0)
            end
            LVLSPD_totalXPText:SetText("Total XP:")
        end
        if(LVLSPD_totalXPValue) then
            if ( not LVLSPD_lsElements.showAsBar ) then
                currentPoint = LVLSPD_calculateElementPoint()
                LVLSPD_totalXPValue:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            else
                local valuePoint = currentPoint[1] + LVLSPD_elementDeviation.totalXP
                LVLSPD_totalXPValue:SetPoint(currentPoint[0], valuePoint, 0)
            end
            LVLSPD_totalXPValue:Show()
        else
            LVLSPD_totalXPValue = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
            LVLSPD_totalXPValue:SetFontHeight(14)
            if ( not LVLSPD_lsElements.showAsBar ) then
                currentPoint = LVLSPD_calculateElementPoint()
                LVLSPD_totalXPValue:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            else
                local valuePoint = currentPoint[1] + LVLSPD_elementDeviation.totalXP
                LVLSPD_totalXPValue:SetPoint(currentPoint[0], valuePoint, 0)
            end
            LVLSPD_totalXPValue:SetText(LVLSPD_calculateTotalXP())
        end

        LVLSPD_numberCreatedElements = LVLSPD_numberCreatedElements + 1
    end
    if(LVLSPD_lsElements.showGoldPerHour and LVLSPD_numberCreatedElements < 6) then
        if(LVLSPD_goldPerHourText) then
            currentPoint = LVLSPD_calculateElementPoint()
            if ( not LVLSPD_lsElements.showAsBar ) then
                LVLSPD_goldPerHourText:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            else
                LVLSPD_goldPerHourText:SetPoint(currentPoint[0], currentPoint[1], 0)
            end
            LVLSPD_goldPerHourText:Show()
        else
            LVLSPD_goldPerHourText = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontGreen")
            LVLSPD_goldPerHourText:SetFontHeight(11)
            currentPoint = LVLSPD_calculateElementPoint()
            if ( not LVLSPD_lsElements.showAsBar ) then
                LVLSPD_goldPerHourText:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            else
                LVLSPD_goldPerHourText:SetPoint(currentPoint[0], currentPoint[1], 0)
            end
            LVLSPD_goldPerHourText:SetText("Gold/Hour:")
        end
        if(LVLSPD_goldPerHourValue) then
            if ( not LVLSPD_lsElements.showAsBar ) then
                currentPoint = LVLSPD_calculateElementPoint()
                LVLSPD_goldPerHourValue:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            else
                local valuePoint = currentPoint[1] + LVLSPD_elementDeviation.goldPerHour
                LVLSPD_goldPerHourValue:SetPoint(currentPoint[0], valuePoint, 0)
            end
            LVLSPD_goldPerHourValue:Show()
        else
            LVLSPD_goldPerHourValue = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
            LVLSPD_goldPerHourValue:SetFontHeight(14)
            if ( not LVLSPD_lsElements.showAsBar ) then
                currentPoint = LVLSPD_calculateElementPoint()
                LVLSPD_goldPerHourValue:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            else
                local valuePoint = currentPoint[1] + LVLSPD_elementDeviation.goldPerHour
                LVLSPD_goldPerHourValue:SetPoint(currentPoint[0], valuePoint, 0)
            end
            LVLSPD_goldPerHourValue:SetText(GetMoneyString(0))
        end

        LVLSPD_numberCreatedElements = LVLSPD_numberCreatedElements + 1
    end
    if(LVLSPD_lsElements.showSessionGold and LVLSPD_numberCreatedElements < 6) then
        if(LVLSPD_sessionGoldText) then
            currentPoint = LVLSPD_calculateElementPoint()
            if ( not LVLSPD_lsElements.showAsBar ) then
                LVLSPD_sessionGoldText:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            else
                LVLSPD_sessionGoldText:SetPoint(currentPoint[0], currentPoint[1], 0)
            end
            LVLSPD_sessionGoldText:Show()
        else
            LVLSPD_sessionGoldText = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontGreen")
            LVLSPD_sessionGoldText:SetFontHeight(11)
            currentPoint = LVLSPD_calculateElementPoint()
            if ( not LVLSPD_lsElements.showAsBar ) then
                LVLSPD_sessionGoldText:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            else
                LVLSPD_sessionGoldText:SetPoint(currentPoint[0], currentPoint[1], 0)
            end
            LVLSPD_sessionGoldText:SetText("Session Gold:")
        end
        if(LVLSPD_sessionGoldValue) then
            if ( not LVLSPD_lsElements.showAsBar ) then
                currentPoint = LVLSPD_calculateElementPoint()
                LVLSPD_sessionGoldValue:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            else
                local valuePoint = currentPoint[1] + LVLSPD_elementDeviation.sessionGold
                LVLSPD_sessionGoldValue:SetPoint(currentPoint[0], valuePoint, 0)
            end
            LVLSPD_sessionGoldValue:Show()
        else
            LVLSPD_sessionGoldValue = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
            LVLSPD_sessionGoldValue:SetFontHeight(14)
            if ( not LVLSPD_lsElements.showAsBar ) then
                currentPoint = LVLSPD_calculateElementPoint()
                LVLSPD_sessionGoldValue:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            else
                local valuePoint = currentPoint[1] + LVLSPD_elementDeviation.sessionGold
                LVLSPD_sessionGoldValue:SetPoint(currentPoint[0], valuePoint, 0)
            end
            LVLSPD_sessionGoldValue:SetText(GetMoneyString(0))
        end

        LVLSPD_numberCreatedElements = LVLSPD_numberCreatedElements + 1
    end
    if(LVLSPD_lsElements.showPlayerDeaths and LVLSPD_numberCreatedElements < 6) then
        if(LVLSPD_playerDeathsText) then
            currentPoint = LVLSPD_calculateElementPoint()
            if ( not LVLSPD_lsElements.showAsBar ) then
                LVLSPD_playerDeathsText:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            else
                LVLSPD_playerDeathsText:SetPoint(currentPoint[0], currentPoint[1], 0)
            end
            LVLSPD_playerDeathsText:Show()
        else
            LVLSPD_playerDeathsText = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontGreen")
            LVLSPD_playerDeathsText:SetFontHeight(11)
            currentPoint = LVLSPD_calculateElementPoint()
            if ( not LVLSPD_lsElements.showAsBar ) then
                LVLSPD_playerDeathsText:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            else
                LVLSPD_playerDeathsText:SetPoint(currentPoint[0], currentPoint[1], 0)
            end
            LVLSPD_playerDeathsText:SetText("Player Deaths:")
        end
        if(LVLSPD_playerDeathsValue) then
            if ( not LVLSPD_lsElements.showAsBar ) then
                currentPoint = LVLSPD_calculateElementPoint()
                LVLSPD_playerDeathsValue:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            else
                local valuePoint = currentPoint[1] + LVLSPD_elementDeviation.playerDeaths
                LVLSPD_playerDeathsValue:SetPoint(currentPoint[0], valuePoint, 0)
            end
            LVLSPD_playerDeathsValue:Show()
        else
            LVLSPD_playerDeathsValue = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
            LVLSPD_playerDeathsValue:SetFontHeight(14)
            if ( not LVLSPD_lsElements.showAsBar ) then
                currentPoint = LVLSPD_calculateElementPoint()
                LVLSPD_playerDeathsValue:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            else
                local valuePoint = currentPoint[1] + LVLSPD_elementDeviation.playerDeaths
                LVLSPD_playerDeathsValue:SetPoint(currentPoint[0], valuePoint, 0)
            end
            LVLSPD_playerDeathsValue:SetText(LVLSPD_deathCount)
        end

        LVLSPD_numberCreatedElements = LVLSPD_numberCreatedElements + 1
    end
    if(LVLSPD_lsElements.showSessionHonor and LVLSPD_numberCreatedElements < 6) then
        if(LVLSPD_sessionHonorText) then
            currentPoint = LVLSPD_calculateElementPoint()
            if ( not LVLSPD_lsElements.showAsBar ) then
                LVLSPD_sessionHonorText:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            else
                LVLSPD_sessionHonorText:SetPoint(currentPoint[0], currentPoint[1], 0)
            end
            LVLSPD_sessionHonorText:Show()
        else
            LVLSPD_sessionHonorText = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GAmeFontGreen")
            LVLSPD_sessionHonorText:SetFontHeight(11)
            currentPoint = LVLSPD_calculateElementPoint()
            if ( not LVLSPD_lsElements.showAsBar ) then
                LVLSPD_sessionHonorText:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            else
                LVLSPD_sessionHonorText:SetPoint(currentPoint[0], currentPoint[1], 0)
            end
            LVLSPD_sessionHonorText:SetText("Session Honor:")
        end
        if(LVLSPD_sessionHonorValue) then
            if ( not LVLSPD_lsElements.showAsBar ) then
                currentPoint = LVLSPD_calculateElementPoint()
                LVLSPD_sessionHonorValue:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            else
                local valuePoint = currentPoint[1] + LVLSPD_elementDeviation.sessionHonor
                LVLSPD_sessionHonorValue:SetPoint(currentPoint[0], valuePoint, 0)
            end
            LVLSPD_sessionHonorValue:SetText(ls.sessionHonor)
            LVLSPD_sessionHonorValue:Show()
        else
            LVLSPD_sessionHonorValue = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
            LVLSPD_sessionHonorValue:SetFontHeight(14)
            if ( not LVLSPD_lsElements.showAsBar ) then
                currentPoint = LVLSPD_calculateElementPoint()
                LVLSPD_sessionHonorValue:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            else
                local valuePoint = currentPoint[1] + LVLSPD_elementDeviation.sessionHonor
                LVLSPD_sessionHonorValue:SetPoint(currentPoint[0], valuePoint, 0)
            end
            LVLSPD_sessionHonorValue:SetText(ls.sessionHonor)
        end

        LVLSPD_numberCreatedElements = LVLSPD_numberCreatedElements + 1
    end
    if (LVLSPD_lsElements.showFarmXpPerMin and LVLSPD_numberCreatedElements < 6) then
        if(LVLSPD_farmXpPerMinText) then
            currentPoint = LVLSPD_calculateElementPoint()
            if ( not LVLSPD_lsElements.showAsBar ) then
                LVLSPD_farmXpPerMinText:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            else
                LVLSPD_farmXpPerMinText:SetPoint(currentPoint[0], currentPoint[1], 0)
            end
            LVLSPD_farmXpPerMinText:Show()
        else
            LVLSPD_farmXpPerMinText = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontGreen")
            LVLSPD_farmXpPerMinText:SetFontHeight(11)
            currentPoint = LVLSPD_calculateElementPoint()
            if ( not LVLSPD_lsElements.showAsBar ) then
                LVLSPD_farmXpPerMinText:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            else
                LVLSPD_farmXpPerMinText:SetPoint(currentPoint[0], currentPoint[1], 0)
            end
            LVLSPD_farmXpPerMinText:SetText("XP/m (Farm):")
        end
        if(LVLSPD_farmXpPerMinValue) then
            if ( not LVLSPD_lsElements.showAsBar ) then
                currentPoint = LVLSPD_calculateElementPoint()
                LVLSPD_farmXpPerMinValue:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            else
                local valuePoint = currentPoint[1] + LVLSPD_elementDeviation.farmXpPerMin
                LVLSPD_farmXpPerMinValue:SetPoint(currentPoint[0], valuePoint, 0)
            end
            LVLSPD_farmXpPerMinValue:Show()
        else
            LVLSPD_farmXpPerMinValue = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
            LVLSPD_farmXpPerMinValue:SetFontHeight(14)
            if ( not LVLSPD_lsElements.showAsBar ) then
                currentPoint = LVLSPD_calculateElementPoint()
                LVLSPD_farmXpPerMinValue:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            else
                local valuePoint = currentPoint[1] + LVLSPD_elementDeviation.farmXpPerMin
                LVLSPD_farmXpPerMinValue:SetPoint(currentPoint[0], valuePoint, 0)
            end
            LVLSPD_farmXpPerMinValue:SetText(0)
        end

        LVLSPD_numberCreatedElements = LVLSPD_numberCreatedElements + 1
    end

    if (LVLSPD_lsElements.showXpPerMin and LVLSPD_numberCreatedElements < 6) then
        if(LVLSPD_xpPerMinText) then
            currentPoint = LVLSPD_calculateElementPoint()
            if ( not LVLSPD_lsElements.showAsBar ) then
                LVLSPD_xpPerMinText:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            else
                LVLSPD_xpPerMinText:SetPoint(currentPoint[0], currentPoint[1], 0)
            end
            LVLSPD_xpPerMinText:Show()
        else
            LVLSPD_xpPerMinText = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontGreen")
            LVLSPD_xpPerMinText:SetFontHeight(11)
            currentPoint = LVLSPD_calculateElementPoint()
            if ( not LVLSPD_lsElements.showAsBar ) then
                LVLSPD_xpPerMinText:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            else
                LVLSPD_xpPerMinText:SetPoint(currentPoint[0], currentPoint[1], 0)
            end
            LVLSPD_xpPerMinText:SetText("XP/m (All):")
        end
        if(LVLSPD_xpPerMinValue) then
            if ( not LVLSPD_lsElements.showAsBar ) then
                currentPoint = LVLSPD_calculateElementPoint()
                LVLSPD_xpPerMinValue:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            else
                local valuePoint = currentPoint[1] + LVLSPD_elementDeviation.xpPerMin
                LVLSPD_xpPerMinValue:SetPoint(currentPoint[0], valuePoint, 0)
            end
            LVLSPD_xpPerMinValue:Show()
        else
            LVLSPD_xpPerMinValue = LVLSPD_mainFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
            LVLSPD_xpPerMinValue:SetFontHeight(14)
            if ( not LVLSPD_lsElements.showAsBar ) then
                currentPoint = LVLSPD_calculateElementPoint()
                LVLSPD_xpPerMinValue:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            else
                local valuePoint = currentPoint[1] + LVLSPD_elementDeviation.xpPerMin
                LVLSPD_xpPerMinValue:SetPoint(currentPoint[0], valuePoint, 0)
            end
            LVLSPD_xpPerMinValue:SetText(0)
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