local constants = require("constants")
local utils = require("utils")

local criteria = { "aux", "moisture", "temperature", "elevation" }
---@class Tree
---@field tile_restrict table<string,boolean>
---@field tile_invert boolean
---@field aux_optimal number
--todo

---@class ChunkScan
---@field Iterator LuaChunkIterator
---@field OnScan fun(scan:ChunkScan,chunk:ChunkPositionAndArea)
---@field OnEnd fun(scan:ChunkScan)
---@field Surface LuaSurface
---@field Count integer
--todo

local ischunksscanning = false
---@type ChunkScan[]
local chunkscans = {}

function moistureToWater(crit)
    if (crit == "moisture") then
        return "water"
    end
    return crit
end

function InitTreeTable()
    ---@type table<string,Tree>
    local trees = {}
    local tilecount = utils.tablelength(game.tile_prototypes)
    for tree_name, tree in pairs(game.get_filtered_entity_prototypes({ { filter = "type", type = "tree" } })) do
        if (not tree_name:find("dry") and not tree_name:find("dead") and not tree_name:find("waterGhost")) then
            if tree["autoplace_specification"] then
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
                    local restrictioncount = #tree.autoplace_specification.tile_restriction
                    if (restrictioncount > tilecount / 2) then
                        trees[tree_name].tile_invert = true
                        for name, value in pairs(game.tile_prototypes) do
                            local contains = false
                            for o = 1, restrictioncount do
                                if (name == tree.autoplace_specification.tile_restriction[o].first) then
                                    contains = true
                                    break
                                end
                            end
                            if (not contains) then
                                trees[tree_name].tile_restrict[name] = true
                            end
                        end
                    else
                        for o = 1, restrictioncount do
                            trees[tree_name].tile_restrict[tree.autoplace_specification.tile_restriction[o].first] = true
                        end
                    end
                end
            end
        end
    end
    global.trees = trees
    ---@type LuaEntity[]
    global.tospawn = global.tospawn or {}
    global.tospawnhasitems = global.tospawnhasitems or false
end

script.on_init(function()
    InitTreeTable()
end)

script.on_configuration_changed(function(data)
    InitTreeTable()
end)

