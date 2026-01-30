LVLSPD_lsElements = {
    showFarmXPS = true,
    showAllXPS = true,
    showTimeToLevel = true,
    showKillsToLevel = true,
    showLastKillXP = false,
    showTotalXP = false,
    showGoldPerHour = false
}

LVLSPD_lsOneElePoints = {
    [0] = {0, -5, false}, 
    [1] = {0, -20, false}
}

LVLSPD_lsTwoElePoints = {
    [0] = {-50, -5, false}, 
    [1] = {-50, -20, false}, 
    [2] = {50, -5, false}, 
    [3] = {50, -20, false}
}

LVLSPD_lsThreeElePoints = {
    [0] = {-50, 20, false},
    [1] = {-50, 5, false},
    [2] = {50, 20, false},
    [3] = {50, 5, false},
    [4] = {0, -25, false},
    [5] = {0, -40, false}
}

LVLSPD_lsFourElePoints = {
    [0] = {-50, 20, false}, 
    [1] ={-50, 5, false}, 
    [2] = {50, 20, false}, 
    [3] = {50, 5, false}, 
    [4] = {-50, -25, false}, 
    [5] = {-50, -40, false}, 
    [6] = {50, -25, false}, 
    [7] = {50, -40, false}
}

LVLSPD_lsFiveElePoints = {
    [0] = {-100, 20, false},
    [1] = {-100, 5, false},
    [2] = {0, 20, false},
    [3] = {0, 5, false},
    [4] = {100, 20, false},
    [5] = {100, 5, false},
    [6] = {-50, -25, false},
    [7] = {-50, -40, false},
    [8] = {50, -25, false},
    [9] = {50, -40, false}
}

LVLSPD_lsSixElePoints = {
    [0] = {-100, 20, false},
    [1] = {-100, 5, false},
    [2] = {0, 20, false},
    [3] = {0, 5, false},
    [4] = {100, 20, false},
    [5] = {100, 5, false},
    [6] = {-100, -25, false},
    [7] = {-100, -40, false},
    [8] = {0, -25, false},
    [9] = {0, -40, false},
    [10] = {100, -25, false},
    [11] = {100, -40, false}
}

local numberOfElements = 0
local currentPoint = {}
LVLSPD_numberCreatedElements = 0

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
    if numberOfElements <= 2 then
        LVLSPD_mainFrame:SetSize(235,75)
    elseif numberOfElements <= 4 then
        LVLSPD_mainFrame:SetSize(235,115)
    else
        LVLSPD_mainFrame:SetSize(320,115)
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

local titleFrame = CreateFrame("Frame", nil, LVLSPD_mainFrame,"InsetFrameTemplate3")
titleFrame:SetPoint("TOP",0,0)
titleFrame:SetSize(200,25)

local titleMain = titleFrame:CreateFontString("ARTWORK", nil, "GameFontRed")
titleMain:SetPoint("CENTER")
titleMain:SetText("Level Speed")

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
        LVLSPD_goldPerHourValue:SetText("0g 0s 0c")

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
            LVLSPD_goldPerHourValue:SetText(0)
        end

        LVLSPD_numberCreatedElements = LVLSPD_numberCreatedElements + 1
    end
end