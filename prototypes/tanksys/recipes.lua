local constants = require("constants")

if settings.startup[constants.setting_tanksys].value then
    data:extend({
        {
            type = "recipe",
            name = "storage-tank-mk2",
            enabled = false,
            energy_required = 6,
            ingredients =
            {
                { "iron-plate",   50 },
                { "pipe",         20 },
                { "storage-tank", 3 }
            },
            result = "storage-tank-mk2"
        },
        {
            type = "recipe",
            name = "storage-tank-mk3",
            enabled = false,
            energy_required = 12,
            ingredients =
            {
                { "iron-plate",       50 },
                { "steel-plate",      100 },
                { "pipe",             20 },
                { "storage-tank-mk2", 2 }
            },
            result = "storage-tank-mk3"
        },
        {
            type = "recipe",
            name = "storage-tank-mk4",
            enabled = false,
            energy_required = 24,
            ingredients =
            {
                { "steel-plate",      100 },
                { "pipe",             20 },
                { "storage-tank-mk3", 2 }
            },
            result = "storage-tank-mk4"
        }
    })
end
