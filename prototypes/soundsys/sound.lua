local constants = require("constants")

data:extend({
    {
        type = "sound",
        name = constants.sound_rip1,
        aggregation = { max_count = 5, remove = true },
        variations = {
            {
                filename = "__SE-ADds__/sound/rip1.ogg",
                volume = 0.7
            }
        }
    },
    {
        type = "sound",
        name = constants.sound_rip2,
        aggregation = { max_count = 5, remove = true },
        variations = {
            {
                filename = "__SE-ADds__/sound/rip2.ogg",
                volume = 0.7
            }
        }
    },
    {
        type = "sound",
        name = constants.sound_rip2,
        aggregation = { max_count = 5, remove = true },
        variations = {
            {
                filename = "__SE-ADds__/sound/rip3.ogg",
                volume = 0.7
            }
        }
    },
    {
        type = "sound",
        name = constants.sound_rip,
        aggregation = { max_count = 1, remove = true },
        variations = {
            {
                filename = "__SE-ADds__/sound/rip1.ogg",
                volume = 0.7
            },
            {
                filename = "__SE-ADds__/sound/rip2.ogg",
                volume = 0.7
            },
            {
                filename = "__SE-ADds__/sound/rip3.ogg",
                volume = 0.7
            }
        }
    }
})
