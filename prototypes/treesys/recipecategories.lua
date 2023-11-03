local constants = require("constants")

if settings.startup[constants.setting_treesys].value then
    data:extend({
        {
            type = "recipe-category",
            name = constants.category_farm
        },
        {
            type = "recipe-category",
            name = constants.category_cokery
        }
    })
end
