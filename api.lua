-- krion api
-- so sexy i cum
local libraryLoader = loadstring(game:HttpGet('https://raw.githubusercontent.com/krionBl9nnhc93i/krionui/main/library.lua'))
local core = libraryLoader({
    theme = 'grape',
    rounding = true,
    smoothDragging = true,
})


local ui = {}

local window = core.newWindow({
    text = 'Krion.dev',
    resize = true,
    size = Vector2.new(550, 376),
})

local menus = {}
local sections = {}

local function getMenu(name)
    if not menus[name] then
        menus[name] = window:addMenu({text = name})
        sections[name] = {}  -- dont change here !
    end
    return menus[name]
end

local function getSection(menuName, sectionName)
    local menu = getMenu(menuName)
    if not sections[menuName][sectionName] then
        sections[menuName][sectionName] = menu:addSection({text = sectionName})
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
    toggle:bindToEvent('onToggle', callback)
    return toggle
end

function ui:Slider(menuName, sectionName, text, min, max, default, callback, step)
    local section = getSection(menuName, sectionName)
    local slider = section:addSlider({
        text = text,
        min = min,
        max = max,
        step = step or 1,
        val = default,
    }, callback)
    return slider
end

function ui:ColorPicker(menuName, sectionName, text, defaultColor, callback)
    local section = getSection(menuName, sectionName)
    local colorPicker = section:addColorPicker({
        text = text,
        color = defaultColor or Color3.fromRGB(255, 255, 255),
    }, callback)
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
    if defaultKey then
        hotkey:setHotkey(defaultKey)
    end
    return hotkey
end

function ui:Destroy()
    if window then
        window:Destroy()
        window = nil
        menus = {}
        sections = {}
    end
end

return ui

--
-- ██▒   █▓ ▒█████   ██▓  ▄▄▄█████▓ ▒█████   █    ██       ██▓     ▒█████   ██▓    
--▓██░   █▒▒██▒  ██▒▓██▒  ▓  ██▒ ▓▒▒██▒  ██▒ ██  ▓██▒     ▓██▒    ▒██▒  ██▒▓██▒    
-- ▓██  █▒░▒██░  ██▒▒██░  ▒ ▓██░ ▒░▒██░  ██▒▓██  ▒██░     ▒██░    ▒██░  ██▒▒██░    
--  ▒██ █░░▒██   ██░▒██░  ░ ▓██▓ ░ ▒██   ██░▓▓█  ░██░     ▒██░    ▒██   ██░▒██░    
--   ▒▀█░  ░ ████▓▒░░██████▒▒██▒ ░ ░ ████▓▒░▒▒█████▓  ██▓ ░██████▒░ ████▓▒░░██████▒
--   ░ ▐░  ░ ▒░▒░▒░ ░ ▒░▓  ░▒ ░░   ░ ▒░▒░▒░ ░▒▓▒ ▒ ▒  ▒▓▒ ░ ▒░▓  ░░ ▒░▒░▒░ ░ ▒░▓  ░
--   ░ ░░    ░ ▒ ▒░ ░ ░ ▒  ░  ░      ░ ▒ ▒░ ░░▒░ ░ ░  ░▒  ░ ░ ▒  ░  ░ ▒ ▒░ ░ ░ ▒  ░
--     ░░  ░ ░ ░ ▒    ░ ░   ░      ░ ░ ░ ▒   ░░░ ░ ░  ░     ░ ░   ░ ░ ░ ▒    ░ ░   
--      ░      ░ ░      ░  ░           ░ ░     ░       ░      ░  ░    ░ ░      ░  ░
--     ░                                               ░                           
--
