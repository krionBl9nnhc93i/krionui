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

-- KrionUI Main Loader
local function loadScript(url)
    local success, result = pcall(function()
        return game:HttpGet(url)
    end)
    
    if success then
        local loadSuccess, loadResult = pcall(function()
            return loadstring(result)()
        end)
        
        if not loadSuccess then
            warn("[KrionUI] Script yükleme hatası:", loadResult)
            return false, loadResult
        end
        
        return true, loadResult
    else
        warn("[KrionUI] HTTP hatası:", result)
        return false, result
    end
end

-- API'yi yükle
local apiSuccess, ui = loadScript("https://raw.githubusercontent.com/krionBl9nnhc93i/krionui/main/api.lua")
if not apiSuccess then
    warn("[KrionUI] API yüklenemedi!")
    return
end

-- Universal script'i yükle
local scriptSuccess = loadScript("https://raw.githubusercontent.com/krionBl9nnhc93i/krionui/main/games/universal.lua")
if not scriptSuccess then
    if ui and ui.Notify then
        ui:Notify("Script yüklenirken hata oluştu!")
    end
end

if scriptToLoad then
    local chunk = loadfile(scriptToLoad)
    if chunk then
        local ok, err = pcall(chunk)
        if not ok then
            ui:Notify("script crashed: " .. tostring(err))
        end
    else
        ui:Notify("script can't be loaded: " .. tostring(scriptToLoad))
    end
else
    ui:Notify("no compatible script found for this game")
end
