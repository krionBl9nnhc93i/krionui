local ui = loadstring(game:HttpGet("https://raw.githubusercontent.com/krionBl9nnhc93i/krionui/main/api.lua"))()
local speedSelector = ui:Selector(
    "Movement", "Speed", "Speed Mode", {"CFrame", "Velocity", "Walkspeed"}, 1,
    function(idx, val)
        ui:Notify("Seçilen: " .. val)
    end
)

print("speedSelector:", speedSelector)
print("speedSelector.get:", speedSelector.get)
print("speedSelector.set:", speedSelector.set)
