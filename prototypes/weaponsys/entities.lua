local constants = require("constants")

if settings.startup[constants.setting_weaponsys].value then
    data:extend({
        ----PROJECTILES
        {
            type = "projectile",
            name = constants.weapon_maraudermissleWH,
            acceleration = 0.5,
            action = {
                action_delivery = {
                    target_effects = {
                        {
                            action = {
                                action_delivery = {
                                    target_effects = {
                                        {
                                            damage = {
                                                amount = 1000,
                                                type = "physical"
                                            },
                                            type = "damage"
                                        },
                                    },
                                    type = "instant"
                                },
                                radius = 2,
                                type = "area"
                            },
                            type = "nested-result"
                        },
                        {
                            entity_name = "big-artillery-explosion",
                            type = "create-entity"
                        }
                    },
                    type = "instant"
                },
                type = "direct"
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
        },
        {
            type = "projectile",
            name = constants.weapon_jericholauncher,
            acceleration = 0,
            flags = {
                "not-on-map"
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
                width = 9,
                scale = 4
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
        } --[[@as data.ProjectilePrototype]],
        {
            type = "projectile",
            name = constants.weapon_jerichoWH,
            acceleration = 5,
            action = {
                action_delivery = {
                    target_effects = {
                        {
                            type = "create-entity",
                            entity_name = constants.weapon_jericholauncher,
                            trigger_created_entity = true
                        }
                    },
                    type = "instant"
                },
                type = "direct"
            },
            flags = {
                "not-on-map"
            }
        },
        {
            type = "projectile",
            name = constants.weapon_jerichopartWH,
            acceleration = 0.005,
            action = {
                type = "direct",
                action_delivery =
                {
                    type = "instant",
                    target_effects =
                    {
                        {
                            type = "nested-result",
                            action =
                            {
                                type = "area",
                                radius = 4.0,
                                action_delivery =
                                {
                                    type = "instant",
                                    target_effects =
                                    {
                                        {
                                            type = "damage",
                                            damage = { amount = 1000, type = "physical" }
                                        },
                                        {
                                            type = "damage",
                                            damage = { amount = 1000, type = "explosion" }
                                        }
                                    }
                                }
                            }
                        },
                        {
                            type = "create-trivial-smoke",
                            smoke_name = "artillery-smoke",
                            initial_height = 0,
                            speed_from_center = 0.05,
                            speed_from_center_deviation = 0.005,
                            offset_deviation = { { -4, -4 }, { 4, 4 } },
                            max_radius = 3.5,
                            repeat_count = 4 * 4 * 15
                        },
                        {
                            type = "create-entity",
                            entity_name = "big-artillery-explosion"
                        },
                        {
                            type = "show-explosion-on-chart",
                            scale = 8 / 32
                        }
                    },
                    max_range = 2500
                }
            },
            final_action =
            {
                type = "direct",
                action_delivery =
                {
                    type = "instant",
                    target_effects =
                    {
                        {
                            type = "create-entity",
                            entity_name = "medium-scorchmark-tintable",
                            check_buildability = true
                        }
                        -- ,
                        -- {
                        --     type = "invoke-tile-trigger",
                        --     repeat_count = 1
                        -- }
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
        }--[[@as data.ProjectilePrototype]]
    })

    if settings.startup[constants.setting_treesys].value then
        data:extend({
            {
                type = "projectile",
                name = constants.weapon_maraudertreemissleWH,
                acceleration = 2,
                action = {
                    action_delivery = {
                        target_effects = {
                            {
                                type = "nested-result",
                                action = {
                                    action_delivery = {
                                        target_effects = {
                                            {
                                                damage = {
                                                    amount = 1000,
                                                    type = "physical"
                                                },
                                                type = "damage"
                                            },
                                        },
                                        type = "instant"
                                    },
                                    radius = 2,
                                    type = "area"
                                }
                            },
                            {
                                type = "create-entity",
                                entity_name = "big-artillery-explosion"
                            },
                            {
                                type = "nested-result",
                                action = {
                                    type = "area",
                                    target_entities = false,
                                    repeat_count = 64,
                                    radius = 32,
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
                                }
                            }
                        },
                        type = "instant"
                    },
                    type = "direct"
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
end
