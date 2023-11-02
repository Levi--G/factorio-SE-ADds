local constants = require("constants")

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
        }
    }
})