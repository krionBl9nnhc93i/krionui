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
    assert(type(menu) == "string", "Menu adı string olmalı")
    assert(type(section) == "string", "Section adı string olmalı")
    assert(type(options) == "table", "Options bir tablo olmalı")
    
    local sec = getSection(menu, section)
    local selector = sec:addSelector({
        text = label,
        options = options,
        default = defaultIdx or 1
    }, function(idx)
        if cb then
            local success, err = pcall(function()
                cb(idx, options[idx])
            end)
            if not success then
                warn("Selector callback hatası:", err)
            end
        end
    end)
    
    -- get() and set() method
    function selector:get()
        return self.selected or defaultIdx or 1, options[self.selected or defaultIdx or 1]
    end
    
    function selector:set(idx)
        if type(idx) == "number" and idx >= 1 and idx <= #options then
            self.selected = idx
            if self._set then
                local success, err = pcall(function()
                    self:_set(idx)
                end)
                if not success then
                    warn("Selector set hatası:", err)
                end
            end
            -- Callback'i çağır
            if cb then
                local success, err = pcall(function()
                    cb(idx, options[idx])
                end)
                if not success then
                    warn("Selector callback hatası:", err)
                end
            end
        end
    end
    
    return selector
end

return ui
