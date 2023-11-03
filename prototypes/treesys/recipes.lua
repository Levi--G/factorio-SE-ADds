local constants = require("constants")
local utils = require("utils")

if settings.startup[constants.setting_treesys].value then
    ---@type data.RecipePrototype[]
    data:extend({
        ----TREES/RESOURCES
        {
            type = "recipe",
            name = constants.fluid_hydrogen,
            category = "chemistry",
            ingredients = {
                { type = "fluid", name = "petroleum-gas", amount = 100 }
            },
            results =
            {
                { type = "fluid", name = constants.fluid_hydrogen, amount = 100 }
            },
            icon = "__SE-ADds__/graphics/hydrogen.png",
            icon_size = 64,
            icon_mipmaps = 4,
            subgroup = "fluid-recipes",
            energy_required = 1
        },
        {
            type = "recipe",
            name = constants.fluid_ammonia,
            category = "chemistry",
            ingredients = {
                { type = "fluid", name = constants.fluid_hydrogen, amount = 200 }
            },
            results =
            {
                { type = "fluid", name = constants.fluid_ammonia, amount = 20 }
            },
            icon = "__SE-ADds__/graphics/ammonia.png",
            icon_size = 64,
            icon_mipmaps = 4,
            subgroup = "fluid-recipes",
            energy_required = 1
        },
        {
            type = "recipe",
            name = constants.fluid_phosphates,
            category = "chemistry",
            ingredients = {
                { name = "stone", amount = 1 },
                { type = "fluid", name = "sulfuric-acid", amount = 19 }
            },
            results =
            {
                { type = "fluid", name = constants.fluid_phosphates, amount = 20 }
            },
            icon = "__SE-ADds__/graphics/phospentox.png",
            icon_size = 64,
            icon_mipmaps = 4,
            subgroup = "fluid-recipes",
            energy_required = 1
        },
        {
            type = "recipe",
            name = constants.item_potash,
            category = "chemistry",
            ingredients = {
                { name = "stone", amount = 1 }
            },
            results =
            {
                { name = constants.item_potash, amount = 20 }
            },
            icon = "__SE-ADds__/graphics/potash.png",
            icon_size = 64,
            subgroup = "raw-material",
            energy_required = 1
        },
        {
            type = "recipe",
            name = constants.recipe_wood_to_coal,
            icon = "__base__/graphics/icons/coal.png",
            icon_size = 64,
            icon_mipmaps = 4,
            subgroup = "raw-material",
            order = "a[bi]-a-d[bi-6-charcoal-2]",
            category = constants.category_cokery,
            energy_required = 20,
            ingredients = { { "wood", 20 } },
            result = "coal",
            result_count = 20,
            -- always_show_made_in = true,
            allow_decomposition = false,
            allow_as_intermediate = false,
        },
        {
            type = "recipe",
            name = constants.item_fertilizer,
            category = "chemistry",
            ingredients = {
                { type = "fluid",               name = constants.fluid_ammonia,    amount = 20 },
                { type = "fluid",               name = constants.fluid_phosphates, amount = 20 },
                { name = constants.item_potash, amount = 20 },
                { name = "coal",                amount = 5 },
                { name = "iron-ore",            amount = 1 },
                { name = "copper-ore",          amount = 1 }
            },
            results =
            {
                { name = constants.item_fertilizer, amount = 20 }
            },
            icon = "__SE-ADds__/graphics/fertilizer.png",
            icon_size = 64,
            subgroup = "raw-material",
            energy_required = 4.6
        },
        {
            type = "recipe",
            name = constants.item_tree,
            category = constants.category_farm,
            ingredients = {
                { name = constants.item_fertilizer, amount = 1 },
                { name = "wood",                    amount = 2 },
                { type = "fluid",                   name = "water", amount = 20 },
            },
            results =
            {
                { name = constants.item_tree, amount = 1 }
            },
            icon = "__SE-ADds__/graphics/tree-icon.png",
            icon_size = 64,
            subgroup = "raw-material",
            energy_required = 1.1
        },
        {
            type = "recipe",
            name = constants.recipe_tree_to_wood,
            category = constants.category_farm,
            ingredients = {
                { name = constants.item_tree, amount = 1 },
            },
            results =
            {
                { name = "wood", amount = 4 }
            },
            icon = "__base__/graphics/icons/wood.png",
            icon_size = 64,
            icon_mipmaps = 4,
            subgroup = "raw-material",
            energy_required = 0.4,
            allow_decomposition = false,
            allow_as_intermediate = false
        },
        ----ENTITY
        {
            type = "recipe",
            name = constants.assembler_farm,
            icon = "__SE-ADds__/graphics/Bio_Industries/Bio_Farm_Icon.png",
            icon_size = 64,
            energy_required = 5,
            ingredients = {
                { "iron-stick",   10 },
                { "stone-brick",  20 },
                { "small-lamp",   10 },
                { "copper-cable", 10 },
            },
            result = constants.assembler_farm,
            result_count = 1,
            subgroup = "production-machine",
            order = "b[bi]",
            allow_as_intermediate = false,
        },
        {
            type = "recipe",
            name = constants.assembler_cokery,
            icon = "__SE-ADds__/graphics/Bio_Industries/cokery.png",
            icon_size = 64,
            energy_required = 5,
            ingredients = {
                { "stone-furnace", 3 },
                { "steel-plate",   10 },
            },
            result = constants.assembler_cokery,
            result_count = 1,
            subgroup = "production-machine",
            order = "a[bi]",
            allow_as_intermediate = false,
        },
        ----WEAPONS
        {
            type = "recipe",
            name = constants.item_tree_capsule,
            ingredients = {
                { constants.item_tree, 256 },
                { "coal",              5 },
                { "steel-plate",       1 }
            },
            result = constants.item_tree_capsule,
            icon = "__SE-ADds__/graphics/treecap-icon.png",
            icon_size = 64,
            subgroup = "raw-material",
            energy_required = 1
        },
        {
            type = "recipe",
            name = constants.item_tree_capsule_advanced,
            ingredients = {
                { constants.item_tree, 1024 },
                { "coal",              20 },
                { "steel-plate",       4 }
            },
            result = constants.item_tree_capsule_advanced,
            icon = "__SE-ADds__/graphics/treecap-icon.png",
            icon_size = 64,
            subgroup = "raw-material",
            energy_required = 1
        },
        {
            type = "recipe",
            name = constants.weapon_treenuke,
            icon = "__SE-ADds__/graphics/treenuke.png",
            icon_size = 64,
            energy_required = 5,
            ingredients = {
                { "rocket-control-unit",               1 },
                { "steel-plate",                       10 },
                { "se-delivery-cannon-weapon-capsule", 1 },
                { constants.item_tree,                 8192 }
            },
            result = constants.weapon_treenuke,
            order = "b[bi]",
            allow_as_intermediate = false
        },
        {
            type = "recipe",
            name = "se-delivery-cannon-weapon-pack-" .. constants.weapon_treenukeWH,
            icon = "__SE-ADds__/graphics/treenuke.png",
            icon_size = 64,
            results = {
                {
                    type = "item",
                    name = "se-delivery-cannon-weapon-package-" .. constants.weapon_treenukeWH,
                    amount = 1
                } },
            energy_required = 1,
            ingredients = {
                { name = constants.weapon_treenuke, amount = 1 }
            },
            requester_paste_multiplier = 1,
            category = "delivery-cannon-weapon",
            hide_from_player_crafting = true,
            allow_decomposition = false
        }
    } --[[@as data.RecipePrototype[] ]])

    local items = {}
    local results = {}

    local treeamount = utils.tablelength(data.raw.tree)
    for tree_name, tree in pairs(data.raw.tree) do
        if (not tree_name:find("dry") and not tree_name:find("dead") and not tree_name:find("waterGhost")) then
            table.insert(items, {
                type = "item",
                name = tree_name,
                icon = tree.icon,
                icons = tree.icons,
                icon_size = tree.icon_size,
                subgroup = "raw-material",
                order = "zzz[" .. tree_name .. "]",
                place_result = tree_name,
                stack_size = 50,
                fuel_value = "8MJ",
                fuel_category = "chemical"
            } --[[@as data.ItemPrototype]])
            table.insert(results, {
                name = tree_name,
                amount = 1
            })
        end
    end
    data:extend(items)
    data:extend({
        {
            type = "recipe",
            name = constants.recipe_decorative_trees,
            category = "crafting-with-fluid",
            ingredients = {
                { "wood",         4 * treeamount },
                { type = "fluid", name = "water", amount = 100 * treeamount }
            },
            results = results,
            icon = "__SE-ADds__/graphics/tree-sapling-icon.png",
            icon_size = 32,
            subgroup = "raw-material",
            energy_required = treeamount * 5
        } --[[@as data.RecipePrototype]]
    })


    local recipes = {
        constants.fluid_hydrogen,
        constants.fluid_ammonia,
        constants.fluid_phosphates,
        constants.item_potash,
        constants.item_fertilizer,
        constants.recipe_decorative_trees
    }
    for _, recipe in pairs(recipes) do
        for i, module in pairs(data.raw.module) do
            if module.limitation and module.effect.productivity then
                table.insert(module.limitation, recipe)
            end
        end
    end
end
