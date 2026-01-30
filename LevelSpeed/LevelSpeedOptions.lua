local AceGUI = LibStub("AceGUI-3.0")

function LVLSPD_CreateWindow()
    local OptionsGUI = LVLSPD_LSOptions()
    LibStub("AceConfig-3.0"):RegisterOptionsTable("LevelSpeed", OptionsGUI)
    LibStub("AceConfigDialog-3.0"):AddToBlizOptions("LevelSpeed", "Level Speed")

    LVLSPD_optionsFrame = AceGUI:Create("Frame")
    LibStub("AceConfigDialog-3.0"):SetDefaultSize("LevelSpeed", 400, 300)
    LibStub("AceConfigDialog-3.0"):Open("LevelSpeed", LVLSPD_optionsFrame)
    LVLSPD_optionsFrame:Hide();

    LVLSPD_LSOptionsFrame = LVLSPD_optionsFrame.frame
    table.insert(UISpecialFrames, "LVLSPD_LSOptionsFrame")
end

LVLSPD_LSOptions = function()
    return {
        name = "LevelSpeed Options",
        type = "group",
        args = {
            showFarmXPS = {
                type = "toggle",
                name = "Show Farm XPS",
                desc = "Show Experience per second while in combat - Maximum of 6 elements can be shown at once",
                get = function() return LVLSPD_lsElements.showFarmXPS end,
                set = function(info, val) 
                if (LVLSPD_numberCreatedElements < 6) then
                    LVLSPD_lsElements.showFarmXPS = val 
                else
                    LVLSPD_lsElements.showFarmXPS = false
                end
                LVLSPD_LSRebuild_Elements()
                end,
            },
            showAllXPS = {
                type = "toggle",
                name = "Show All XPS",
                desc = "Show Experience per second overall - Maximum of 6 elements can be shown at once",
                get = function() return LVLSPD_lsElements.showAllXPS end,
                set = function(info, val)
                if (LVLSPD_numberCreatedElements < 6) then
                    LVLSPD_lsElements.showAllXPS = val
                else
                    LVLSPD_lsElements.showAllXPS = false
                end
                LVLSPD_LSRebuild_Elements()
                end,
            },
            showTimeToLevel = {
                type = "toggle",
                name = "Show Time to Level",
                desc = "Show estimated time to level based on overall XPS - Maximum of 6 elements can be shown at once",
                get = function() return LVLSPD_lsElements.showTimeToLevel end,
                set = function(info, val)
                if (LVLSPD_numberCreatedElements < 6) then
                    LVLSPD_lsElements.showTimeToLevel = val
                else
                    LVLSPD_lsElements.showTimeToLevel = false
                end
                LVLSPD_LSRebuild_Elements()
                end,
            },
            showKillsToLevel = {
                type = "toggle",
                name = "Show Kills to Level",
                desc = "Show estimated kills to level based on farm XPS - Maximum of 6 elements can be shown at once",
                get = function() return LVLSPD_lsElements.showKillsToLevel end,
                set = function(info, val)
                if (LVLSPD_numberCreatedElements < 6) then
                    LVLSPD_lsElements.showKillsToLevel = val
                else
                    LVLSPD_lsElements.showKillsToLevel = false
                end
                LVLSPD_LSRebuild_Elements()
                end,
            },
            showLastKillXP = {
                type = "toggle",
                name = "Show Last Kill XP",
                desc = "Show experience gained from last kill - Maximum of 6 elements can be shown at once",
                get = function() return LVLSPD_lsElements.showLastKillXP end,
                set = function(info, val)
                if (LVLSPD_numberCreatedElements < 6) then
                    LVLSPD_lsElements.showLastKillXP = val
                else
                    LVLSPD_lsElements.showLastKillXP = false
                end
                LVLSPD_LSRebuild_Elements()
                end,
            },
            showTotalXP = {
                type = "toggle",
                name = "Show Total XP",
                desc = "Show total experience gained since login - Maximum of 6 elements can be shown at once",
                get = function() return LVLSPD_lsElements.showTotalXP end,
                set = function(info, val)
                if (LVLSPD_numberCreatedElements < 6) then
                    LVLSPD_lsElements.showTotalXP = val
                else
                    LVLSPD_lsElements.showTotalXP = false
                end
                LVLSPD_LSRebuild_Elements()
                end,
            },
            showGoldPerHour = {
                type = "toggle",
                name = "Show Gold Per Hour",
                desc = "Show estimated gold earned per hour since login - Maximum of 6 elements can be shown at once",
                get = function() return LVLSPD_lsElements.showGoldPerHour end,
                set = function(info, val)
                if (LVLSPD_numberCreatedElements < 6) then
                    LVLSPD_lsElements.showGoldPerHour = val
                else
                    LVLSPD_lsElements.showGoldPerHour = false
                end
                LVLSPD_LSRebuild_Elements()
                end,
            }
        }
    }
end

function LVLSPD_ToggleOptionsWindow()
    if (not LVLSPD_optionsFrame:IsShown()) then
        LVLSPD_optionsFrame:Show()
    else
        LVLSPD_optionsFrame:Hide()
    end
end

LVLSPD_CreateWindow() -- I know, I could have made this not a function if I was just going to call it anyways, but this is for future work