--// ReplicatedStorage.Shared.Shadow_Stats (ModuleScript)

local v_u_1 = require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Boosts"))
local v_u_2 = require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Game_Stats"))
local v_u_3 = require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Traits"))
local v_u_4 = require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Relics"))
local v_u_5 = require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Talent_Stats"))
local v_u_6 = require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Accessories"))
local v_u_7 = require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Forge_Stats"))
local v_u_8 = {
    ["Damage"] = {
        ["Common"] = 1,
        ["Rare"] = 2,
        ["Epic"] = 3,
        ["Legendary"] = 4.5,
        ["Mythical"] = 8,
        ["Secret"] = 15,
        ["Exclusive"] = 7
    },
    ["Exp"] = {
        ["Common"] = 1,
        ["Rare"] = 1.8,
        ["Epic"] = 2.5,
        ["Legendary"] = 3,
        ["Mythical"] = 5,
        ["Secret"] = 8,
        ["Exclusive"] = 6
    },
    ["Exp_Value"] = {
        ["Common"] = 2,
        ["Rare"] = 2.35,
        ["Epic"] = 2.7,
        ["Legendary"] = 3.05,
        ["Mythical"] = 3.4,
        ["Secret"] = 7.5,
        ["Exclusive"] = 2
    }
}
local v_u_55 = {
    ["calculate_stats"] = function(_, p9, _)
        return 1 * (v_u_8.Damage[p9.Rarity] or 1)
    end,
    ["calculate_stats_with_multiplier"] = function(_, p10, p11, p12, p13, p14)
        local v15 = p11.Damage
        local v16 = 3 ^ (p12.Level / 10)
        local v17 = p12.Trait and (v_u_3[p12.Trait] or {}) or {}
        local v18 = 1 + (v17.Perks and v17.Perks.DMG or 0)
        local v19 = p12.Relic and p10.Relics[p12.Relic] and (v_u_4[p10.Relics[p12.Relic].Name] or {}) or {}
        local v20 = 1 + (v19.Perks and v19.Perks.Damage or 0)
        local v21 = p12.Accessory and p10.Accessories[p12.Accessory] and (v_u_6[p10.Accessories[p12.Accessory].Name] or {}) or {}
        local v22 = 1 + (v21.Perks and (v21.Perks.Damage or 0) or 0)
        if v21 and (v21.Perks and v21.Perks.Damage) then
            v22 = v22 + v21.Perks.Damage * v_u_7[p10.Accessories[p12.Accessory].Rank or "E"]
        end
        local v23 = 1 + v_u_5.DamageHit[p12.DamageHit or "E"]
        local v24 = p12.Ascension or 0
        local v25 = v24 >= 3 and 1.3 or (v24 >= 2 and 1.15 or (v24 >= 1 and 1.05 or 1))
        local v26 = v15 * v16 * v18 * v20 * v22 * v25 * v23 * (p12.Shiny and 1.75 or 1) * p13 * p14
        local v27 = math.log10(v26)
        local v28 = math.floor(v27) - 1
        local v29 = math.max(v28, 0)
        local v30 = v26 / 10 ^ v29 + 0.3
        return math.floor(v30) * 10 ^ v29
    end,
    ["get_damage"] = function(_, p31, p32, p33)
        local v34 = v_u_1:Damage(p31) or 1
        local v35 = math.max(v34, 1)
        return not (p32 and p32.Rarity) and 0 or v_u_55:calculate_stats_with_multiplier(p31, p32, p33, v_u_55:calculate_stats(p32, p33), v35)
    end,
    ["exp_for_next_level"] = function(_, p36, p37)
        local v38 = p37.Shiny and 2 or 1
        local v39 = 50 * (v_u_8.Exp[p36.Rarity] or 1) * v38 * 1 * 13 ^ (p37.Level / 10) * 3
        return math.floor(v39)
    end,
    ["exp_from_fuse"] = function(_, p40, p41, p42)
        local v43 = v_u_8.Exp[p41.Rarity] * v_u_8.Exp_Value[p41.Rarity]
        local v44 = 10 ^ (p42.Level / 10 + 1) / 2.302585092994046
        local v45 = p42.Shiny and 5 or 1
        local v46 = v_u_1:Exp(p40) or 1
        local v47 = math.max(v46, 1)
        local v48 = 50 * v43 * v44 * v45 * v47 * 0.07
        return math.floor(v48)
    end,
    ["level_expect"] = function(_, p49, p50, p51)
        local v52 = p50.Level
        local v53 = p51 + p50.Exp
        local v54 = v_u_55:exp_for_next_level(p49, p50)
        if v54 <= v53 then
            repeat
                v53 = v53 - v54
                v52 = v52 + 1
                v54 = v_u_55:exp_for_next_level(p49, {
                    ["Shiny"] = p50.Shiny,
                    ["Level"] = v52
                })
            until v53 < v54 or v_u_2.MaxLevel <= v52
        end
        return v52
    end
}
return v_u_55