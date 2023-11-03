local constants = require("constants")
local utils = require("utils")

local criteria = { "aux", "moisture", "temperature", "elevation" }

---@class Tree
---@field tile_restrict table<string,boolean>
---@field aux_optimal number
--todo

function moistureToWater(crit)
    if (crit == "moisture") then
        return "water"
    end
    return crit
end

function do_on_init()
    ---@type table<string,Tree>
    local trees = {}
    for tree_name, tree in pairs(game.get_filtered_entity_prototypes({ { filter = "type", type = "tree" } })) do
        if (not tree_name:find("dry") and not tree_name:find("dead") and not tree_name:find("waterGhost") and tree.autoplace_specification) then
            ---@diagnostic disable-next-line: missing-fields
            trees[tree_name] = {}
            for _, peak in ipairs(tree.autoplace_specification.peaks) do
                if (peak.influence == 1) then
                    for _, crit in ipairs(criteria) do
                        if (peak[moistureToWater(crit) .. "_optimal"] and peak[moistureToWater(crit) .. "_range"] and peak[moistureToWater(crit) .. "_max_range"])
                        then
                            trees[tree_name][crit .. "_optimal"] = peak[moistureToWater(crit) .. "_optimal"]
                            trees[tree_name][crit .. "_range"] = peak[moistureToWater(crit) .. "_range"]
                            trees[tree_name][crit .. "_max_range"] = peak[moistureToWater(crit) .. "_max_range"]
                        end
                    end
                end
            end
            for _, crit in ipairs(criteria) do
                if (not trees[tree_name][crit .. "_optimal"])
                then
                    trees[tree_name][crit .. "_optimal"] = 0
                    trees[tree_name][crit .. "_range"] = 500
                    trees[tree_name][crit .. "_max_range"] = 500
                end
            end
            if (tree.autoplace_specification.tile_restriction) then
                trees[tree_name].tile_restrict = {}
                for _, res in pairs(tree.autoplace_specification.tile_restriction) do
                    trees[tree_name].tile_restrict[res.first] = true
                end
            end
        end
    end
    global.trees = trees
    ---@type LuaEntity[]
    global.tospawn = global.tospawn or {}
    global.tospawnhasitems = global.tospawnhasitems or false
end

function doSpawnOnTick()
    if (global.tospawnhasitems) then
        for _ = 1, 10 do
            if (#global.tospawn == 0) then
                global.tospawnhasitems = false
                return
            end
            ---@type LuaEntity
            local spawn = table.remove(global.tospawn)
            if (spawn.valid) then
                spawnNativeTreeAt(spawn.surface, spawn.position, false)
                spawn.destroy()
            end
        end
    end
end

function checkMaxAllowedTreesFast(tile, tileprops, allowed)
    for tree_name, tree in pairs(global.trees) do
        if (tileprops.temperature[1] > tree["temperature_optimal"] + tree["temperature_max_range"] or tileprops["temperature"][1] < tree["temperature_optimal"] - tree["temperature_max_range"]) then
            goto continue
        end
        if (tileprops["moisture"][1] > tree["moisture_optimal"] + tree["moisture_max_range"] or tileprops["moisture"][1] < tree["moisture_optimal"] - tree["moisture_max_range"]) then
            goto continue
        end
        if (tileprops["aux"][1] > tree["aux_optimal"] + tree["aux_max_range"] or tileprops["aux"][1] < tree["aux_optimal"] - tree["aux_max_range"]) then
            goto continue
        end
        if (tileprops["elevation"][1] > tree["elevation_optimal"] + tree["elevation_max_range"] or tileprops["elevation"][1] < tree["elevation_optimal"] - tree["elevation_max_range"]) then
            goto continue
        end
        if (tree.tile_restrict[tile]) then
            goto continue
        end
        table.insert(allowed, tree_name)
        ::continue::
    end
end

function checkAllowedTreesFast(tile, tileprops, allowed)
    for tree_name, tree in pairs(global.trees) do
        if (tileprops["temperature"][1] > tree["temperature_optimal"] + tree["temperature_range"] or tileprops["temperature"][1] < tree["temperature_optimal"] - tree["temperature_range"]) then
            goto continue
        end
        if (tileprops["moisture"][1] > tree["moisture_optimal"] + tree["moisture_range"] or tileprops["moisture"][1] < tree["moisture_optimal"] - tree["moisture_range"]) then
            goto continue
        end
        if (tileprops["aux"][1] > tree["aux_optimal"] + tree["aux_range"] or tileprops["aux"][1] < tree["aux_optimal"] - tree["aux_range"]) then
            goto continue
        end
        if (tileprops["elevation"][1] > tree["elevation_optimal"] + tree["elevation_range"] or tileprops["elevation"][1] < tree["elevation_optimal"] - tree["elevation_range"]) then
            goto continue
        end
        if (tree.tile_restrict[tile]) then
            goto continue
        end
        table.insert(allowed, tree_name)
        ::continue::
    end
end

function checkForceAllowedTreesFast(tile, tileprops, allowed)
    for tree_name, tree in pairs(global.trees) do
        if (not tree.tile_restrict[tile]) then
            table.insert(allowed, tree_name)
        end
    end
end

---@param surface LuaSurface
---@param mapposition MapPosition
---@param force boolean
function spawnNativeTreeAt(surface, mapposition, force)
    local tile = surface.get_tile(mapposition.x, mapposition.y)
    local tileprops = surface.calculate_tile_properties(criteria,
        { mapposition })
    local allowed = {}
    checkAllowedTreesFast(tile, tileprops, allowed)
    if (#allowed == 0) then
        checkMaxAllowedTreesFast(tile, tileprops, allowed)
    end
    if (#allowed == 0 and force) then
        --fall back to random
        checkForceAllowedTreesFast(tile, tileprops, allowed)
    end
    if (#allowed > 0) then
        local tree = allowed[math.random(1, #allowed)]
        ---@diagnostic disable-next-line: missing-fields
        surface.create_entity({
            name = tree,
            position = mapposition,
            force = "neutral"
        })
    end
end

---@param eventdata EventData.on_built_entity
function do_on_built_entity(eventdata)
    if (eventdata.created_entity.name == constants.native_tree_dummy) then
        spawnNativeTreeAt(eventdata.created_entity.surface, eventdata.created_entity.position, true)
        eventdata.created_entity.destroy()
    end
end

---@param eventdata EventData.on_trigger_created_entity
function do_on_trigger_created_entity(eventdata)
    if (eventdata.entity.name == constants.native_tree_dummy) then
        table.insert(global.tospawn, eventdata.entity)
        global.tospawnhasitems = true
    end
end

local treesys = {}
if settings.startup[constants.setting_treesys].value then
    commands.add_command("sead_print_spawn_count", "prints how many trees are in queue to spawn", function(Data)
        local player = game.get_player(Data.player_index)
        if (player) then
            player.print(#global.tospawn)
        end
    end)

    commands.add_command("sead_spawn_all", "spawns all trees in queue to spawn, max 500.000 (+-30mins gameplay)",
        function(Data)
            if (not global.tospawnhasitems) then
                game.print("Nothing to Spawn")
            end
            for _ = 1, 500000 do
                if (not global.tospawnhasitems) then
                    return
                end
                doSpawnOnTick()
            end
        end)

    treesys.on_init = do_on_init
    treesys.on_configuration_changed = do_on_init
    treesys.on_tick = doSpawnOnTick
    treesys.on_built_entity = do_on_built_entity
    treesys.on_trigger_created_entity = do_on_trigger_created_entity
end
return treesys
