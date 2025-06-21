local gamesFolder = "games/"
local gid = tostring(game.GameId or game.PlaceId or "unknown")
local scriptToLoad

if isfile and isfile(gamesFolder..gid..".lua") then
    scriptToLoad = gamesFolder..gid..".lua"
elseif isfile and isfile(gamesFolder.."universal.lua") then
    scriptToLoad = gamesFolder.."universal.lua"
else
    scriptToLoad = nil
end

local ui = loadstring(game:HttpGet("https://raw.githubusercontent.com/krionBl9nnhc93i/krionui/main/api.lua"))()

if scriptToLoad then
    local success, result = pcall(function()
        local fileContent = readfile(scriptToLoad)
        local chunk = loadstring(fileContent)
        if chunk then
            return chunk()
        else
            error("Script yüklenemedi: " .. scriptToLoad)
        end
    end)
    
    if not success then
        ui:Notify("Script hatası: " .. tostring(result))
    end
else
    ui:Notify("Bu oyun için uyumlu script bulunamadı")
end
