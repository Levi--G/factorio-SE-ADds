local constants = require("constants")

data:extend({
    {
        type = "bool-setting",
        name = constants.setting_treesys,
        setting_type = "startup",
        default_value = true
    },
    {
        type = "bool-setting",
        name = constants.setting_weaponsys,
        setting_type = "startup",
        default_value = true
    },
    {
        type = "bool-setting",
        name = constants.setting_ingotsys,
        setting_type = "startup",
        default_value = true
    },
    {
        type = "bool-setting",
        name = constants.setting_fogbanksys,
        setting_type = "startup",
        default_value = true
    },
    {
        type = "bool-setting",
        name = constants.setting_soundsys,
        setting_type = "startup",
        default_value = true
    },
    {
        type = "bool-setting",
        name = constants.setting_tanksys,
        setting_type = "startup",
        default_value = true
    }
})