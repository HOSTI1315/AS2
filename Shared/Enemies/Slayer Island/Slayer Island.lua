--// ReplicatedStorage.Shared.Enemies.Slayer Island (ModuleScript)

local v1 = {
    ["Enmo"] = {
        ["Name"] = "Enmo",
        ["Difficult"] = "Easy",
        ["Health"] = "17.5K"
    },
    ["Ruih"] = {
        ["Name"] = "Ruih",
        ["Difficult"] = "Medium",
        ["Health"] = "45K"
    },
    ["Hantego"] = {
        ["Name"] = "Hantego",
        ["Difficult"] = "Hard",
        ["Health"] = "115K"
    },
    ["Dhoma"] = {
        ["Name"] = "Dhoma",
        ["Difficult"] = "Impossible",
        ["Health"] = "300K"
    },
    ["Kokoshibo"] = {
        ["Name"] = "Kokoshibo",
        ["Difficult"] = "Boss",
        ["Health"] = "850K"
    },
    ["Susamaro"] = {
        ["Name"] = "Susamaro",
        ["Difficult"] = "Raid Boss",
        ["Health"] = "2.5M",
        ["Drops"] = {
            { "Relic", "SlayerBox", 70 },
            { "Item", "TalentCapsule", 50 }
        }
    },
    ["Dake"] = {
        ["Name"] = "Dake",
        ["Difficult"] = "Raid Boss",
        ["Health"] = "12.5M",
        ["Drops"] = {
            { "Relic", "DrumOni", 50 },
            { "Item", "TalentCapsule", 50 }
        }
    },
    ["Gyutaru"] = {
        ["Name"] = "Gyutaru",
        ["Difficult"] = "Raid Boss",
        ["Health"] = "35M",
        ["Drops"] = {
            { "Relic", "PinkBands", 50 },
            { "Item", "TalentCapsule", 50 }
        }
    },
    ["Akazha"] = {
        ["Name"] = "Akazha",
        ["Difficult"] = "Raid Boss",
        ["Health"] = "100M",
        ["Drops"] = {
            { "Relic", "MuzansClaw", 50 },
            { "Item", "TalentCapsule", 50 }
        }
    }
}
return v1