local constants = require("constants")
local utils = require("utils")

local soundsys = require("prototypes.soundsys.control")
local treesys = require("prototypes.treesys.control")
local weaponsys = require("prototypes.weaponsys.control")
local commandsys = require("prototypes.commandsys.control")

---@type table<string,fun(EventData)>[]
local subsystems = { treesys, weaponsys, soundsys, commandsys }
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
