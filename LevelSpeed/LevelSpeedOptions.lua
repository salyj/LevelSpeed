local AceGUI = LibStub("AceGUI-3.0")

function LVLSPD_CreateWindow()
    local OptionsGUI = LVLSPD_LSTabs()
    LibStub("AceConfig-3.0"):RegisterOptionsTable("LevelSpeed", OptionsGUI)
    LibStub("AceConfigDialog-3.0"):AddToBlizOptions("LevelSpeed", "Level Speed")

    LVLSPD_optionsFrame = AceGUI:Create("Frame")
    LibStub("AceConfigDialog-3.0"):SetDefaultSize("LevelSpeed", 400, 300)
    LibStub("AceConfigDialog-3.0"):Open("LevelSpeed", LVLSPD_optionsFrame)
    LVLSPD_optionsFrame:Hide();

    LVLSPD_LSOptionsFrame = LVLSPD_optionsFrame.frame
    table.insert(UISpecialFrames, "LVLSPD_LSOptionsFrame")
end

LVLSPD_LSTabs = function()
    return {
        name = "Level Speed Options",
        handler = LS,
        type = "group",
        childGroups = "tab",
        args = {
            Options_tab = LVLSPD_LSOptions(),
            About_tab = LVLSPD_LSAbout(),
        }
    }
end

