local pressed_without_released = false;

---@alias params{on_touch:boolean, node:userdata, action:userdata, default_color: userdata, hover_color: userdata, click_color: userdata, callback: function}
---@param params params
local function button_input(params)
    local on_touch          = params.on_touch       or false
    local node              = params.node           or (error("**node**"))
    local action            = params.action         or (error("**action**"))
    local default_color     = params.default_color  or vmath.vector3(1,1,1)
    local hover_color       = params.hover_color    or vmath.vector3(0.5,0.5,0.5)
    local click_color       = params.click_color    or vmath.vector3(0,1,0)
    local callback          = params.callback       or function()  end

    if on_touch then
        if gui.pick_node(node, action.x, action.y) and action.released then
            gui.set_color(node, default_color)
            callback()
            press_without_released = false
        elseif gui.pick_node(node, action.x, action.y) and (action.pressed or press_without_released) then
            gui.set_color(node, click_color)
            press_without_released = true
        elseif action.released then
            gui.set_color(node, default_color)
            press_without_released = false
        end
    elseif gui.pick_node(node, action.x, action.y) and not press_without_released then
        gui.set_color(node, hover_color)
    elseif not press_without_released then
        gui.set_color(node, default_color)
    end
end

return button_input