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

-- Bu oyun için özel scriptler buraya gelecek
ui:Notify("2423809996 oyunu için script yüklendi!")

-- Örnek özellikler
ui:Button(
    "Özel", "Aksiyonlar", "Test Butonu",
    function()
        ui:Notify("Test butonu çalışıyor!")
    end
)

ui:Toggle(
    "Özel", "Ayarlar", "Özel Toggle",
    function(enabled)
        ui:Notify("Toggle: " .. (enabled and "Açık" or "Kapalı"))
    end
)
