local constants = require("constants")

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
    --[[

    function data_util.sub_icons(icon_main, ...)
  local icons_sub = {...}
  local results = {{ icon = icon_main, shift = {2, 0}, icon_size = 64 }}
  for _, icon in pairs(icons_sub) do
    table.insert(results, { icon = icon.icon or icon,
                            scale = icon.scale or 0.25,
                            shift = icon.shift or {-7, -7},
                            icon_size = icon.icon_size or 64
                          })
  end
  return results
end
{{ icon = data.raw.item["se-iron-ingot"].icon, shift = {2, 0}, icon_size = 64 },{ icon = data.raw.item["iron-plate"].icon,
                            scale = 0.25,
                            shift = {-7, -7},
                            icon_size = 64,
        icon_mipmaps = 4
                          }}
    ]] --
    ----SE CHANGES
    {
        type = "recipe",
        category = "casting",
        name = "se-iron-ingot-from-plates",
        results = {
            { name = "se-iron-ingot", amount = 1 },
        },
        energy_required = 2,
        ingredients = {
            { name = "iron-plate", amount = 10 },
        },
        icons = {
            {
                icon = data.raw.item["se-iron-ingot"].icon,
                shift = { 2, 0 },
                icon_size = 64
            },
            {
                icon = data.raw.item["iron-plate"].icon,
                scale = 0.25,
                shift = { -7, -7 },
                icon_size = 64,
                icon_mipmaps = 4
            }
        },
        always_show_made_in = true,
        allow_as_intermediate = false,
        allow_decomposition = false,
        order = "a-b-c"
    },
    {
        type = "recipe",
        category = "casting",
        name = "se-copper-ingot-from-plates",
        results = {
            { name = "se-copper-ingot", amount = 1 },
        },
        energy_required = 2,
        ingredients = {
            { name = "copper-plate", amount = 10 },
        },
        icons = {
            {
                icon = data.raw.item["se-copper-ingot"].icon,
                shift = { 2, 0 },
                icon_size = 64
            },
            {
                icon = data.raw.item["copper-plate"].icon,
                scale = 0.25,
                shift = { -7, -7 },
                icon_size = 64,
                icon_mipmaps = 4
            }
        },
        always_show_made_in = true,
        allow_as_intermediate = false,
        allow_decomposition = false,
        order = "a-c"
    },
    {
        type = "recipe",
        category = "casting",
        name = "se-steel-ingot-from-plates",
        results = {
            { name = "se-steel-ingot", amount = 1 },
        },
        energy_required = 2,
        ingredients = {
            { name = "steel-plate", amount = 10 },
        },
        icons = {
            {
                icon = data.raw.item["se-steel-ingot"].icon,
                shift = { 2, 0 },
                icon_size = 64
            },
            {
                icon = data.raw.item["steel-plate"].icon,
                scale = 0.25,
                shift = { -7, -7 },
                icon_size = 64,
                icon_mipmaps = 4
            }
        },
        always_show_made_in = true,
        allow_as_intermediate = false,
        allow_decomposition = false,
        order = "b-c"
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
        name = constants.weapon_maraudermissle,
        icon = "__SE-ADds__/graphics/missles.png",
        icon_size = 64,
        energy_required = 5,
        ingredients = {
            { "rocket-control-unit",               1 },
            { "explosives",                        40 },
            { "steel-plate",                       10 },
            { "se-delivery-cannon-weapon-capsule", 1 }
        },
        result = constants.weapon_maraudermissle,
        result_count = 20,
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
        allow_as_intermediate = false,
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

local recipes = {
    constants.fluid_hydrogen,
    constants.fluid_ammonia,
    constants.fluid_phosphates,
    constants.item_potash,
    constants.item_fertilizer
}
for _, recipe in pairs(recipes) do
    for i, module in pairs(data.raw.module) do
        if module.limitation and module.effect.productivity then
            table.insert(module.limitation, recipe)
        end
    end
end
