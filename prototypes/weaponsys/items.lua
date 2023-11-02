local constants = require("constants")

data:extend({
    ----WEAPONS
    {
        type = "item",
        name = constants.weapon_maraudermissle,
        icon = "__SE-ADds__/graphics/missles.png",
        icon_size = 64,
        subgroup = "defensive-structure",
        order = "zz[" .. constants.weapon_maraudermissle .. "]",
        stack_size = 50
    },
    {
        type = "item",
        name = constants.weapon_jerichomissle,
        icon = "__SE-ADds__/graphics/missles.png",
        icon_size = 64,
        subgroup = "defensive-structure",
        order = "zz[" .. constants.weapon_jerichomissle .. "]",
        stack_size = 10
    },
    {
        type = "item",
        name = constants.weapon_maraudertreemissle,
        icon = "__SE-ADds__/graphics/treemissles.png",
        icon_size = 64,
        subgroup = "defensive-structure",
        order = "zz[" .. constants.weapon_maraudertreemissle .. "]",
        stack_size = 50
    },
    ----WEAPONS/EFFECTS
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
        name = "se-delivery-cannon-weapon-package-" .. constants.weapon_jerichoWH,
        icon = "__space-exploration-graphics__/graphics/icons/delivery-cannon-weapon-capsule.png",
        icon_size = 64,
        order = "" .. constants.weapon_jerichoWH,
        flags = { "hidden" },
        subgroup = "delivery-cannon-capsules",
        stack_size = 1
    },
    {
        type = "ammo",
        name = constants.weapon_jerichoWH,
        ammo_type = {
            action = {
                action_delivery = {
                    projectile = constants.weapon_jerichoWH,
                    source_effects = {
                        entity_name = "explosion-hit",
                        type = "create-entity"
                    },
                    starting_speed = 0.5,
                    type = "projectile"
                    -- target_effects = {
                    --     {
                    --         type = "script",
                    --         effect_id = "ammotest"
                    --     }
                    -- },
                    -- type = "instant"
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
})
