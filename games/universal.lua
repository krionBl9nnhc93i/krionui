local ui = loadstring(game:HttpGet("https://raw.githubusercontent.com/krionBl9nnhc93i/krionui/main/api.lua"))()

local speedSelector = ui:Selector(
    "Movement", "Speed", "Speed Mode", {"CFrame", "Velocity", "Walkspeed"}, 1,
    function(idx, val)
        ui:Notify("Seçilen: " .. val)
    end
)

-- Speed slider
local speedSlider = ui:Slider(
    "Movement", "Speed", "Speed Value", 1, 100, 16,
    function(value)
        ui:Notify("Speed: " .. value)
    end
)

-- Jump power slider
local jumpSlider = ui:Slider(
    "Movement", "Jump", "Jump Power", 1, 200, 50,
    function(value)
        ui:Notify("Jump Power: " .. value)
    end
)

-- Toggle for speed
local speedToggle = ui:Toggle(
    "Movement", "Speed", "Enable Speed",
    function(enabled)
        ui:Notify("Speed " .. (enabled and "Açık" or "Kapalı"))
    end
)

-- Toggle for jump
local jumpToggle = ui:Toggle(
    "Movement", "Jump", "Enable Jump",
    function(enabled)
        ui:Notify("Jump " .. (enabled and "Açık" or "Kapalı"))
    end
)

-- Button example
ui:Button(
    "Movement", "Actions", "Reset Character",
    function()
        local player = game.Players.LocalPlayer
        if player.Character then
            player.Character:BreakJoints()
            ui:Notify("Karakter sıfırlandı!")
        end
    end
)

ui:Notify("Universal script yüklendi!")
