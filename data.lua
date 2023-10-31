local constants = require("constants")
local utils = require("utils")

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

data:extend({
    {
        type = "sound",
        name = constants.sound_jericho,
        aggregation = { max_count = 5, remove = true },
        variations = {
            {
                filename = constants.sound_jericho_path,
                volume = 0.7
            },
        }
    },
})

require("prototypes/items")
require("prototypes/fluids")
require("prototypes/recipecategories")
require("prototypes/recipes")
require("prototypes/entities")
