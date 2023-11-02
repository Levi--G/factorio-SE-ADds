local constants = require("constants")
local utils = require("utils")

local soundsys = {}
if settings.startup[constants.setting_soundsys].value then
    ---@param event EventData.on_player_died
    soundsys.on_player_died = function(event)
        game.get_player(event.player_index).force.play_sound({ path = constants.sound_rip })
    end
end
return soundsys
