versionNumber = "0.3.1"

SLASH_LevelSpeed_ResetFrame1 = "/lsreset"

function LevelSpeed_ResetFrame()
	getStuff()
end

SlashCmdList["LevelSpeed_ResetFrame"] = LevelSpeed_ResetFrame

SLASH_LevelSpeed_Hide1 = "/lshide"

function LevelSpeed_Hide()
    mainFrame:Hide()
end

SlashCmdList["LevelSpeed_Hide"] = LevelSpeed_Hide

SLASH_LevelSpeed_Show1 = "/lsshow"

function LevelSpeed_Show()
    mainFrame:Show()
end

SlashCmdList["LevelSpeed_Show"] = LevelSpeed_Show

SLASH_LevelSpeed_Version1 = "/lsversion"

function LevelSpeed_Version()
    print("\124cffff0000Level Speed Version: "..versionNumber.."\124r")
end

SlashCmdList["LevelSpeed_Version"] = LevelSpeed_Version

SLASH_LevelSpeed_Help1 = "/lshelp"

function LevelSpeed_Help()
    print("Level Speed Commands:")
    print("\124cff00ffff/lsreset\124cffffd500 - Resets addon calculations.\124r")
    print("\124cff00ffff/lshide\124cffffd500 - Hides addon frame.\124r")
    print("\124cff00ffff/lsshow\124cffffd500 - Shows addon frame.\124r")
    print("\124cff00ffff/lsversion\124cffffd500 - Prints addon version.\124r")
end

SlashCmdList["LevelSpeed_Help"] = LevelSpeed_Help