lsElements = {
    showFarmXPS = true,
    showAllXPS = true,
    showTimeToLevel = true,
    showKillsToLevel = true,
    showLastKillXP = false,
    showTotalXP = false,
    showGoldPerHour = false
}

lsOneElePoints = {
    [0] = {0, -5, false}, 
    [1] = {0, -20, false}
}

lsTwoElePoints = {
    [0] = {-50, -5, false}, 
    [1] = {-50, -20, false}, 
    [2] = {50, -5, false}, 
    [3] = {50, -20, false}
}

lsThreeElePoints = {
    [0] = {-50, 20, false},
    [1] = {-50, 5, false},
    [2] = {50, 20, false},
    [3] = {50, 5, false},
    [4] = {0, -25, false},
    [5] = {0, -40, false}
}

lsFourElePoints = {
    [0] = {-50, 20, false}, 
    [1] ={-50, 5, false}, 
    [2] = {50, 20, false}, 
    [3] = {50, 5, false}, 
    [4] = {-50, -25, false}, 
    [5] = {-50, -40, false}, 
    [6] = {50, -25, false}, 
    [7] = {50, -40, false}
}

lsFiveElePoints = {
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

lsSixElePoints = {
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
numberCreatedElements = 0

function LSGetNumberOfElements()
    numberOfElements = 0
    for element, value in pairs(lsElements) do
        if value == true then
            numberOfElements = numberOfElements + 1
        end
    end
end

function resetPointsList(list)
    for i=0, #list do
        list[i][3] = false
    end
end

function calculateElementPoint()
    pointsList = {}
    returnArray = {"CENTER", 0, 0}
    foundPoint = false
    loopIterator = 0

    if numberOfElements == 1 then
        pointsList = lsOneElePoints
    elseif numberOfElements == 2 then
        pointsList = lsTwoElePoints
    elseif numberOfElements == 3 then
        pointsList = lsThreeElePoints
    elseif numberOfElements == 4 then
        pointsList = lsFourElePoints
    elseif numberOfElements == 5 then
        pointsList = lsFiveElePoints
    elseif numberOfElements == 6 then
        pointsList = lsSixElePoints
    end

    while(foundPoint == false) do
        if pointsList[loopIterator][3] == false then
            returnArray[0] = "CENTER"
            returnArray[1] = pointsList[loopIterator][1]
            returnArray[2] = pointsList[loopIterator][2]
            pointsList[loopIterator][3] = true
            foundPoint = true
        else
            loopIterator = loopIterator + 1
        end
    end

    return returnArray
end

function setMainFrameSize()
    if numberOfElements <= 2 then
        mainFrame:SetSize(235,75)
    elseif numberOfElements <= 4 then
        mainFrame:SetSize(235,115)
    else
        mainFrame:SetSize(320,115)
    end
end

mainFrame = CreateFrame("Frame", "mainFrame_LocationMove", UIParent,"InsetFrameTemplate3")
mainFrame:SetPoint("TOP",0,-10)

mainFrame:SetMovable(true)
mainFrame:EnableMouse(true)
mainFrame:RegisterForDrag("LeftButton")
mainFrame:SetScript("OnDragStart", function(self)
    self:StartMoving()
  end)
mainFrame:SetScript("OnDragStop", function(self)
    self:StopMovingOrSizing()
  end)

local titleFrame = CreateFrame("Frame", nil, mainFrame,"InsetFrameTemplate3")
titleFrame:SetPoint("TOP",0,0)
titleFrame:SetSize(200,25)

local titleMain = titleFrame:CreateFontString("ARTWORK", nil, "GameFontRed")
titleMain:SetPoint("CENTER")
titleMain:SetText("Level Speed")

function LSCreate_Elements()

    LSGetNumberOfElements()
    setMainFrameSize()

    if lsElements.showAllXPS and numberCreatedElements < 6 then
        xpps1 = mainFrame:CreateFontString("ARTWORK", nil, "GameFontGreen")
        currentPoint = calculateElementPoint()
        xpps1:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
        xpps1:SetText("XP/s (All)")

        xpps = mainFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
        currentPoint = calculateElementPoint()
        xpps:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
        xpps:SetText(0)

        numberCreatedElements = numberCreatedElements + 1
    end

    if lsElements.showFarmXPS and numberCreatedElements < 6 then
        xpps4 = mainFrame:CreateFontString("ARTWORK", nil, "GameFontGreen")
        currentPoint = calculateElementPoint()
        xpps4:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
        xpps4:SetText("XP/s (Farm)")

        xpps3 = mainFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
        currentPoint = calculateElementPoint()
        xpps3:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
        xpps3:SetText(0)

        numberCreatedElements = numberCreatedElements + 1
    end

    if lsElements.showTimeToLevel and numberCreatedElements < 6 then
        kills_toLevel1 = mainFrame:CreateFontString("ARTWORK", nil, "GameFontGreen")
        currentPoint = calculateElementPoint()
        kills_toLevel1:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
        kills_toLevel1:SetText("Next Level (m)")

        kills_toLevel = mainFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
        currentPoint = calculateElementPoint()
        kills_toLevel:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
        kills_toLevel:SetText(0)

        numberCreatedElements = numberCreatedElements + 1
    end

    if lsElements.showKillsToLevel and numberCreatedElements < 6 then
        kills_toLevel3 = mainFrame:CreateFontString("ARTWORK", nil, "GameFontGreen")
        currentPoint = calculateElementPoint()
        kills_toLevel3:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
        kills_toLevel3:SetText("Kills Left:")

        kills_toLevel2 = mainFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
        currentPoint = calculateElementPoint()
        kills_toLevel2:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
        kills_toLevel2:SetText(0)

        numberCreatedElements = numberCreatedElements + 1
    end

    if lsElements.showLastKillXP and numberCreatedElements < 6 then
        lastKillXPText = mainFrame:CreateFontString("ARTWORK", nil, "GameFontGreen")
        currentPoint = calculateElementPoint()
        lastKillXPText:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
        lastKillXPText:SetText("Last Kill XP:")

        lastKillXPValue = mainFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
        currentPoint = calculateElementPoint()
        lastKillXPValue:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
        lastKillXPValue:SetText(0)

        numberCreatedElements = numberCreatedElements + 1
    end

    if lsElements.showTotalXP and numberCreatedElements < 6 then
        totalXPText = mainFrame:CreateFontString("ARTWORK", nil, "GameFontGreen")
        currentPoint = calculateElementPoint()
        totalXPText:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
        totalXPText:SetText("Total XP:")

        totalXPValue = mainFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
        currentPoint = calculateElementPoint()
        totalXPValue:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
        totalXPValue:SetText(calculateTotalXP())

        numberCreatedElements = numberCreatedElements + 1
    end

    if lsElements.showGoldPerHour and numberCreatedElements < 6 then
        goldPerHourText = mainFrame:CreateFontString("ARTWORK", nil, "GameFontGreen")
        currentPoint = calculateElementPoint()
        goldPerHourText:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
        goldPerHourText:SetText("Gold/Hour:")

        goldPerHourValue = mainFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
        currentPoint = calculateElementPoint()
        goldPerHourValue:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
        goldPerHourValue:SetText("0g 0s 0c")

        numberCreatedElements = numberCreatedElements + 1
    end

    getStuff()
end

-----------------------------------------------
-- There is probably a better way to do this --
-----------------------------------------------
function LSHideAllElements()
    if(xpps1 ~= nil) then
        xpps1:Hide()
    end
    if(xpps ~= nil) then
        xpps:Hide()
    end
    if(xpps4 ~= nil) then
        xpps4:Hide()
    end
    if(xpps3 ~= nil) then
        xpps3:Hide()
    end
    if(kills_toLevel1 ~= nil) then
        kills_toLevel1:Hide()
    end
    if(kills_toLevel ~= nil) then
        kills_toLevel:Hide()
    end
    if(kills_toLevel3 ~= nil) then
        kills_toLevel3:Hide()
    end
    if(kills_toLevel2 ~= nil) then
        kills_toLevel2:Hide()
    end
    if(lastKillXPText ~= nil) then
        lastKillXPText:Hide()
    end
    if(lastKillXPValue ~= nil) then
        lastKillXPValue:Hide()
    end
    if(totalXPText ~= nil) then
        totalXPText:Hide()
    end
    if(totalXPValue ~= nil) then
        totalXPValue:Hide()
    end
    if(goldPerHourText ~= nil) then
        goldPerHourText:Hide()
    end
    if(goldPerHourValue ~= nil) then
        goldPerHourValue:Hide()
    end
end

function LSRebuild_Elements()
    LSGetNumberOfElements()
    setMainFrameSize()
    LSHideAllElements()
    resetPointsList(pointsList)
    numberCreatedElements = 0

    if(lsElements.showAllXPS and numberCreatedElements < 6) then
        if(xpps1) then
            currentPoint = calculateElementPoint()
            xpps1:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            xpps1:Show()
        else
            xpps1 = mainFrame:CreateFontString("ARTWORK", nil, "GameFontGreen")
            currentPoint = calculateElementPoint()
            xpps1:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            xpps1:SetText("XP/s (All)")
        end

        if(xpps) then
            currentPoint = calculateElementPoint()
            xpps:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            xpps:Show()
        else
            xpps = mainFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
            currentPoint = calculateElementPoint()
            xpps:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            xpps:SetText(0)    
        end
        
        numberCreatedElements = numberCreatedElements + 1
    end
    if(lsElements.showFarmXPS and numberCreatedElements < 6) then
        if(xpps4) then
            currentPoint = calculateElementPoint()
            xpps4:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            xpps4:Show()
        else
            xpps4 = mainFrame:CreateFontString("ARTWORK", nil, "GameFontGreen")
            currentPoint = calculateElementPoint()
            xpps4:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            xpps4:SetText("XP/s (Farm)")
        end
        if(xpps3) then
            currentPoint = calculateElementPoint()
            xpps3:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            xpps3:Show()
        else
            xpps3 = mainFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
            currentPoint = calculateElementPoint()
            xpps3:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            xpps3:SetText(0)
        end

        numberCreatedElements = numberCreatedElements + 1
    end
    if(lsElements.showTimeToLevel and numberCreatedElements < 6) then
        if(kills_toLevel1) then
            currentPoint = calculateElementPoint()
            kills_toLevel1:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            kills_toLevel1:Show()
        else
            kills_toLevel1 = mainFrame:CreateFontString("ARTWORK", nil, "GameFontGreen")
            currentPoint = calculateElementPoint()
            kills_toLevel1:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            kills_toLevel1:SetText("Next Level (m)")
        end
        if(kills_toLevel) then
            currentPoint = calculateElementPoint()
            kills_toLevel:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            kills_toLevel:Show()
        else
            kills_toLevel = mainFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
            currentPoint = calculateElementPoint()
            kills_toLevel:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            kills_toLevel:SetText(0)
        end

        numberCreatedElements = numberCreatedElements + 1
    end
    if(lsElements.showKillsToLevel and numberCreatedElements < 6) then
        if(kills_toLevel3) then
            currentPoint = calculateElementPoint()
            kills_toLevel3:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            kills_toLevel3:Show()
        else
            kills_toLevel3 = mainFrame:CreateFontString("ARTWORK", nil, "GameFontGreen")
            currentPoint = calculateElementPoint()
            kills_toLevel3:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            kills_toLevel3:SetText("Kills Left:")
        end
        if(kills_toLevel2) then
            currentPoint = calculateElementPoint()
            kills_toLevel2:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            kills_toLevel2:Show()
        else
            kills_toLevel2 = mainFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
            currentPoint = calculateElementPoint()
            kills_toLevel2:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            kills_toLevel2:SetText(0)
        end

        numberCreatedElements = numberCreatedElements + 1
    end
    if(lsElements.showLastKillXP and numberCreatedElements < 6) then
        if(lastKillXPText) then
            currentPoint = calculateElementPoint()
            lastKillXPText:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            lastKillXPText:Show()
        else
            lastKillXPText = mainFrame:CreateFontString("ARTWORK", nil, "GameFontGreen")
            currentPoint = calculateElementPoint()
            lastKillXPText:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            lastKillXPText:SetText("Last Kill XP:")
        end
        if(lastKillXPValue) then
            currentPoint = calculateElementPoint()
            lastKillXPValue:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            lastKillXPValue:Show()
        else
            lastKillXPValue = mainFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
            currentPoint = calculateElementPoint()
            lastKillXPValue:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            lastKillXPValue:SetText(0)
        end

        numberCreatedElements = numberCreatedElements + 1
    end
    if(lsElements.showTotalXP and numberCreatedElements < 6) then
        if(totalXPText) then
            currentPoint = calculateElementPoint()
            totalXPText:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            totalXPText:Show()
        else
            totalXPText = mainFrame:CreateFontString("ARTWORK", nil, "GameFontGreen")
            currentPoint = calculateElementPoint()
            totalXPText:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            totalXPText:SetText("Total XP:")
        end
        if(totalXPValue) then
            currentPoint = calculateElementPoint()
            totalXPValue:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            totalXPValue:Show()
        else
            totalXPValue = mainFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
            currentPoint = calculateElementPoint()
            totalXPValue:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            totalXPValue:SetText(calculateTotalXP())
        end

        numberCreatedElements = numberCreatedElements + 1
    end
    if(lsElements.showGoldPerHour and numberCreatedElements < 6) then
        if(goldPerHourText) then
            currentPoint = calculateElementPoint()
            goldPerHourText:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            goldPerHourText:Show()
        else
            goldPerHourText = mainFrame:CreateFontString("ARTWORK", nil, "GameFontGreen")
            currentPoint = calculateElementPoint()
            goldPerHourText:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            goldPerHourText:SetText("Gold/Hour:")
        end
        if(goldPerHourValue) then
            currentPoint = calculateElementPoint()
            goldPerHourValue:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            goldPerHourValue:Show()
        else
            goldPerHourValue = mainFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
            currentPoint = calculateElementPoint()
            goldPerHourValue:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
            goldPerHourValue:SetText(0)
        end

        numberCreatedElements = numberCreatedElements + 1
    end
end