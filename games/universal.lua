-- Universal Script for KrionUI
local success, ui = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/krionBl9nnhc93i/krionui/main/api.lua"))()
end)

if not success then
    warn("[KrionUI] UI yüklenemedi:", ui)
    return
end

-- UI Elemanları
local function createUIElements()
    -- Speed selector
    local speedSelector = ui:Selector(
        "Movement", "Speed", "Speed Mode", 
        {"CFrame", "Velocity", "Walkspeed"}, 1,
        function(idx, val)
            pcall(function()
                ui:Notify("Seçilen: " .. tostring(val))
                -- Burada speed modunu uygula
                local player = game.Players.LocalPlayer
                local character = player and player.Character
                local humanoid = character and character:FindFirstChild("Humanoid")
                
                if humanoid then
                    if val == "Walkspeed" then
                        humanoid.WalkSpeed = speedSlider.value or 16
                    elseif val == "CFrame" then
                        -- CFrame speed buraya gelecek
                    elseif val == "Velocity" then
                        -- Velocity speed buraya gelecek
                    end
                end
            end)
        end
    )

    -- Speed slider
    local speedSlider = ui:Slider(
        "Movement", "Speed", "Speed Value", 1, 500, 16,
        function(value)
            pcall(function()
                ui:Notify("Speed: " .. tostring(value))
                -- Speed değerini uygula
                local player = game.Players.LocalPlayer
                local character = player and player.Character
                local humanoid = character and character:FindFirstChild("Humanoid")
                
                if humanoid then
                    humanoid.WalkSpeed = value
                end
            end)
        end
    )

    -- Jump power slider
    local jumpSlider = ui:Slider(
        "Movement", "Jump", "Jump Power", 1, 500, 50,
        function(value)
            pcall(function()
                ui:Notify("Jump Power: " .. tostring(value))
                -- Jump power'ı uygula
                local player = game.Players.LocalPlayer
                local character = player and player.Character
                local humanoid = character and character:FindFirstChild("Humanoid")
                
                if humanoid then
                    humanoid.JumpPower = value
                end
            end)
        end
    )

    -- Toggle for speed
    local speedToggle = ui:Toggle(
        "Movement", "Speed", "Enable Speed",
        function(enabled)
            pcall(function()
                ui:Notify("Speed " .. (enabled and "Açık" or "Kapalı"))
                -- Speed'i aç/kapa
                local player = game.Players.LocalPlayer
                local character = player and player.Character
                local humanoid = character and character:FindFirstChild("Humanoid")
                
                if humanoid then
                    if enabled then
                        humanoid.WalkSpeed = speedSlider.value or 16
                    else
                        humanoid.WalkSpeed = 16
                    end
                end
            end)
        end
    )

    -- Toggle for jump
    local jumpToggle = ui:Toggle(
        "Movement", "Jump", "Enable Jump",
        function(enabled)
            pcall(function()
                ui:Notify("Jump " .. (enabled and "Açık" or "Kapalı"))
                -- Jump'ı aç/kapa
                local player = game.Players.LocalPlayer
                local character = player and player.Character
                local humanoid = character and character:FindFirstChild("Humanoid")
                
                if humanoid then
                    if enabled then
                        humanoid.JumpPower = jumpSlider.value or 50
                    else
                        humanoid.JumpPower = 50
                    end
                end
            end)
        end
    )

    -- Button example
    ui:Button(
        "Movement", "Actions", "Reset Character",
        function()
            pcall(function()
                local player = game.Players.LocalPlayer
                if player and player.Character then
                    player.Character:BreakJoints()
                    ui:Notify("Karakter sıfırlandı!")
                end
            end)
        end
    )

    -- Return UI elements for reference
    return {
        speedSelector = speedSelector,
        speedSlider = speedSlider,
        jumpSlider = jumpSlider,
        speedToggle = speedToggle,
        jumpToggle = jumpToggle
    }
end

-- Initialize UI
local success, elements = pcall(createUIElements)
if success then
    ui:Notify("Universal script başarıyla yüklendi!")
else
    warn("[KrionUI] UI elemanları oluşturulurken hata:", elements)
end 
