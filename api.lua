-- library
local libraryLoader = loadstring(game:HttpGet('https://raw.githubusercontent.com/krionBl9nnhc93i/krionui/main/library.lua'))
local core = libraryLoader({
    theme = 'grape',
    rounding = true,
    smoothDragging = true,
})

-- colorpicker
local HttpService = game:GetService("HttpService")
local SETTINGS_FILE = "Krion_Settings.json"

-- load/save settings
local ui = {}

local window = core.newWindow({
    text = 'Krion.dev',
    resize = true,
    size = Vector2.new(550, 376),
})

local menus = {}
local sections = {}

local settings = {}

local function loadSettings()
    if isfile and isfile(SETTINGS_FILE) then
        local data = readfile(SETTINGS_FILE)
        local decoded = HttpService:JSONDecode(data)
        settings = decoded
    else
        settings = {}
    end
end

local function saveSettings()
    if writefile then
        local encoded = HttpService:JSONEncode(settings)
        writefile(SETTINGS_FILE, encoded)
    end
end

loadSettings()

local function getMenu(name)
    if not menus[name] then
        menus[name] = window:addMenu({text = name})
    end
    return menus[name]
end

local function getSection(menuName, sectionName)
    menus[menuName] = menus[menuName] or window:addMenu({text = menuName})
    sections[menuName] = sections[menuName] or {}

    if not sections[menuName][sectionName] then
        sections[menuName][sectionName] = menus[menuName]:addSection({text = sectionName})
    end
    return sections[menuName][sectionName]
end

function ui:Button(menuName, sectionName, text, callback)
    local section = getSection(menuName, sectionName)
    section:addButton({text = text}, callback)
end

function ui:Toggle(menuName, sectionName, text, callback)
    local section = getSection(menuName, sectionName)
    local toggle = section:addToggle({text = text})
    toggle:setState(settings[text] or false)
    toggle:bindToEvent('onToggle', function(state)
        settings[text] = state
        saveSettings()
        if callback then callback(state) end
    end)
    return toggle
end

function ui:Slider(menuName, sectionName, text, min, max, default, callback, step)
    local section = getSection(menuName, sectionName)
    local slider = section:addSlider({
        text = text,
        min = min,
        max = max,
        step = step or 1,
        val = settings[text] or default,
    }, function(val)
        settings[text] = val
        saveSettings()
        if callback then callback(val) end
    end)
    return slider
end

function ui:ColorPicker(menuName, sectionName, text, defaultColor, callback)
    local section = getSection(menuName, sectionName)
    local color = settings[text] and Color3.fromRGB(settings[text][1], settings[text][2], settings[text][3]) or defaultColor or Color3.new(1, 1, 1)
    local colorPicker = section:addColorPicker({text = text, color = color}, function(c)
        settings[text] = {math.floor(c.R*255), math.floor(c.G*255), math.floor(c.B*255)}
        saveSettings()
        if callback then callback(c) end
    end)
    return colorPicker
end

function ui:Textbox(menuName, sectionName, text, callback)
    local section = getSection(menuName, sectionName)
    local textbox = section:addTextbox({text = text})
    if callback then
        textbox:bindToEvent('onFocusLost', callback)
    end
    return textbox
end

function ui:Hotkey(menuName, sectionName, text, defaultKey)
    local section = getSection(menuName, sectionName)
    local hotkey = section:addHotkey({text = text})
    if defaultKey then hotkey:setHotkey(defaultKey) end
    return hotkey
end

-- notification (ekranda yazı)
function ui:Notify(text, duration)
    duration = duration or 3
    local notif = Instance.new("TextLabel")
    notif.Size = UDim2.new(0, 250, 0, 30)
    notif.Position = UDim2.new(0.5, -125, 0, 50) -- ekran üst ortaya yakın
    notif.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    notif.BackgroundTransparency = 0.6
    notif.TextColor3 = Color3.new(1,1,1)
    notif.Font = Enum.Font.GothamBold
    notif.TextSize = 20
    notif.Text = text
    notif.AnchorPoint = Vector2.new(0.5, 0)
    notif.Parent = game.CoreGui

    spawn(function()
        wait(duration)
        notif:Destroy()
    end)
end

function ui:Destroy()
    if window then
        window:Destroy()
        window = nil
        menus = {}
        sections = {}
    end
end

-- theme switcher
do
    local themeSection = getSection("Settings", "Themes")
    local themes = {"cherry", "orange", "lemon", "lime", "raspberry", "blueberry", "grape", "watermelon"}

    themeSection:addLabel({text = "Theme Switcher"})
    themeSection:addDropdown({
        text = "Select Theme",
        list = themes,
        selected = core.theme
    }, function(selected)
        core:setTheme(selected)
        ui:Notify("Theme changed to "..selected, 2)
    end)
end

-- universal loader
local function loadGameScript()
    local gameId = tostring(game.PlaceId)
    local baseUrl = "https://raw.githubusercontent.com/krionBl9nnhc93i/krionui/main/games/"

    local function tryLoad(id)
        local success, result = pcall(function()
            return game:HttpGet(baseUrl .. id .. ".lua")
        end)
        if success and result and result ~= "" then
            return result
        end
        return nil
    end

    local scriptCode = tryLoad(gameId)

    if not scriptCode then
        ui:Notify("[Krion] Game script yok, universal yüklendi.", 4)
        scriptCode = game:HttpGet(baseUrl .. "universal.lua")
    else
        ui:Notify("[Krion] Game script yüklendi: " .. gameId, 4)
    end

    local loadedFunc = loadstring(scriptCode)
    loadedFunc()(ui)
end

loadGameScript()

return ui
