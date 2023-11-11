local constants = require("constants")

if settings.startup[constants.setting_tanksys].value then
    data:extend({
        {
            type = "technology",
            name = "fluid-handling-2",
            icon_size = 256,
            icon = "__base__/graphics/technology/fluid-handling.png",
            prerequisites = { "fluid-handling" },
            effects =
            {
                {
                    type = "unlock-recipe",
                    recipe = "storage-tank-mk2"
                }
            },
            unit =
            {
                count = 200,
                ingredients = {
                    { "automation-science-pack", 1 },
                    { "logistic-science-pack",   1 },
                    { "chemical-science-pack",   1 }
                },
                time = 15
            },
            order = "d-a-b"
        },
        {
            type = "technology",
            name = "fluid-handling-3",
            icon_size = 256,
            icon = "__base__/graphics/technology/fluid-handling.png",
            prerequisites = { "fluid-handling-2" },
            effects =
            {
                {
                    type = "unlock-recipe",
                    recipe = "storage-tank-mk3"
                }
            },
            unit =
            {
                count = 300,
                ingredients = {
                    { "automation-science-pack", 1 },
                    { "logistic-science-pack",   1 },
                    { "chemical-science-pack",   1 },
                    { "production-science-pack", 1 }
                },
                time = 15
            },
            order = "d-a-c"
        },
        {
            type = "technology",
            name = "fluid-handling-4",
            icon_size = 256,
            icon = "__base__/graphics/technology/fluid-handling.png",
            prerequisites = { "fluid-handling-3" },
            effects =
            {
                {
                    type = "unlock-recipe",
                    recipe = "storage-tank-mk4"
                }
            },
            unit =
            {
                count = 400,
                ingredients = {
                    { "automation-science-pack", 1 },
                    { "logistic-science-pack",   1 },
                    { "chemical-science-pack",   1 },
                    { "utility-science-pack",    1 }
                },
                time = 15
            },
            order = "d-a-d"
        }
    })
end
