local constants = require("constants")

data:extend({
    ----TREES/RESOURCES
    {
        type = "item",
        name = constants.item_tree,
        icon = "__SE-ADds__/graphics/tree-icon.png",
        icon_size = 64,
        -- flags = {},
        subgroup = "raw-material",
        order = "z[" .. constants.item_tree .. "]",
        -- place_result = tree_name,
        stack_size = 50,
        place_result = constants.native_tree_dummy,
    },
    {
        type = "item",
        name = constants.item_potash,
        icon = "__SE-ADds__/graphics/potash.png",
        icon_size = 64,
        -- flags = {},
        subgroup = "raw-material",
        order = "z[" .. constants.item_potash .. "]",
        -- place_result = tree_name,
        stack_size = 50
    },
    {
        type = "item",
        name = constants.item_fertilizer,
        icon = "__SE-ADds__/graphics/fertilizer.png",
        icon_size = 64,
        -- flags = {},
        subgroup = "raw-material",
        order = "z[" .. constants.item_fertilizer .. "]",
        -- place_result = tree_name,
        stack_size = 50
    },
    ----ENTITY
    {
        type = "item",
        name = constants.assembler_cokery,
        icon = "__SE-ADds__/graphics/Bio_Industries/cokery.png",
        icon_size = 64,
        subgroup = "production-machine",
        order = "x[bi]-b[bi-cokery]",
        place_result = constants.assembler_cokery,
        stack_size = 10
    },
    {
        type = "item",
        name = constants.assembler_farm,
        icon = "__SE-ADds__/graphics/Bio_Industries/Bio_Farm_Icon.png",
        icon_size = 64,
        subgroup = "production-machine",
        order = "x[bi]-ab[bi-bio-farm]",
        place_result = constants.assembler_farm,
        stack_size = 10,
    },
    ----WEAPONS
    {
        type = "item",
        name = constants.weapon_maraudermissle,
        icon = "__SE-ADds__/graphics/missles.png",
        icon_size = 64,
        -- flags = {},
        subgroup = "defensive-structure",
        order = "zz[" .. constants.weapon_maraudermissle .. "]",
        -- place_result = tree_name,
        stack_size = 50
    },
    {
        type = "item",
        name = constants.weapon_maraudertreemissle,
        icon = "__SE-ADds__/graphics/treemissles.png",
        icon_size = 64,
        -- flags = {},
        subgroup = "defensive-structure",
        order = "zz[" .. constants.weapon_maraudertreemissle .. "]",
        -- place_result = tree_name,
        stack_size = 50
    },
    {
        type = "item",
        name = constants.weapon_treenuke,
        icon = "__SE-ADds__/graphics/treenuke.png",
        icon_size = 64,
        -- flags = {},
        subgroup = "defensive-structure",
        order = "zz[" .. constants.weapon_treenuke .. "]",
        -- place_result = tree_name,
        stack_size = 1
    },
    ----WEAPONS/EFFECTS
    {
        type = "capsule",
        name = constants.item_tree_capsule,
        icon = "__SE-ADds__/graphics/treecap-icon.png",
        icon_size = 64,
        subgroup = "defensive-structure",
        order = "zz[" .. constants.item_tree_capsule .. "]",
        stack_size = 20,
        capsule_action = {
            type = "throw",
            attack_parameters = {
                type = "projectile",
                cooldown = 30,
                range = 100,
                activation_type = "throw",
                ammo_type = {
                    target_type = "position",
                    category = "grenade",
                    action = {
                        type = "area",
                        target_entities = false,
                        repeat_count = 512,
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
            }
        }
    },
    {
        type = "capsule",
        name = constants.item_tree_capsule_advanced,
        icon = "__SE-ADds__/graphics/treecap-icon.png",
        icon_size = 64,
        subgroup = "defensive-structure",
        order = "zz[" .. constants.item_tree_capsule_advanced .. "]",
        stack_size = 20,
        capsule_action = {
            type = "throw",
            attack_parameters = {
                type = "projectile",
                cooldown = 60,
                range = 200,
                activation_type = "throw",
                ammo_type = {
                    target_type = "position",
                    category = "grenade",
                    action = {
                        type = "area",
                        target_entities = false,
                        repeat_count = 2048,
                        radius = 128,
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
            }
        }
    },
    {
        type = "item",
        name = "se-delivery-cannon-weapon-package-" .. constants.weapon_maraudermissleWH,
        icon = "__space-exploration-graphics__/graphics/icons/delivery-cannon-weapon-capsule.png",
        icon_size = 64,
        order = "" .. constants.weapon_maraudermissleWH,
        flags = { "hidden" },
        subgroup = "delivery-cannon-capsules",
        stack_size = 1
    },
    {
        type = "ammo",
        name = constants.weapon_maraudermissleWH,
        ammo_type = {
            action = {
                action_delivery = {
                    projectile = constants.weapon_maraudermissleWH,
                    source_effects = {
                        entity_name = "explosion-hit",
                        type = "create-entity"
                    },
                    starting_speed = 0.5,
                    type = "projectile"
                },
                type = "direct"
            },
            category = "weapons-delivery-cannon",
            cooldown_modifier = 1,
            range_modifier = 3,
            target_type = "position"
        },
        icon = "__base__/graphics/icons/cannon-shell.png",
        icon_mipmaps = 4,
        icon_size = 64,
        order = "d[rocket-launcher]-c[atomic-bomb]",
        stack_size = 1,
        subgroup = "ammo",
        flags = { "hidden" }
    },
    {
        type = "item",
        name = "se-delivery-cannon-weapon-package-" .. constants.weapon_maraudertreemissleWH,
        icon = "__space-exploration-graphics__/graphics/icons/delivery-cannon-weapon-capsule.png",
        icon_size = 64,
        order = "" .. constants.weapon_maraudertreemissleWH,
        flags = { "hidden" },
        subgroup = "delivery-cannon-capsules",
        stack_size = 1
    },
    {
        type = "ammo",
        name = constants.weapon_maraudertreemissleWH,
        ammo_type = {
            action = {
                action_delivery = {
                    projectile = constants.weapon_maraudertreemissleWH,
                    source_effects = {
                        entity_name = "explosion-hit",
                        type = "create-entity"
                    },
                    starting_speed = 2,
                    type = "projectile"
                },
                type = "direct"
            },
            category = "weapons-delivery-cannon",
            cooldown_modifier = 1,
            range_modifier = 3,
            target_type = "position"
        },
        icon = "__base__/graphics/icons/cannon-shell.png",
        icon_mipmaps = 4,
        icon_size = 64,
        order = "d[rocket-launcher]-c[atomic-bomb]",
        stack_size = 1,
        subgroup = "ammo",
        flags = { "hidden" }
    },
    {
        type = "item",
        name = "se-delivery-cannon-weapon-package-" .. constants.weapon_treenukeWH,
        icon = "__space-exploration-graphics__/graphics/icons/delivery-cannon-weapon-capsule.png",
        icon_size = 64,
        order = "" .. constants.weapon_treenukeWH,
        flags = { "hidden" },
        subgroup = "delivery-cannon-capsules",
        stack_size = 1
    },
    {
        type = "ammo",
        name = constants.weapon_treenukeWH,
        ammo_type = {
            action = {
                action_delivery = {
                    projectile = constants.weapon_treenukeWH,
                    source_effects = {
                        entity_name = "explosion-hit",
                        type = "create-entity"
                    },
                    starting_speed = 2,
                    type = "projectile"
                },
                type = "direct"
            },
            category = "weapons-delivery-cannon",
            cooldown_modifier = 1,
            range_modifier = 3,
            target_type = "position"
        },
        icon = "__base__/graphics/icons/cannon-shell.png",
        icon_mipmaps = 4,
        icon_size = 64,
        order = "d[rocket-launcher]-c[atomic-bomb]",
        stack_size = 1,
        subgroup = "ammo",
        flags = { "hidden" }
    }
})
