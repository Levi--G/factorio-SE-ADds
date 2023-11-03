local constants = require("constants")

if settings.startup[constants.setting_treesys].value then
    data:extend({
        ----DUMMIES
        {
            type = "simple-entity-with-owner",
            name = constants.native_tree_dummy,
            picture = {
                filename = "__SE-ADds__/graphics/tree-icon.png",
                width = 1,
                height = 1,
            },
            resistances = {
                {
                    type = "physical",
                    percent = 100
                },
                {
                    type = "explosion",
                    percent = 100
                },
                {
                    type = "acid",
                    percent = 100
                },
                {
                    type = "fire",
                    percent = 100
                }
            },
            alert_when_damaged = false
            -- collision_box = { { 0, 0 }, { 0, 0 } }
        } --[[@as data.SimpleEntityWithOwnerPrototype ]],
        ----ASSEMBLERS
        {
            type = "assembling-machine",
            name = constants.assembler_farm,
            icon = "__SE-ADds__/graphics/Bio_Industries/Bio_Farm_Icon.png",
            icon_size = 64,
            flags = { "placeable-neutral", "placeable-player", "player-creation" },
            minable = { hardness = 0.2, mining_time = 0.5, result = constants.assembler_farm },
            max_health = 250,
            corpse = "big-remnants",
            resistances = { { type = "fire", percent = 70 } },
            fluid_boxes = {
                {
                    production_type = "input",
                    pipe_picture = assembler3pipepictures(),
                    pipe_covers = pipecoverspictures(),
                    base_area = 10,
                    base_level = -1,
                    pipe_connections = { { type = "input", position = { -1, -5 } } }
                },
                {
                    production_type = "input",
                    pipe_picture = assembler3pipepictures(),
                    pipe_covers = pipecoverspictures(),
                    base_area = 10,
                    base_level = -1,
                    pipe_connections = { { type = "input", position = { 1, -5 } } }
                },
                off_when_no_fluid_recipe = true
            },

            collision_box = { { -4.2, -4.2 }, { 4.2, 4.2 } },
            selection_box = { { -4.5, -4.5 }, { 4.5, 4.5 } },

            animation = {
                filename = "__SE-ADds__/graphics/Bio_Industries/Bio_Farm_Idle.png",
                priority = "high",
                width = 348,
                height = 288,
                shift = { 0.96, 0 },
                frame_count = 1,
            },

            working_visualisations = {
                animation = {
                    filename = "__SE-ADds__/graphics/Bio_Industries/Bio_Farm_Working.png",
                    priority = "high",
                    width = 348,
                    height = 288,
                    shift = { 0.96, 0 },
                    frame_count = 1,
                },
            },
            crafting_categories = { constants.category_farm },
            crafting_speed = 1,
            energy_source = {
                type = "electric",
                usage_priority = "secondary-input",
                emissions_per_minute = -10, -- the "-" means it Absorbs pollution.
            },
            energy_usage = "250kW",
            ingredient_count = 3,
            open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 },
            close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 },
            module_specification = {
                module_slots = 6
            },
            allowed_effects = { "consumption", "speed", "productivity", "pollution" },
        },
        {
            type = "assembling-machine",
            name = constants.assembler_cokery,
            icon = "__SE-ADds__/graphics/Bio_Industries/cokery.png",
            icon_size = 64,
            flags = { "placeable-neutral", "placeable-player", "player-creation" },
            order = "a[cokery]",
            minable = { hardness = 0.2, mining_time = 0.5, result = constants.assembler_cokery },
            max_health = 200,
            corpse = "medium-remnants",
            resistances = { { type = "fire", percent = 95 } },
            collision_box = { { -1.2, -1.2 }, { 1.2, 1.2 } },
            selection_box = { { -1.5, -1.5 }, { 1.5, 1.5 } },
            module_specification = {
                module_slots = 2
            },
            allowed_effects = { "consumption", "speed", "pollution" },
            animation = {
                filename = "__SE-ADds__/graphics/Bio_Industries/cokery_sheet.png",
                frame_count = 28,
                line_length = 7,
                width = 256,
                height = 256,
                scale = 0.5,
                shift = { 0.5, -0.5 },
                animation_speed = 0.1
            },
            crafting_categories = { constants.category_cokery },
            energy_source = {
                type = "electric",
                input_priority = "secondary",
                usage_priority = "secondary-input",
                emissions_per_minute = 2.5,
            },
            energy_usage = "50kW",
            crafting_speed = 2,
            ingredient_count = 1
        },
        ----PROJECTILES
        {
            type = "projectile",
            name = constants.weapon_treenukeWH,
            acceleration = 2,
            action = {
                type = "area",
                target_entities = false,
                repeat_count = 100000,
                radius = 1500,
                action_delivery = {
                    type = "instant",
                    target_effects = {
                        {
                            type = "create-entity",
                            entity_name = constants.native_tree_dummy,
                            check_buildability = true,
                            trigger_created_entity = true,
                        }
                    }
                }

            },
            animation = {
                filename = "__base__/graphics/entity/rocket/rocket.png",
                frame_count = 8,
                height = 35,
                line_length = 8,
                priority = "high",
                shift = {
                    0,
                    0
                },
                width = 9
            },
            flags = {
                "not-on-map"
            },
            light = {
                intensity = 0.8,
                size = 15
            },
            shadow = {
                filename = "__base__/graphics/entity/rocket/rocket-shadow.png",
                frame_count = 1,
                height = 24,
                priority = "high",
                shift = {
                    0,
                    0
                },
                width = 7
            },
            smoke = {
                {
                    deviation = {
                        0.15,
                        0.15
                    },
                    frequency = 1,
                    name = "smoke-fast",
                    position = {
                        0,
                        1
                    },
                    slow_down_factor = 1,
                    starting_frame = 3,
                    starting_frame_deviation = 5,
                    starting_frame_speed = 0,
                    starting_frame_speed_deviation = 5
                }
            }
        }
    })
end
