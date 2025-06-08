--// ReplicatedStorage.Shared.Boosts (ModuleScript)

local v_u_1 = require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Achievements"))
local v_u_2 = require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Traits"))
local v_u_3 = require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Relics"))
local v_u_4 = require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Accessories"))
local v_u_5 = require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Forge_Stats"))
return {
    ["Coins"] = function(_, p6)
        local v7 = 1
        if p6.Gamepasses["Extra Coins"] then
            v7 = v7 + 1
        end
        if p6.Potions_Used.CoinsPotion then
            v7 = v7 + 1
        end
        for v8, v9 in next, p6.Achievements do
            if v9 then
                local v10 = v_u_1[v8]
                if v10 then
                    for v11, v12 in next, v10.Perks do
                        if v11 == "Coins" then
                            v7 = v7 + v12
                        end
                    end
                end
            end
        end
        for v13, v14 in next, p6.Shadows do
            if p6.Shadows_Equipped[v13] then
                if v14.Trait and v_u_2[v14.Trait] then
                    local v15 = v_u_2[v14.Trait]
                    if v15.Perks.Coins then
                        v7 = v7 + v15.Perks.Coins
                    end
                end
                if v14.Relic and p6.Relics[v14.Relic] then
                    local v16 = p6.Relics[v14.Relic]
                    if v_u_3[v16.Name] then
                        local v17 = v_u_3[v16.Name]
                        if v17.Perks.Coins then
                            v7 = v7 + v17.Perks.Coins
                        end
                    end
                end
                if v14.Accessory and p6.Accessories[v14.Accessory] then
                    local v18 = p6.Accessories[v14.Accessory]
                    if v_u_4[v18.Name] then
                        local v19 = v_u_4[v18.Name]
                        if v19.Perks.Coins then
                            v7 = v7 + (v19.Perks.Coins + v19.Perks.Coins * v_u_5[v18.Rank or "E"])
                        end
                    end
                end
            end
        end
        return v7
    end,
    ["Damage"] = function(_, p20)
        local v21 = 1
        if p20.Potions_Used.DamagePotion then
            v21 = v21 + 1
        end
        for v22, v23 in next, p20.Achievements do
            if v23 then
                local v24 = v_u_1[v22]
                if v24 then
                    for v25, v26 in next, v24.Perks do
                        if v25 == "Damage" then
                            v21 = v21 + v26
                        end
                    end
                end
            end
        end
        return v21
    end,
    ["Exp"] = function(_, p27)
        local v28 = 1
        if p27.Gamepasses["Extra Exp"] then
            v28 = v28 + 1
        end
        return v28
    end,
    ["Luck"] = function(_, p29)
        local v30 = 0
        if p29.Potions_Used.LuckPotion then
            v30 = v30 + 1
        end
        if p29.Gamepasses.Luck then
            v30 = v30 + 1
        end
        if p29.Gamepasses["Super Luck"] then
            v30 = v30 + 2
        end
        if p29.Gamepasses["Golden Luck"] then
            v30 = v30 + 3
        end
        for v31, v32 in next, p29.Shadows do
            if p29.Shadows_Equipped[v31] then
                if v32.Trait and v_u_2[v32.Trait] then
                    local v33 = v_u_2[v32.Trait]
                    if v33.Perks.Luck then
                        v30 = v30 + v33.Perks.Luck
                    end
                end
                if v32.Relic and p29.Relics[v32.Relic] then
                    local v34 = p29.Relics[v32.Relic]
                    if v_u_3[v34.Name] then
                        local v35 = v_u_3[v34.Name]
                        if v35.Perks.Luck then
                            v30 = v30 + v35.Perks.Luck
                        end
                    end
                end
                if v32.Accessory and p29.Accessories[v32.Accessory] then
                    local v36 = p29.Accessories[v32.Accessory]
                    if v_u_4[v36.Name] then
                        local v37 = v_u_4[v36.Name]
                        if v37.Perks.Luck then
                            v30 = v30 + v37.Perks.Luck
                        end
                    end
                end
            end
        end
        for v38, v39 in next, p29.Achievements do
            if v39 then
                local v40 = v_u_1[v38]
                if v40 then
                    for v41, v42 in next, v40.Perks do
                        if v41 == "Luck" then
                            v30 = v30 + v42
                        end
                    end
                end
            end
        end
        return v30
    end
}