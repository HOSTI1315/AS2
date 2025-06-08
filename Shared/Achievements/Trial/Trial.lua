--// ReplicatedStorage.Shared.Achievements.Trial (ModuleScript)

local v1 = {}
local v2 = {
    ["Name"] = "Trial I",
    ["Icon"] = "rbxassetid://131791020458769",
    ["Difficult"] = "Easy",
    ["Desc"] = "Deal more damage to your enemies",
    ["Perks"] = {
        ["Damage"] = 0.05
    },
    ["Mission"] = {
        ["Type"] = "Trial",
        ["Amount"] = 5,
        ["Desc"] = "Reach room 5 of Trial"
    }
}
v1["Trial I"] = v2
local v3 = {
    ["Name"] = "Trial II",
    ["Icon"] = "rbxassetid://131791020458769",
    ["Difficult"] = "Medium",
    ["Desc"] = "Spin more stars at once",
    ["Perks"] = {
        ["Extra Open"] = 1
    },
    ["Mission"] = {
        ["Type"] = "Trial",
        ["Amount"] = 10,
        ["Desc"] = "Reach room 10 of Trial"
    }
}
v1["Trial II"] = v3
local v4 = {
    ["Name"] = "Trial III",
    ["Icon"] = "rbxassetid://131791020458769",
    ["Difficult"] = "Medium",
    ["Desc"] = "Obtain more coins from your defeated enemies",
    ["Perks"] = {
        ["Coins"] = 0.05
    },
    ["Mission"] = {
        ["Type"] = "Trial",
        ["Amount"] = 15,
        ["Desc"] = "Reach room 15 of Trial"
    }
}
v1["Trial III"] = v4
local v5 = {
    ["Name"] = "Trial IV",
    ["Icon"] = "rbxassetid://131791020458769",
    ["Difficult"] = "Hard",
    ["Desc"] = "Spin more stars at once",
    ["Perks"] = {
        ["Extra Open"] = 1
    },
    ["Mission"] = {
        ["Type"] = "Trial",
        ["Amount"] = 20,
        ["Desc"] = "Reach room 20 of Trial"
    }
}
v1["Trial IV"] = v5
local v6 = {
    ["Name"] = "Trial V",
    ["Icon"] = "rbxassetid://131791020458769",
    ["Difficult"] = "Hard",
    ["Desc"] = "Obtain more coins from your defeated enemies",
    ["Perks"] = {
        ["Coins"] = 0.05
    },
    ["Mission"] = {
        ["Type"] = "Trial",
        ["Amount"] = 30,
        ["Desc"] = "Reach room 30 of Trial"
    }
}
v1["Trial V"] = v6
local v7 = {
    ["Name"] = "Trial VI",
    ["Icon"] = "rbxassetid://131791020458769",
    ["Difficult"] = "Hard",
    ["Desc"] = "Deal more damage to your enemies",
    ["Perks"] = {
        ["Damage"] = 0.05
    },
    ["Mission"] = {
        ["Type"] = "Trial",
        ["Amount"] = 40,
        ["Desc"] = "Reach room 40 of Trial"
    }
}
v1["Trial VI"] = v7
local v8 = {
    ["Name"] = "Trial VII",
    ["Icon"] = "rbxassetid://131791020458769",
    ["Difficult"] = "Impossible",
    ["Desc"] = "Equip more shadows to cause more damage",
    ["Perks"] = {
        ["Extra Equip"] = 1
    },
    ["Mission"] = {
        ["Type"] = "Trial",
        ["Amount"] = 50,
        ["Desc"] = "Reach room 50 of Trial"
    }
}
v1["Trial VII"] = v8
return v1