LVLSPD_LSOptions = function()
    return {
        name = "Options",
        type = "group",
        order = 1,
        args = {
            toggleElementsGroup = {
                type = "group",
                name = "Toggle Elements - Max 6 at once",
                inline = true,
                order = 1,
                args = {
                    xPElementsGroup = {
                        type = "group",
                        name = "XP Elements",
                        inline = true,
                        order = 1,
                        args = {
                            showFarmXPS = {
                                type = "toggle",
                                name = "Show Farm XPS",
                                desc = "Show Experience per second while in combat",
                                order = 1,
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
                                desc = "Show Experience per second overall",
                                order = 1.1,
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
                            showXpPerMin = {
                                type = "toggle",
                                name = "Show XP/m (All)",
                                desc = "Show experience per minute overall",
                                order = 1.2,
                                get = function() return LVLSPD_lsElements.showXpPerMin end,
                                set = function(info, val)
                                if (LVLSPD_numberCreatedElements < 6) then
                                    LVLSPD_lsElements.showXpPerMin = val
                                else
                                    LVLSPD_lsElements.showXpPerMin = false
                                end
                                LVLSPD_LSRebuild_Elements()
                                end,
                            },
                            showFarmXpPerMin = {
                                type = "toggle",
                                name = "Show XP/m (Farm)",
                                desc = "Show experience per minute while in combat",
                                order = 1.3,
                                get = function() return LVLSPD_lsElements.showFarmXpPerMin end,
                                set = function(info, val)
                                if (LVLSPD_numberCreatedElements < 6) then
                                    LVLSPD_lsElements.showFarmXpPerMin = val
                                else
                                    LVLSPD_lsElements.showFarmXpPerMin = false
                                end
                                LVLSPD_LSRebuild_Elements()
                                end,
                            },
                            showTimeToLevel = {
                                type = "toggle",
                                name = "Show Time to Level",
                                desc = "Show estimated time to level based on overall XPS",
                                order = 1.4,
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
                                desc = "Show estimated kills to level based on farm XPS",
                                order = 1.5,
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
                                desc = "Show experience gained from last kill",
                                order = 1.6,
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
                                desc = "Show total experience gained since login",
                                order = 1.7,
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
                        }
                    },
                    goldElementsGroup = {
                        type = "group",
                        name = "Gold Elements",
                        inline = true,
                        order = 2,
                        args = {
                            showGoldPerHour = {
                                type = "toggle",
                                name = "Show Gold Per Hour",
                                desc = "Show estimated gold earned per hour since login",
                                order = 1,
                                get = function() return LVLSPD_lsElements.showGoldPerHour end,
                                set = function(info, val)
                                if (LVLSPD_numberCreatedElements < 6) then
                                    LVLSPD_lsElements.showGoldPerHour = val
                                else
                                    LVLSPD_lsElements.showGoldPerHour = false
                                end
                                LVLSPD_LSRebuild_Elements()
                                end,
                            },
                            showSessionGold = {
                                type = "toggle",
                                name = "Show Session Gold",
                                desc = "Show total gold earned since login",
                                order = 1.1,
                                get = function() return LVLSPD_lsElements.showSessionGold end,
                                set = function(info, val)
                                if (LVLSPD_numberCreatedElements < 6) then
                                    LVLSPD_lsElements.showSessionGold = val
                                else
                                    LVLSPD_lsElements.showSessionGold = false
                                end
                                LVLSPD_LSRebuild_Elements()
                                end,
                            },
                        }
                    },
                    otherElementsGroup = {
                        type = "group",
                        name = "Other Elements",
                        inline = true,
                        order = 3,
                        args = {
                            showPlayerDeaths = {
                                type = "toggle",
                                name = "Show Player Deaths",
                                desc = "Show number of times player has died",
                                order = 1,
                                get = function() return LVLSPD_lsElements.showPlayerDeaths end,
                                set = function(info, val)
                                if (LVLSPD_numberCreatedElements < 6) then
                                    LVLSPD_lsElements.showPlayerDeaths = val
                                else
                                    LVLSPD_lsElements.showPlayerDeaths = false
                                end
                                LVLSPD_LSRebuild_Elements()
                                end,
                            },
                            showSessionHonor = {
                                type = "toggle",
                                name = "Show Session Honor",
                                desc = "Show estimated amount of honor earned this session",
                                order = 1.1,
                                get = function() return LVLSPD_lsElements.showSessionHonor end,
                                set = function(inf, val)
                                    if(LVLSPD_numberCreatedElements < 6) then
                                        LVLSPD_lsElements.showSessionHonor = val
                                    else
                                        LVLSPD_lsElements.showSessionHonor = false
                                    end
                                    LVLSPD_LSRebuild_Elements()
                                end,
                            }
                        }
                    }
                }
            },
            sizingGroup = {
                type = "group",
                name = "Sizing Options",
                inline = true,
                order = 2,
                args = {
                    showAsBar = {
                        type = "toggle",
                        name = "Show As Bar",
                        desc = "Show main frame as a bar. Hides title.",
                        order = 1,
                        get = function() return LVLSPD_lsElements.showAsBar end,
                        set = function(info, val)
                            LVLSPD_lsElements.showAsBar = val
                            if val then
                                LVLSPD_setHideTitle(true)
                                LVLSPD_toggleHideTitle()
                            end
                            LVLSPD_LSRebuild_Elements()
                        end,
                    },
                    toggleTitle = {
                        type = "toggle",
                        name = "Hide Title",
                        desc = "Toggle the visibility of title on main frame",
                        order = 2,
                        get = function() return LVLSPD_getHideTitle() end,
                        set = function(info, val)
                            if (not LVLSPD_lsElements.showAsBar) then
                                LVLSPD_setHideTitle(val)
                            else
                                LVLSPD_setHideTitle(true)
                            end
                            LVLSPD_toggleHideTitle()
                            LVLSPD_LSRebuild_Elements()
                        end,
                    }
                }
            },
            cVarGroup = {
                type = "group",
                name = "Change Client Config Options - Requires reload",
                inline = true,
                order = 3,
                args = {
                    largeNumbersToggle = {
                        type = "toggle",
                        name = "Format Large Numbers",
                        desc = "Given 1234, On: \"1,234\" or \"1.234\" based on localization, Off: \"1234\"",
                        order = 1,
                        get = function()
                            if (C_CVar.GetCVar("breakUpLargeNumbers") == "1") then
                                return true
                            else
                                return false
                            end
                        end,
                        set = function(info, val)
                            if (val) then
                                C_CVar.SetCVar("breakUpLargeNumbers", 1)
                            else
                                C_CVar.SetCVar("breakUpLargeNumbers", 0)
                            end
                        end,
                    }
                }
            },
            reloadButton = {
                type = "execute",
                name = "Reload UI",
                desc = "Reload the client UI. Needed for any CVar changes",
                order = 4,
                func = function()
                    C_UI.Reload()
                end,
            },
        }
    }
end

LVLSPD_LSAbout = function()
    return {
        name = "About",
        type = "group",
        order = 2,
        args = {
            aboutHeader = {
                type = "header",
                name = "About",
                order = 1,
            },
            aboutText = {
                type = "description",
                name = "Level Speed - Anniversary version "..LVLSPD_versionNumber.."\nCreated by HKRob\n\n\nThis addon uses the GNU GPLv3 license. For more information, see: https://www.gnu.org/licenses/gpl-3.0.en.html",
                order = 2,
                fontSize = "medium",
            },
            thankYouHeader = {
                type = "header",
                name = "Note from the author",
                order = 3,
            },
            thankYouText = {
                type = "description",
                name = "It has been a long and exciting journey creating this addon. I personally really enjoyed working on it and providing the best experience I can through this addon. I will continue to work on and improve this addon over time, as well as keep it up to date with all the different versions of WoW.\n\nI want to thank you for downloading and using this addon. I hope you value it as much as I valued making it.\n\nI would also like to thank the following people that assisted with the creation of this addon:\n\n    \124cff00ffffMy wife Olivia\124r - For putting up with me while I worked on this\n    \124cff00ffffYogi\124r - For testing, feedback, recommendations, and support\n    \124cff00ffffKrøgue\124r - For testing, feedback, and recommendations\n    \124cff00ffffMorphen\124r - For testing, feedback, and recommendations\n    \124cff00ffffKhileez\124r - For their work on the addon that inspired this addon\n    \124cff00ffffProchilles\124r - For their work on the addon that inspired this addon\n\n\nMost of all, I want to thank you, the user for the excitment I get from seeing that you have downloaded and are using Level Speed - Anniversary. It truly does mean so much to me.",
                order = 4,
                fontSize = "medium",
            },
            donateLink = {
                type = "input",
                name = "Support Development at Buy Me A Coffee",
                desc = "Please consider supporting the development of this addon by using this link!",
                order = 5,
                width = "full",
                get = function() return "https://www.buymeacoffee.com/hellknightj" end,
                set = function() end,
            },
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