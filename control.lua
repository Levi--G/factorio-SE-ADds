local constants = require("constants")
local utils = require("utils")

---@class ChunkScan
---@field Iterator LuaChunkIterator
---@field OnScan fun(scan:ChunkScan,chunk:ChunkPositionAndArea)
---@field OnEnd fun(scan:ChunkScan)
---@field Surface LuaSurface
---@field Count integer
--todo

---@class Jericho
---@field chunkposition MapPosition.0
---@field position MapPosition.0
---@field remaining integer
---@field radius integer
---@field octant_n integer
---@field index integer
---@field octant MapPosition.0[]
---@field last MapPosition.0
---@field surface LuaSurface
---@field force LuaForce
---@field tochart BoundingBox[]
---@field enemies ForceIdentification[]
---@field tolaunch MapPosition.0[]
---@field phase integer
---@field starttick integer

local ischunksscanning = false
---@type ChunkScan[]
local chunkscans = {}

function InitTreeTable()
    ---@type Jericho[]
    global.jericho = global.jericho or {}
    global.jerichohasitems = global.jerichohasitems or false
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

script.on_event(defines.events.on_tick, function(event)
    if (global.jerichohasitems) then
        doJerichoOnTick(event.tick)
    end
    if (ischunksscanning) then
        doScanOnTick()
    end
end)

script.on_event(defines.events.on_trigger_created_entity, function(eventdata)
    if (eventdata.entity.name == constants.weapon_jericholauncher) then
        local launcher = eventdata.entity
        local surface = launcher.surface
        local startchunk = {
            x = math.floor(launcher.position.x / 32) * 32,
            y = math.floor(launcher.position.y / 32) * 32
        }
        local force = launcher.force --[[@as LuaForce]]
        local enemies = GetEnemies(force)
        local remaining = 100
        table.insert(global.jericho, {
            chunkposition = startchunk,
            remaining = remaining,
            radius = 0,
            octant = calc_circle_octant(0),
            octant_n = 0,
            index = 0,
            last = nil,
            surface = surface,
            force = force,
            enemies = enemies,
            tolaunch = {},
            tochart = {},
            phase = 0,
            position = launcher.position --[[@as MapPosition.0]],
            starttick = eventdata.tick
        } --[[@as Jericho]]);
        global.jerichohasitems = true
        ---@diagnostic disable-next-line: missing-fields
        surface.create_entity({
            name = constants.weapon_jericholauncher,
            position = launcher.position,
            target = { launcher.position.x, launcher.position.y + (remaining / 5) },
            speed = 0.2,
            direction = defines.direction.south
        })
        launcher.destroy()
    end
end)

---@return ForceIdentification[]
---@param force LuaForce
function GetEnemies(force)
    local t = {}
    for _, f in pairs(game.forces) do
        if (force.is_enemy(f)) then
            table.insert(t, f.index)
        end
    end
    return t
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

commands.add_command("sead_clear_craters", "clears true nuke craters",
    function(Data)
        game.print("Clearing " .. game.player.surface.name)
        remote.call("True-Nukes Scripts", "clearAllCraters", game.player.surface)
    end)

function init_circle(radius)
    return {
        remaining = 100,
        radius = radius,
        octant = calc_circle_octant(radius),
        octant_n = 0,
        index = 0
    }
end

function calc_circle_octant(radius)
    if radius < 1 then return { { 0, 0 } } end
    local x = 0
    local y = radius
    local d = 3 - 2 * y
    local y0 = radius - 1
    local d0 = 3 - 2 * y0
    local octant = {}
    local insert = table.insert
    while x < y do
        insert(octant, { x, y })
        if (y - y0) == 2 then
            -- Fill in the gap.
            insert(octant, { x, y - 1 })
        end
        if d < 0 then
            d = d + 4 * x + 6
        else
            d = d + 4 * (x - y) + 10
            y = y - 1
        end
        if d0 < 0 then
            d0 = d0 + 4 * x + 6
        else
            d0 = d0 + 4 * (x - y0) + 10
            y0 = y0 - 1
        end
        x = x + 1
    end
    if x == y then insert(octant, { x, y }) end
    return octant
