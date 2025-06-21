local ui = loadstring(game:HttpGet("https://raw.githubusercontent.com/krionBl9nnhc93i/krionui/main/api.lua"))()
local speedSelector = ui:Selector("Movement", "Speed", "Speed Mode", {"CFrame", "Velocity", "Walkspeed"}, 1, function(idx, val)
    ui:Notify("Seçilen: " .. val)
end)

print("selector", speedSelector)
print("get", speedSelector.get)
print("set", speedSelector.set)

if speedSelector and speedSelector.get then
    local i, v = speedSelector:get()
    speedSelector:set(2)
else
    warn("Selector'da get() ve/veya set() yok!")
end
