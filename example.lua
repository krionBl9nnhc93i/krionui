local ui = loadstring(game:HttpGet("https://raw.githubusercontent.com/krionBl9nnhc93i/krionui/main/api.lua"))()

local menu = "main"
local section = "test"

-- button
ui:Button(menu, section, "click me", function()
    print("button clicked")
    ui:Notify("button clicked", 2)
end)

-- toggle
ui:Toggle(menu, section, "on or off", function(state)
    print("toggle:", state)
    ui:Notify("toggle: " .. tostring(state), 1)
end)

-- slider
ui:Slider(menu, section, "slider", 0, 100, 50, function(val)
    print("slider:", val)
    ui:Notify("slider: " .. tostring(val), 1)
end)

-- color picker
ui:ColorPicker(menu, section, "color", Color3.new(1,1,1), function(color)
    print("color picked:", color)
    ui:Notify("color picked", 1)
end)

-- textbox
ui:Textbox(menu, section, "type here", function(text)
    print("textbox:", text)
    ui:Notify("textbox: " .. text, 1)
end)

-- hotkey
local hk = ui:Hotkey(menu, section, "hotkey", Enum.KeyCode.F)
hk:bindToEvent("onPress", function()
    print("hotkey pressed")
    ui:Notify("hotkey pressed", 1)
end)

-- label
if ui.Label then
    ui:Label(menu, section, "this is a label")
end

-- notify
ui:Notify("all modules loaded", 3)

-- ui:Button("Menü", "Section", "Buton", function() ... end)
