local constants = require("constants")
local utils = require("utils")

local soundsys = require("prototypes.soundsys.control")
local treesys = require("prototypes.treesys.control")
local weaponsys = require("prototypes.weaponsys.control")
local commandsys = require("prototypes.commandsys.control")

---@type table<string,fun(EventData)>[]
local subsystems = { treesys, weaponsys, soundsys, commandsys }
---@type table<string,fun(EventData)[]>
local events = {}

for _, sys in pairs(subsystems) do
    for eventname, fun in pairs(sys) do
        log(eventname)
        events[eventname] = events[eventname] or {}
        table.insert(events[eventname], fun)
    end
end
for event, _ in pairs(events) do
    if (event == "on_init") then
        script.on_init(function()
            for _, fun in pairs(events[event]) do
                fun()
            end
        end)
    elseif (event == "on_configuration_changed") then
        script.on_configuration_changed(function(eventdata)
            for _, fun in pairs(events[event]) do
                fun(eventdata)
            end
        end)
    else
        script.on_event(defines.events[event], function(eventdata)
            for _, fun in pairs(events[event]) do
                fun(eventdata)
            end
        end)
    end
end
