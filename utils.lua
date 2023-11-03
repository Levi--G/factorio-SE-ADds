local utils = {}

---@param T table
---@return integer
utils.tablelength = function(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end

---@param Data CustomCommandData
---@return LuaSurface
utils.getSurfaceFromCommand = function(Data)
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

return utils
