lsElements = {
    showFarmXPS = true,
    showAllXPS = true,
    showTimeToLevel = true,
    showKillsToLevel = true,
    showLastKillXP = false,
    showTotalXP = false
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

for element, value in pairs(lsElements) do
    if value == true then
        numberOfElements = numberOfElements + 1
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

    -- for i = 1, #pointsList, 3 do
    --     print("checking point at index: "..i, pointsList[i][1], pointsList[i][2], pointsList[i][3])
    --     if pointsList[i][3] == false then
    --         returnArray[0] = "CENTER"
    --         returnArray[1] = pointsList[i][1]
    --         returnArray[2] = pointsList[i][2]
    --         pointsList[i][3] = true
    --         break
    --     end
    -- end
    return returnArray
end

mainFrame = CreateFrame("Frame", "mainFrame_LocationMove", UIParent,"InsetFrameTemplate3")
mainFrame:SetPoint("TOP",0,-10)
if numberOfElements <= 2 then
    mainFrame:SetSize(200,75)
elseif numberOfElements <= 4 then
    mainFrame:SetSize(200,115)
else
    mainFrame:SetSize(320,115)
end

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

if lsElements.showAllXPS then
    local xpps1 = mainFrame:CreateFontString("ARTWORK", nil, "GameFontGreen")
    currentPoint = calculateElementPoint()
    xpps1:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
    -- if numberOfElements <= 2 then
    --     xpps1:SetPoint("CENTER",-50,-5)
    -- else
    --     xpps1:SetPoint("CENTER",-50,20)
    -- end
    xpps1:SetText("XP/s (All)")

    xpps = mainFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
    currentPoint = calculateElementPoint()
    xpps:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
    -- if numberOfElements <= 2 then
    --     xpps:SetPoint("CENTER",-50,-20)
    -- else
    --     xpps:SetPoint("CENTER",-50,5)
    -- end
    xpps:SetText(0)    
end

if lsElements.showFarmXPS then
    local xpps4 = mainFrame:CreateFontString("ARTWORK", nil, "GameFontGreen")
    currentPoint = calculateElementPoint()
    xpps4:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
    -- if numberOfElements <= 2 then
    --     xpps4:SetPoint("CENTER",50,-5)
    -- else
    --     xpps4:SetPoint("CENTER",50,20)
    -- end
    xpps4:SetText("XP/s (Farm)")

    xpps3 = mainFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
    currentPoint = calculateElementPoint()
    xpps3:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
    -- if numberOfElements <= 2 then
    --     xpps3:SetPoint("CENTER",50,-20)
    -- else
    --     xpps3:SetPoint("CENTER",50,5)
    -- end
    xpps3:SetText(0)
end

if lsElements.showTimeToLevel then
    local kills_toLevel1 = mainFrame:CreateFontString("ARTWORK", nil, "GameFontGreen")
    currentPoint = calculateElementPoint()
    kills_toLevel1:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
    -- if numberOfElements <= 2 then
    --     kills_toLevel1:SetPoint("CENTER",-50,-5)
    -- else
    --     kills_toLevel1:SetPoint("CENTER",-50,-25)
    -- end
    kills_toLevel1:SetText("Next Level (m)")

    kills_toLevel = mainFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
    currentPoint = calculateElementPoint()
    kills_toLevel:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
    -- if numberOfElements <= 2 then
    --     kills_toLevel:SetPoint("CENTER", -50, -20)
    -- else
    --     kills_toLevel:SetPoint("CENTER",-50,-40)
    -- end
    kills_toLevel:SetText(0)
end

if lsElements.showKillsToLevel then
    local kills_toLevel3 = mainFrame:CreateFontString("ARTWORK", nil, "GameFontGreen")
    currentPoint = calculateElementPoint()
    kills_toLevel3:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
    -- if numberOfElements <= 2 then
    --     kills_toLevel3:SetPoint("CENTER",50,-5)
    -- else
    --     kills_toLevel3:SetPoint("CENTER",50,-25)
    -- end
    kills_toLevel3:SetText("Kills Left:")

    kills_toLevel2 = mainFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
    currentPoint = calculateElementPoint()
    kills_toLevel2:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
    -- if numberOfElements <= 2 then
    --     kills_toLevel2:SetPoint("CENTER", 50, -20)
    -- else
    --     kills_toLevel2:SetPoint("CENTER",50,-40)
    -- end
    kills_toLevel2:SetText(0)
end

if lsElements.showLastKillXP then
    local lastKillXPText = mainFrame:CreateFontString("ARTWORK", nil, "GameFontGreen")
    currentPoint = calculateElementPoint()
    lastKillXPText:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
    lastKillXPText:SetText("Last Kill XP:")

    lastKillXPValue = mainFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
    currentPoint = calculateElementPoint()
    lastKillXPValue:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
    lastKillXPValue:SetText(0)
end

if lsElements.showTotalXP then
    local totalXPText = mainFrame:CreateFontString("ARTWORK", nil, "GameFontGreen")
    currentPoint = calculateElementPoint()
    totalXPText:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
    totalXPText:SetText("Total XP:")

    totalXPValue = mainFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
    currentPoint = calculateElementPoint()
    totalXPValue:SetPoint(currentPoint[0], currentPoint[1], currentPoint[2])
    totalXPValue:SetText(0)
end