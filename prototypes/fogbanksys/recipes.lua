local constants = require("constants")

if settings.startup[constants.setting_fogbanksys].value then
    if (data.raw.item["FOGBANK"]) then
        data:extend({
            {
                type = "recipe",
                name = "FOGBANK alt",
                category = "chemistry",
                energy_required = 30,
                ingredients = {
                    { "se-aeroframe-scaffold", 4 },
                    { "se-holmium-cable",      20 },
                    { "se-heavy-girder",       12 },
                    { "plastic-bar",           10 },
                    { "processing-unit",       16 },
                    { type = "fluid",          name = "se-pyroflux", amount = 100 }
                },
                result = "FOGBANK",
                crafting_machine_tint =
                {
                    primary = { r = 0.965, g = 0.482, b = 0.338, a = 1.000 }, -- #f67a56ff
                    secondary = { r = 0.831, g = 0.560, b = 0.222, a = 1.000 }, -- #d38e38ff
                    tertiary = { r = 0.728, g = 0.818, b = 0.443, a = 1.000 }, -- #b9d070ff
                    quaternary = { r = 0.939, g = 0.763, b = 0.191, a = 1.000 }, -- #efc230ff
                }
            }
        })
    end
    local recipes = {
        "FOGBANK alt"
    }
    for _, recipe in pairs(recipes) do
        for i, module in pairs(data.raw.module) do
            if module.limitation and module.effect.productivity then
                table.insert(module.limitation, recipe)
            end
        end
    end
end
