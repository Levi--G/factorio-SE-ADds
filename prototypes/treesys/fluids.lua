local constants = require("constants")

if settings.startup[constants.setting_treesys].value then
    data:extend({
        {
            type = "fluid",
            name = constants.fluid_hydrogen,
            default_temperature = 25,
            heat_capacity = "0.1KJ",
            base_color = { r = 0.75, g = 0.28, b = 0.62 },
            flow_color = { r = 0.75, g = 0.28, b = 0.62 },
            icon = "__SE-ADds__/graphics/hydrogen.png",
            icon_size = 64,
            icon_mipmaps = 4,
            order = "a[fluid]-z[hydrogen]"
        },
        {
            type = "fluid",
            name = constants.fluid_ammonia,
            default_temperature = 25,
            heat_capacity = "0.1KJ",
            base_color = { r = 0, g = 0.29, b = 0.74 },
            flow_color = { r = 0, g = 0.29, b = 0.74 },
            icon = "__SE-ADds__/graphics/ammonia.png",
            icon_size = 64,
            icon_mipmaps = 4,
            order = "a[fluid]-z[ammonia]"
        },
        {
            type = "fluid",
            name = constants.fluid_phosphates,
            default_temperature = 25,
            heat_capacity = "0.1KJ",
            base_color = { r = 1, g = 0.28, b = 0 },
            flow_color = { r = 1, g = 0.28, b = 0 },
            icon = "__SE-ADds__/graphics/phospentox.png",
            icon_size = 64,
            icon_mipmaps = 4,
            order = "a[fluid]-z[phospentox]"
        }
    })
end
