local HttpService = game:GetService("HttpService")

local function getGameId()
    return tostring(game.GameId or game.PlaceId or "unknown")
end
local baseConfigFolder = "Krion_configs"
local function getCurrentConfigPath()
    local gid = getGameId()
    local folder = baseConfigFolder.."/"..gid
    if not isfolder(baseConfigFolder) then makefolder(baseConfigFolder) end
    if not isfolder(folder) then makefolder(folder) end
    return folder.."/settings.json"
end

local libraryLoader = loadstring(game:HttpGet('https://raw.githubusercontent.com/krionBl9nnhc93i/krionui/main/library.lua'))()
local core = libraryLoader()

local ui = {}
local window = core.newWindow({
    text = 'krion ui',
    resize = true,
    size = Vector2.new(550, 376),
})

local menus, sections = {}, {}
local configFile = getCurrentConfigPath()
local config = {}

local function saveConfig()
    if writefile then
        writefile(configFile, HttpService:JSONEncode(config))
    end
end
local function loadConfig()
    if readfile and isfile and isfile(configFile) then
        local raw = readfile(configFile)
        if raw and #raw > 0 then
            local ok, data = pcall(function() return HttpService:JSONDecode(raw) end)
            if ok and type(data) == "table" then config = data end
        end
    end
end
loadConfig()

local function getMenu(menuName)
    if not menus[menuName] then
        menus[menuName] = window:addMenu({text = menuName})
        sections[menuName] = {}
    end
    return menus[menuName]
end
local function getSection(menuName, sectionName)
    local menu = getMenu(menuName)
    if not sections[menuName][sectionName] then
        sections[menuName][sectionName] = menu:addSection({text = sectionName})
    end
    return sections[menuName][sectionName]
end

function ui:Button(menu, section, text, cb)
    local sec = getSection(menu, section)
    sec:addButton({text = text}, cb)
end
function ui:Toggle(menu, section, text, cb)
    local sec = getSection(menu, section)
    local key = menu.."_"..section.."_"..text
    local state = config[key] or false
    local toggle = sec:addToggle({text = text, state = state}, function(val)
        config[key] = val; saveConfig()
        if cb then cb(val) end
    end)
    return toggle
end
function ui:Slider(menu, section, text, min, max, val, cb, step)
    local sec = getSection(menu, section)
    local key = menu.."_"..section.."_"..text
    local v = config[key] or val or min or 0
    local slider = sec:addSlider({
        text = text, min = min, max = max, value = v, step = step or 1
    }, function(newVal)
        config[key] = newVal; saveConfig()
        if cb then cb(newVal) end
    end)
    return slider
end
function ui:ColorPicker(menu, section, text, def, cb)
    local sec = getSection(menu, section)
    local key = menu.."_"..section.."_"..text
    local col = config[key]
    if col then def = Color3.new(col.r, col.g, col.b) end
    local picker = sec:addColorPicker({
        text = text,
        color = def or Color3.new(1,1,1)
    }, function(newCol)
        config[key] = {r = newCol.r, g = newCol.g, b = newCol.b}; saveConfig()
        if cb then cb(newCol) end
    end)
    return picker
end
function ui:Textbox(menu, section, text, cb)
    local sec = getSection(menu, section)
    local key = menu.."_"..section.."_"..text
    local box = sec:addTextbox({text = text})
    if config[key] then box:setText(config[key]) end
    if cb then
        box:bindToEvent('onFocusLost', function(val)
            config[key] = val; saveConfig()
            cb(val)
        end)
    end
    return box
end
function ui:Notify(msg, time)
    local data = {}
    if type(msg) == "string" then
        data.title = "info"; data.message = msg
    elseif type(msg) == "table" then
        data.title = msg.title or "info"
        data.message = msg.message or ""
        data.duration = msg.duration or time or 2
    end
    if not data.duration then data.duration = time or 2 end
    core.notify(data)
end

local UserInputService = game:GetService("UserInputService")
ui._hotkeys = {}
ui._hotkeyInputConnected = false
function ui:addHotkeyListener()
    if ui._hotkeyInputConnected then return end
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        for _, hotkey in pairs(ui._hotkeys) do
            if input.KeyCode == hotkey._key then
                for _, cb in ipairs(hotkey._callbacks) do pcall(cb) end
            end
        end
    end)
    ui._hotkeyInputConnected = true
end
function ui:Hotkey(menu, section, text, defaultKey)
    local sec = getSection(menu, section)
    local key = menu.."_"..section.."_"..text
    local saved = config[key]
    local hotkey = sec:addHotkey({text = text})
    hotkey._key = saved or defaultKey or Enum.KeyCode.Unknown
    hotkey._callbacks = {}

    function hotkey:setHotkey(k)
        self._key = k; config[key] = k; saveConfig()
    end
    function hotkey:GetHotkey() return self._key end
    function hotkey:bindToEvent(ev, cb)
        if ev == "onPress" and typeof(cb) == "function" then
            table.insert(self._callbacks, cb)
        end
    end

    table.insert(ui._hotkeys, hotkey)
    ui:addHotkeyListener()
    return hotkey
end
function ui:Destroy()
    if window then
        window:Destroy(); window = nil
        menus = {}; sections = {}
        ui._hotkeys = {}; ui._hotkeyInputConnected = false
    end
end

return ui
