local constants = require("constants")

if settings.startup[constants.setting_soundsys].value then
    data:extend({
        ---@diagnostic disable-next-line: missing-fields, assign-type-mismatch
        {
            type = "sound",
            name = constants.sound_rip,
            aggregation = { max_count = 1, remove = true },
            variations = {
                {
                    filename = "__SE-ADds__/sound/rip1.ogg",
                    volume = 1
                },
                {
                    filename = "__SE-ADds__/sound/rip2.ogg",
                    volume = 1
                },
                {
                    filename = "__SE-ADds__/sound/rip3.ogg",
                    volume = 1
                }
            },
            audible_distance_modifier = 1e20
        } --[[@as data.SoundPrototype]]
    })
end
