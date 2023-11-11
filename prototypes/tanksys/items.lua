local constants = require("constants")

---comments
---@param mk integer
---@return data.StorageTankPrototype
local function createTank(mk)
    local subgroup = "storage"
    if (mods["space-exploration"]) then
        subgroup = "pipe"
    end
    return {
        type = "item",
        name = "storage-tank-mk" .. mk,
        icon = "__SE-ADds__/graphics/storage-tank-mk" .. mk .. "-icon.png",
        icon_size = 64,
        subgroup = subgroup,
        order = "b[fluid]-a[storage-tankmk" .. mk .. "]",
        place_result = "storage-tank-mk" .. mk,
        stack_size = 50
    }
end

if settings.startup[constants.setting_tanksys].value then
    data:extend({ createTank(2), createTank(3), createTank(4) })
end
