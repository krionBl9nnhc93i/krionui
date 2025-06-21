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
local success, ui = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/krionBl9nnhc93i/krionui/main/api.lua"))()
end)

if not success then
    warn("[KrionUI] API yüklenemedi:", ui)
    return
end

-- Universal script'i yükle
local success, err = pcall(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/krionBl9nnhc93i/krionui/main/games/universal.lua"))()
end)

if not success then
    warn("[KrionUI] Script yüklenirken hata:", err)
    ui:Notify("Script yüklenirken hata oluştu!")
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
