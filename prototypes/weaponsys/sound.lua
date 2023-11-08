local constants = require("constants")

if settings.startup[constants.setting_weaponsys].value then
    data:extend({
        {
            type = "sound",
            name = constants.sound_jericho,
            aggregation = { max_count = 5, remove = true },
            variations = {
                {
                    filename = "__SE-ADds__/sound/jericho.ogg",
                    volume = 0.7
                }
            },
            audible_distance_modifier = 5
        }
    })
end