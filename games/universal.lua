--[[

  _    _ _ _         _                              __                                   _ 
 | |  (_) | |       (_)                            / _|                                 | |
 | | ___| | |  _ __  _  __ _  __ _  ___ _ __ ___  | |_ ___  _ __   _ __   _____      __ | |
 | |/ / | | | | '_ \| |/ _` |/ _` |/ _ \ '__/ __| |  _/ _ \| '__| | '_ \ / _ \ \ /\ / / | |
 |   <| | | | | | | | | (_| | (_| |  __/ |  \__ \ | || (_) | |    | | | | (_) \ V  V /  |_|
 |_|\_\_|_|_| |_| |_|_|\__, |\__, |\___|_|  |___/ |_| \___/|_|    |_| |_|\___/ \_/\_/   (_)
                        __/ | __/ |                                                        
                       |___/ |___/                                                         


soon !
--]]

local ui = loadstring(game:HttpGet("https://raw.githubusercontent.com/krionBl9nnhc93i/krionui/main/api.lua"))()

local speedSelector = ui:Selector(
    "Movement", "Speed",
    "Speed Mode",
    {"CFrame", "Velocity", "Walkspeed"},
    1,
    function(idx, val)
        ui:Notify("Seçilen: " .. val)
    end
)

local i, v = speedSelector:get()
speedSelector:set(2)
