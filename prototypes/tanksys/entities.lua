local constants = require("constants")

if settings.startup[constants.setting_tanksys].value then
    local st = data.raw["storage-tank"]["storage-tank"]
    st.fast_replaceable_group = st.fast_replaceable_group or "storage-tank"
    st.next_upgrade = "storage-tank-mk2"

    local mk2 = table.deepcopy(st)
    mk2.name = "storage-tank-mk2"
    mk2.fluid_box.base_area = st.fluid_box.base_area * 3
    mk2.icon = "__SE-ADds__/graphics/storage-tank-mk2-icon.png"
    mk2.icon_mipmaps = nil
    mk2.pictures.picture.sheets[1] = {
        filename = "__SE-ADds__/graphics/storage-tank-mk2.png",
        priority = "extra-high",
        frames = 2,
        width = 219,
        height = 215,
        shift = util.by_pixel(-0.25, 3.75),
        scale = 0.5
    }
    mk2.minable = {mining_time = 0.6, result = "storage-tank-mk2"}
    mk2.next_upgrade = "storage-tank-mk3"

    local mk3 = table.deepcopy(st)
    mk3.name = "storage-tank-mk3"
    mk3.fluid_box.base_area = st.fluid_box.base_area * 6
    mk3.icon = "__SE-ADds__/graphics/storage-tank-mk3-icon.png"
    mk3.icon_mipmaps = nil
    mk3.pictures.picture.sheets[1] = {
        filename = "__SE-ADds__/graphics/storage-tank-mk3.png",
        priority = "extra-high",
        frames = 2,
        width = 219,
        height = 215,
        shift = util.by_pixel(-0.25, 3.75),
        scale = 0.5
    }
    mk3.minable = {mining_time = 0.8, result = "storage-tank-mk3"}
    mk3.next_upgrade = "storage-tank-mk4"

    local mk4 = table.deepcopy(st)
    mk4.name = "storage-tank-mk4"
    mk4.fluid_box.base_area = st.fluid_box.base_area * 10
    mk4.icon = "__SE-ADds__/graphics/storage-tank-mk4-icon.png"
    mk4.icon_mipmaps = nil
    mk4.pictures.picture.sheets[1] = {
        filename = "__SE-ADds__/graphics/storage-tank-mk4.png",
        priority = "extra-high",
        frames = 2,
        width = 219,
        height = 215,
        shift = util.by_pixel(-0.25, 3.75),
        scale = 0.5
    }
    mk4.minable = {mining_time = 0.8, result = "storage-tank-mk4"}
    mk4.next_upgrade = nil

    data:extend({mk2,mk3, mk4})
end
