--// ReplicatedStorage.Shared.Traits_Reroll (ModuleScript)

local v1 = require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Traits"))
local v2 = {}
for v3, v4 in next, v1 do
    local v5 = { v4.Rarity, v3 }
    table.insert(v2, v5)
end
return v2