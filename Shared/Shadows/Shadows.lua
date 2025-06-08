--// ReplicatedStorage.Shared.Shadows (ModuleScript)

local v_u_1 = require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Maps"))
local v_u_2 = {}
local v3 = next
local v4, v5 = script:GetChildren()
local function v14(p6, p7)
    local v8 = v_u_1[p6]
    for v9, v10 in next, p7 do
        if v_u_2[v9] == nil then
            v_u_2[v9] = v10
            v_u_2[v9].World = p6
            local v11 = v8.Damage_Multiplier or 1
            local v12 = 1.05 ^ math.log(v11, 3)
            local v13 = v_u_2[v9]
            v13.Damage = v13.Damage * v12
        else
            warn("[SHADOWS] Conflict with: " .. v9)
        end
    end
end
for _, v15 in v3, v4, v5 do
    if v15:IsA("ModuleScript") then
        task.spawn(v14, v15.Name, require(v15))
    end
end
return v_u_2