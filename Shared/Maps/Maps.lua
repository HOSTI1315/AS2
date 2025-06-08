--// ReplicatedStorage.Shared.Maps (ModuleScript)

local v1 = next
local v2, v3 = script:GetChildren()
local v4 = {}
for _, v5 in v1, v2, v3 do
    if v5:IsA("ModuleScript") then
        v4[v5.Name] = require(v5)
    end
end
return v4