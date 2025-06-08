--// ReplicatedStorage.Shared.Enemies.Marine Island (ModuleScript)

local v1 = {
    ["Kaku"] = {
        ["Name"] = "Kaku",
        ["Difficult"] = "Easy",
        ["Health"] = "550K"
    },
    ["Shiriu"] = {
        ["Name"] = "Shiriu",
        ["Difficult"] = "Medium",
        ["Health"] = "1.5M"
    },
    ["Riokugiu"] = {
        ["Name"] = "Riokugiu",
        ["Difficult"] = "Hard",
        ["Health"] = "5M"
    },
    ["Figarlend"] = {
        ["Name"] = "Figarlend",
        ["Difficult"] = "Impossible",
        ["Health"] = "17.5M"
    },
    ["Buggi"] = {
        ["Name"] = "Buggi",
        ["Difficult"] = "Boss",
        ["Health"] = "50M"
    },
    ["Crocodele"] = {
        ["Name"] = "Crocodele",
        ["Difficult"] = "Raid Boss",
        ["Health"] = "250M",
        ["Drops"] = {
            { "Relic", "SandCloak", 10 },
            { "Item", "PlasmaShard", 50 }
        }
    }
}
return v1