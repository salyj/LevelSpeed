local AceGUI = LibStub("AceGUI-3.0")

function CreateWindow()
    local OptionsGUI = _LSOptions()
    LibStub("AceConfig-3.0"):RegisterOptionsTable("LevelSpeed", OptionsGUI)
    LibStub("AceConfigDialog-3.0"):AddToBlizOptions("LevelSpeed", "Level Speed")

    local optionsFrame = AceGUI:Create("Frame")
    LibStub("AceConfigDialog-3.0"):SetDefaultSize("LevelSpeed", 400, 300)
    LibStub("AceConfigDialog-3.0"):Open("LevelSpeed", optionsFrame)
    optionsFrame:Hide();

    LSOptionsFrame = optionsFrame.frame
    table.insert(UISpecialFrames, "LSOptionsFrame")
end

_LSOptions = function()
    return {
        name = "LevelSpeed Options",
        type = "group",
        args = {
            showFarmXPS = {
                type = "toggle",
                name = "Show Farm XPS",
                desc = "Show Experience per second while in combat - Maximum of 6 elements can be shown at once",
                get = function() return lsElements.showFarmXPS end,
                set = function(info, val) 
                if (numberCreatedElements < 6) then
                    lsElements.showFarmXPS = val 
                else
                    lsElements.showFarmXPS = false
                end
                LSRebuild_Elements()
                end,
            },
            showAllXPS = {
                type = "toggle",
                name = "Show All XPS",
                desc = "Show Experience per second overall - Maximum of 6 elements can be shown at once",
                get = function() return lsElements.showAllXPS end,
                set = function(info, val)
                if (numberCreatedElements < 6) then
                    lsElements.showAllXPS = val
                else
                    lsElements.showAllXPS = false
                end
                LSRebuild_Elements()
                end,
            },
            showTimeToLevel = {
                type = "toggle",
                name = "Show Time to Level",
                desc = "Show estimated time to level based on overall XPS - Maximum of 6 elements can be shown at once",
                get = function() return lsElements.showTimeToLevel end,
                set = function(info, val)
                if (numberCreatedElements < 6) then
                    lsElements.showTimeToLevel = val
                else
                    lsElements.showTimeToLevel = false
                end
                LSRebuild_Elements()
                end,
            },
            showKillsToLevel = {
                type = "toggle",
                name = "Show Kills to Level",
                desc = "Show estimated kills to level based on farm XPS - Maximum of 6 elements can be shown at once",
                get = function() return lsElements.showKillsToLevel end,
                set = function(info, val)
                if (numberCreatedElements < 6) then
                    lsElements.showKillsToLevel = val
                else
                    lsElements.showKillsToLevel = false
                end
                LSRebuild_Elements()
                end,
            },
            showLastKillXP = {
                type = "toggle",
                name = "Show Last Kill XP",
                desc = "Show experience gained from last kill - Maximum of 6 elements can be shown at once",
                get = function() return lsElements.showLastKillXP end,
                set = function(info, val)
                if (numberCreatedElements < 6) then
                    lsElements.showLastKillXP = val
                else
                    lsElements.showLastKillXP = false
                end
                LSRebuild_Elements()
                end,
            },
            showTotalXP = {
                type = "toggle",
                name = "Show Total XP",
                desc = "Show total experience gained since login - Maximum of 6 elements can be shown at once",
                get = function() return lsElements.showTotalXP end,
                set = function(info, val)
                if (numberCreatedElements < 6) then
                    lsElements.showTotalXP = val
                else
                    lsElements.showTotalXP = false
                end
                LSRebuild_Elements()
                end,
            },
            showGoldPerHour = {
                type = "toggle",
                name = "Show Gold Per Hour",
                desc = "Show estimated gold earned per hour since login - Maximum of 6 elements can be shown at once",
                get = function() return lsElements.showGoldPerHour end,
                set = function(info, val)
                if (numberCreatedElements < 6) then
                    lsElements.showGoldPerHour = val
                else
                    lsElements.showGoldPerHour = false
                end
                LSRebuild_Elements()
                end,
            }
        }
    }
end

function ToggleOptionsWindow()
    if (not optionsFrame:IsShown()) then
        optionsFrame:Show()
    else
        optionsFrame:Hide()
    end
end

CreateWindow() -- I know, I could have made this not a function if I was just going to call it anyways, but this is for future work