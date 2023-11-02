local constants = require("constants")

---@type data.RecipePrototype[]
data:extend({
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
} --[[@as data.RecipePrototype[] ]])