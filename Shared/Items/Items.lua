--// ReplicatedStorage.Shared.Items (ModuleScript)

local v_u_1 = {}
local v2 = next
local v3, v4 = script:GetChildren()
local function v8(p5)
    for v6, v7 in next, p5 do
        if v_u_1[v6] == nil then
            v_u_1[v6] = v7
        else
            warn("[ITEMS] Conflict with: " .. v6)
        end
    end
end
for _, v9 in v2, v3, v4 do
    if v9:IsA("ModuleScript") then
        task.spawn(v8, require(v9))
    end
end
return v_u_1