local constants = require("constants")

if settings.startup[constants.setting_weaponsys].value then
    ---@type data.RecipePrototype[]
    data:extend({
        ----WEAPONS
        {
            type = "recipe",
            name = constants.weapon_maraudermissle,
            icon = "__SE-ADds__/graphics/missles.png",
            icon_size = 64,
            energy_required = 10,
            ingredients = {
                { "rocket-control-unit",               2 },
                { "explosives",                        50 },
                { "steel-plate",                       20 },
                { "se-delivery-cannon-weapon-capsule", 1 }
            },
            result = constants.weapon_maraudermissle,
            result_count = 40,
            order = "b[bi]",
        },
        {
            type = "recipe",
            name = "se-delivery-cannon-weapon-pack-" .. constants.weapon_maraudermissleWH,
            icon = "__SE-ADds__/graphics/missles.png",
            icon_size = 64,
            results = {
                {
                    type = "item",
                    name = "se-delivery-cannon-weapon-package-" .. constants.weapon_maraudermissleWH,
                    amount = 1
                } },
            energy_required = 1,
            ingredients = {
                { name = constants.weapon_maraudermissle, amount = 1 }
            },
            requester_paste_multiplier = 1,
            category = "delivery-cannon-weapon",
            hide_from_player_crafting = true,
            allow_decomposition = false
        },
        {
            type = "recipe",
            name = constants.weapon_jerichomissle,
            icon = "__SE-ADds__/graphics/missles.png",
            icon_size = 64,
            energy_required = 20,
            ingredients = {
                { "rocket-control-unit",           1 },
                { "explosives",                    2 },
                { "se-aeroframe-scaffold",         4 },
                { constants.weapon_maraudermissle, 200 }
            },
            result = constants.weapon_jerichomissle,
            result_count = 1,
            order = "b[bi]",
        },
        {
            type = "recipe",
            name = "se-delivery-cannon-weapon-pack-" .. constants.weapon_jerichoWH,
            icon = "__SE-ADds__/graphics/missles.png",
            icon_size = 64,
            results = {
                {
                    type = "item",
                    name = "se-delivery-cannon-weapon-package-" .. constants.weapon_jerichoWH,
                    amount = 1
                } },
            energy_required = 20,
            ingredients = {
                { name = constants.weapon_jerichomissle, amount = 1 }
            },
            requester_paste_multiplier = 1,
            category = "delivery-cannon-weapon",
            hide_from_player_crafting = true,
            allow_decomposition = false
        }
    } --[[@as data.RecipePrototype[] ]])

    if settings.startup[constants.setting_treesys].value then
        data:extend({
            {
                type = "recipe",
                name = constants.weapon_maraudertreemissle,
                icon = "__SE-ADds__/graphics/treemissles.png",
                icon_size = 64,
                energy_required = 5,
                ingredients = {
                    { constants.weapon_maraudermissle, 20 },
                    { constants.item_tree,             256 }
                },
                result = constants.weapon_maraudertreemissle,
                result_count = 20,
                order = "b[bi]",
                allow_as_intermediate = false,
            },
            {
                type = "recipe",
                name = "se-delivery-cannon-weapon-pack-" .. constants.weapon_maraudertreemissleWH,
                icon = "__SE-ADds__/graphics/treemissles.png",
                icon_size = 64,
                results = {
                    {
                        type = "item",
                        name = "se-delivery-cannon-weapon-package-" .. constants.weapon_maraudertreemissleWH,
                        amount = 1
                    } },
                energy_required = 1,
                ingredients = {
                    { name = constants.weapon_maraudertreemissle, amount = 1 }
                },
                requester_paste_multiplier = 1,
                category = "delivery-cannon-weapon",
                hide_from_player_crafting = true,
                allow_decomposition = false
            },
        } --[[@as data.RecipePrototype[] ]])
    end
end
