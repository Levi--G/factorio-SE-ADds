local constants = require("constants")
local utils = require("utils")

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

function do_on_init()
    ---@type Jericho[]
    global.jericho = global.jericho or {}
    global.jerichohasitems = global.jerichohasitems or false
end

function do_on_tick(event)
    if (global.jerichohasitems) then
        doJerichoOnTick(event.tick)
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

function do_on_trigger_created_entity(eventdata)
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
end

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


local weaponsys = {}
if settings.startup[constants.setting_weaponsys].value then
    weaponsys.on_init = do_on_init
    weaponsys.on_configuration_changed = do_on_init
    weaponsys.on_tick = do_on_tick
    weaponsys.on_trigger_created_entity = do_on_trigger_created_entity
end
return weaponsys