end

---comment
---@param state Jericho
---@return MapPosition.0?
function circle_next(state)
    local band = bit32.band
    local octant_n = state.octant_n
    local index = state.index
    if band(octant_n, 1) == 0 then
        if index == #state.octant then
            octant_n = octant_n + 1
            state.octant_n = octant_n
            local c = state.octant[index]
            if c[1] == c[2] then
                index = index - 1
                if index <= 0 then index = 1 end
            end
        else
            index = index + 1
        end
    else
        if index == 1 then
            if octant_n < 7 then
                octant_n = octant_n + 1
                state.octant_n = octant_n
            else
                octant_n = 0
                local r = state.radius + 1 --[[@as integer]]
                if (r > 64) then
                    return nil
                end
                state.radius = r
                state.octant = calc_circle_octant(r)
                state.octant_n = 0
            end
        else
            index = index - 1
        end
    end
    state.index = index
    local cursor = state.octant[index]
    local x = cursor[1]
    local y = cursor[2]
    if band(octant_n, 1) == 0 then
        local t = x
        x = y
        y = t
    end
    if band(octant_n, 2) == 0 then
        local t = x
        x = y
        y = -t
    end
    if octant_n > 3 then
        x = -x - 1
        y = -y
    end
    if (octant_n < 2) or (octant_n > 5) then
        y = y - 1
    end
    return { x = x, y = y }
end

---@param jericho Jericho
function doNextJerichoChunk(jericho)
    local pos = circle_next(jericho)
    if (pos == nil) then
        jericho.remaining = 0
        return
    end
    local x = jericho.chunkposition.x + (pos.x * 32)
    local y = jericho.chunkposition.y + (pos.y * 32)
    jericho.surface.play_sound({ path = constants.sound_jericho, position = { x, y } })
    table.insert(jericho.tochart, { { x, y }, { x + 32, y + 32 } })
    local enemies = jericho.surface.find_entities_filtered({
        area = { { x, y }, { x + 32, y + 32 } },
        force = jericho.enemies,
        is_military_target = true
    })
    for _, value in pairs(enemies) do
        table.insert(jericho.tolaunch, value.position)
        jericho.remaining = jericho.remaining - 1
        if (jericho.remaining == 0) then
            return
        end
    end
end

---@param tick integer
function doJerichoOnTick(tick)
    if (#global.jericho == 0) then
        global.jerichohasitems = false
        return
    end
    for i = 1, #global.jericho do
        local item = global.jericho[i]
        if (item.phase == 0) then
            while item.remaining > 0 do
                doNextJerichoChunk(item)
            end
            item.phase = 1
            goto continue
        elseif (item.phase == 1) then
            if (#item.tolaunch == 0) then
                item.phase = 2
                goto continue
            end
            local launch = table.remove(item.tolaunch) --[[@as MapPosition.0]]
            ---@diagnostic disable-next-line: missing-fields
            item.surface.create_entity({
                name = constants.weapon_jerichopartWH,
                position = { item.position.x, item.position.y + (tick - item.starttick) * 0.2 },
                target = launch,
                force = "player",
                speed = (100 / 240) / 5,
                direction = defines.direction.south
            })
        else
            if (tick >= item.starttick + 1800) then
                table.remove(global.jericho, i)
                for _, chunk in pairs(item.tochart) do
                    item.force.chart(item.surface, chunk)
                end
                return
            end
        end
        ::continue::
    end
end

local soundsys = require("prototypes.soundsys.control")
local treesys = require("prototypes.treesys.control")

---@type table<string,fun(EventData)>[]
local subsystems = { treesys, soundsys }
---@type table<integer,fun(EventData)[]>
local events = {}

for _, sys in pairs(subsystems) do
    for eventname, fun in pairs(sys) do
        events[defines.events[eventname]] = events[defines.events[eventname]] or {}
        table.insert(events[defines.events[eventname]], fun)
    end
end
for event, _ in pairs(events) do
    script.on_event(event, function(eventdata)
        for _, fun in pairs(events[event]) do
            fun(eventdata)
        end
    end)
end