function endCurrentScan()
    local scan = chunkscans[1]
    scan.OnEnd(scan)
    table.remove(chunkscans, 1)
    ischunksscanning = (#chunkscans > 0)
end

function doSpawnOnTick()
    for _ = 1, 5 do
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

function doScanOnTick()
    local scan = chunkscans[1]
    if (scan == nil) then
        ischunksscanning = false
        return
    end
    for _ = 1, 5 do
        local chunk = scan.Iterator()
        if (chunk == nil) then
            endCurrentScan()
            return
        end
        if (scan.Surface.is_chunk_generated({ chunk.x, chunk.y })) then
            scan.Count = scan.Count + 1
            scan.OnScan(scan, chunk)
        end
    end
end

script.on_event(defines.events.on_tick, function()
    if (global.tospawnhasitems) then
        doSpawnOnTick()
    end
    if (ischunksscanning) then
        doScanOnTick()
    end
end)

function checkAllowedTrees(tile, allowed, max)
    for tree_name, tree in pairs(global.trees) do
        local isok = true
        -- log(serpent.block(tree))
        for _, crit in pairs(criteria) do
            if (isok) then
                if (tree[crit .. "_optimal"]) then
                    -- log(tree_name ..
                    --     " " .. crit .. " = " .. tree[crit .. "_optimal"] .. " +- " .. tree[crit .. "_range"])
                    if (max) then
                        if (tile[crit][1] > tree[crit .. "_optimal"] + tree[crit .. "_max_range"] or tile[crit][1] < tree[crit .. "_optimal"] - tree[crit .. "_max_range"]) then
                            isok = false
                        end
                    else
                        if (tile[crit][1] > tree[crit .. "_optimal"] + tree[crit .. "_range"] or tile[crit][1] < tree[crit .. "_optimal"] - tree[crit .. "_range"]) then
                            isok = false
                        end
                    end
                end
            end
        end
        if isok then
            table.insert(allowed, tree_name)
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
        if (tree.tile_invert and tree.tile_restrict[tile]) then
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
        if (tree.tile_invert and tree.tile_restrict[tile]) then
            goto continue
        end
        table.insert(allowed, tree_name)
        ::continue::
    end
end

function checkForceAllowedTreesFast(tile, tileprops, allowed)
    for tree_name, tree in pairs(global.trees) do
        if (tree.tile_invert and tree.tile_restrict[tile]) then
            goto continue
        end
        table.insert(allowed, tree_name)
        ::continue::
    end
end

---comments
---@param surface LuaSurface
---@param mapposition MapPosition
---@param force boolean
function spawnNativeTreeAt(surface, mapposition, force)
    local tile = surface.get_tile(mapposition.x, mapposition.y)
    local tileprops = surface.calculate_tile_properties(criteria,
        { mapposition })
    -- log(serpent.block(tile))
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
        surface.create_entity({
            name = tree,
            position = mapposition,
            force = "neutral"
        })
    end
end

script.on_event(defines.events.on_built_entity, function(eventdata)
    if (eventdata.created_entity.name == constants.native_tree_dummy) then
        spawnNativeTreeAt(eventdata.created_entity.surface, eventdata.created_entity.position, true)
        eventdata.created_entity.destroy()
    end
end)

script.on_event(defines.events.on_trigger_created_entity, function(eventdata)
    if (eventdata.entity.name == constants.native_tree_dummy) then
        -- spawnNativeTreeAt(eventdata.entity.surface, eventdata.entity.position)
        -- eventdata.entity.destroy()
        table.insert(global.tospawn, eventdata.entity)
        global.tospawnhasitems = true
    end
end)

-- script.on_event(defines.events.on_script_trigger_effect, function(eventdata)
--     if (eventdata.effect_id == constants.trigger_tree_capsule) then
--         spawnNativeTreeAt(game.surfaces[eventdata.surface_index], eventdata.target_position)
--     end
--     -- if (eventdata.created_entity.type == "container") then
--     --     spawnNativeTreeAt(eventdata.created_entity.surface, eventdata.created_entity.position)
--     --     eventdata.created_entity.destroy()
--     -- end
-- end)

function getSurfaceFromCommand(Data)
    local player = game.get_player(Data.player_index)
    local surface = nil
    if (player) then
        surface = player.surface
    else
        surface = game.surfaces[1]
    end
    if (Data.parameter) then
        local surf = game.get_surface(Data.parameter)
        if (surf) then
            surface = surf
        end
    end
    return surface
end

---@param scan ChunkScan
---@param chunk ChunkPositionAndArea
function doFixSurfaceScan(scan, chunk)
    if (scan.Count == 1) then
        game.print("Starting fix scan on " .. scan.Surface.name)
    end
    local entities = scan.Surface.find_entities_filtered({ area = chunk.area })
    for _, entity in pairs(entities) do
        local health = entity.get_health_ratio()
        -- entity.health and entity.prototype and  and entity.prototype.max_health
        if (health and health < 1) then
            entity.health = entity.prototype.max_health
        end
    end
end

---@param scan ChunkScan
function endFixSurfaceScan(scan)
    game.print("Done fixing chunks on " .. scan.Surface.name)
end

---@param scan ChunkScan
---@param chunk ChunkPositionAndArea
function doEnsureExtinctionScan(scan, chunk)
    if (scan.Count == 1) then
        game.print("Starting nest scan on " .. scan.Surface.name)
    end
    local entities = scan.Surface.find_entities_filtered({ area = chunk.area, type = "unit-spawner", force = "enemy" })
    for _, _ in pairs(entities) do
        scan.Count = 0
        endCurrentScan()
        return
    end
end

---@param scan ChunkScan
function endEnsureExtinctionScan(scan)
    if (scan.Count == 0) then
        game.print("Still nests found on " .. scan.Surface.name)
        return
    end
    ischunksscanning = true
    table.insert(chunkscans,
        {
            Surface = scan.Surface,
            Iterator = scan.Surface.get_chunks(),
            OnScan = doDestroyEnemiesScan,
            OnEnd = endDestroyEnemiesScan,
            Count = 0
        } --[[@as ChunkScan]])
end

---@param scan ChunkScan
---@param chunk ChunkPositionAndArea
function doDestroyEnemiesScan(scan, chunk)
    if (scan.Count == 1) then
        game.print("Destroying biters on " .. scan.Surface.name)
    end
    local entities = scan.Surface.find_entities_filtered({ area = chunk.area, type = "unit", force = "enemy" })
    for _, entity in pairs(entities) do
        entity.destroy()
    end
end

---@param scan ChunkScan
function endDestroyEnemiesScan(scan)
    game.print("Done ensuring extinction on " .. scan.Surface.name)
end

commands.add_command("sead_fix_surface", "fixes current surface", function(Data)
    local surface = getSurfaceFromCommand(Data)
    chunksscan = surface.get_chunks()
    ischunksscanning = true
    table.insert(chunkscans,
        {
            Surface = surface,
            Iterator = surface.get_chunks(),
            OnScan = doFixSurfaceScan,
            OnEnd = endFixSurfaceScan,
            Count = 0
        } --[[@as ChunkScan]])
end)
commands.add_command("sead_ensure_extinction", "kills last biters IF all nests have been destroyed", function(Data)
    local surface = getSurfaceFromCommand(Data)
    chunksscan = surface.get_chunks()
    ischunksscanning = true
    table.insert(chunkscans,
        {
            Surface = surface,
            Iterator = surface.get_chunks(),
            OnScan = doEnsureExtinctionScan,
            OnEnd = endEnsureExtinctionScan,
            Count = 0
        } --[[@as ChunkScan]])
end)

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

commands.add_command("sead_scan_all", "runs all scans immediately",
    function(Data)
        if (not ischunksscanning) then
            game.print("no chunk scans in progress")
        end
        for _ = 1, 500000 do
            if (not ischunksscanning) then
                return
            end
            doScanOnTick()
        end
    end)
