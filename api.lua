--[[
 ██ ▄█▀ ██▀███   ██▓ ▒█████   ███▄    █      ▓█████▄ ▓█████ ██▒   █▓    ▄▄▄       ██▓███   
 ██▄█▒ ▓██ ▒ ██▒▓██▒▒██▒  ██▒ ██ ▀█   █      ▒██▀ ██▌▓█   ▀▓██░   █▒   ▒████▄    ▓██░  █▒ 
▓███▄░ ▓██ ░▄█ ▒▒██▒▒██░  ██▒▓██  ▀█ ██▒     ░██   █▌▒███   ▓██  █▒░   ▒██  ▀█▄  ▓██░▄█ ▒
▓██ █▄ ▒██▀▀█▄  ░██░▒██   ██░▓██▒  ▐▌██▒     ░▓█▄   ▌▒▓█  ▄  ▒██ █░░   ░██▄▄▄▄██ ▒██▀▀█▄  
▒██▒ █▄░██▓ ▒██▒░██░░ ████▓▒░▒██░   ▓██░ ██▓ ░▒████▓ ░▒████▒  ▒▀█░      ▓█   ▓██▒░██▓ ▒██▒
▒ ▒▒ ▓▒░ ▒▓ ░▒▓░░▓  ░ ▒░▒░▒░ ░ ▒░   ▒ ▒  ▒▓▒  ▒▒▓  ▒ ░░ ▒░ ░  ░ ▐░      ▒▒   ▓▒█░▒▓▒░ ░  ░
░ ░▒ ▒░  ░▒ ░ ▒░ ▒ ░  ░ ▒ ▒░ ░ ░░   ░ ▒░ ░▒   ░ ▒  ▒  ░ ░  ░  ░ ░░       ▒   ▒▒ ░░▒ ░      ▒ ░
░ ░░ ░   ░░   ░  ▒ ░░ ░ ░ ▒     ░   ░ ░  ░    ░ ░  ░    ░       ░░       ░   ▒   ░░        ▒ ░
░  ░      ░      ░      ░ ░           ░   ░     ░       ░  ░     ░           ░  ░          ░  
     by voltou.lol                                                          
--]]

local HttpService = game:GetService("HttpService")

local libraryLoader = loadstring(game:HttpGet('https://raw.githubusercontent.com/krionBl9nnhc93i/krionui/main/library.lua'))()
local core = libraryLoader()

local ui = {}
local window = core.newWindow({
    text = 'krion ui',
    resize = true,
    size = Vector2.new(550, 376),
})

local menus, sections = {}, {}
local config = {}

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
    local toggle = sec:addToggle({text = text, state = false}, cb)
    return toggle
end

function ui:Slider(menu, section, text, min, max, val, cb, step)
    local sec = getSection(menu, section)
    local slider = sec:addSlider({
        text = text, min = min, max = max, value = val or min, step = step or 1
    }, cb)
    return slider
end

function ui:ColorPicker(menu, section, text, def, cb)
    local sec = getSection(menu, section)
    local picker = sec:addColorPicker({
        text = text,
        color = def or Color3.new(1,1,1)
    }, cb)
    return picker
end

function ui:Textbox(menu, section, text, cb)
    local sec = getSection(menu, section)
    local box = sec:addTextbox({text = text})
    if cb then
        box:bindToEvent('onFocusLost', cb)
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

function ui:Selector(menu, section, label, options, defaultIdx, cb)
    local sec = getSection(menu, section)
    local selector = sec:addSelector({
        text = label,
        options = options,
        default = defaultIdx or 1
    }, cb)
    -- get() and set() method
    function selector:get()
        return selector.selected or defaultIdx or 1, options[selector.selected or defaultIdx or 1]
    end
    function selector:set(idx)
        if type(idx) == "number" and idx >= 1 and idx <= #options then
            selector.selected = idx
            if selector.set then
                selector:set(idx)
            end
        end
    end
    return selector
end

return ui
