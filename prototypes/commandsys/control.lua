local constants = require("constants")
local utils = require("utils")

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

function endCurrentScan()
    local scan = chunkscans[1]
    scan.OnEnd(scan)
    table.remove(chunkscans, 1)
    ischunksscanning = (#chunkscans > 0)
end

function doScanOnTick()
    if (ischunksscanning) then
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

local commandsys = {}
if settings.startup[constants.setting_soundsys].value then
    commandsys.on_tick = doScanOnTick

    commands.add_command("sead_fix_surface", "fixes current surface", function(Data)
        local surface = utils.getSurfaceFromCommand(Data)
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
        local surface = utils.getSurfaceFromCommand(Data)
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
    if (game.active_mods["True-Nukes"]) then
        commands.add_command("sead_clear_craters", "clears true nuke craters",
            function(Data)
                game.print("Clearing " .. game.player.surface.name)
                remote.call("True-Nukes Scripts", "clearAllCraters", game.player.surface)
            end)
    end
end
return commandsys
