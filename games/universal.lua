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
print("typeof:", typeof(speedSelector))
print("metatable:", getmetatable(speedSelector))
for k,v in pairs(speedSelector) do print("INSTANCE FIELD", k, v) end
for k,v in pairs(getmetatable(speedSelector) or {}) do print("MT FIELD", k, v) end
