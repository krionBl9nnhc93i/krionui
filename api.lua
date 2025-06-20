-- krion api
-- so sexy i cum
local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/krionBl9nnhc93i/krionui/main/library.lua'))()

local ui = {}

local window = library.newWindow({
    text = 'Krion.dev',
    resize = true,
    size = Vector2.new(550, 376),
})

local menus = {}
local sections = {}

local function getMenu(name)
    if not menus[name] then
        menus[name] = window:addMenu({text = name})
        sections[name] = {}
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

function ui:Notify(data)
    library:notify(data)
end

function ui:Destroy()
    if window then
        window:Destroy()
        window = nil
        menus = {}
        sections = {}
        ui._hotkeys = nil
        ui._hotkeyInputConnected = nil
    end
end

local UserInputService = game:GetService("UserInputService")

ui._hotkeys = {}
ui._hotkeyInputConnected = false

function ui:addHotkeyListener()
    if ui._hotkeyInputConnected then return end
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        for _, hk in pairs(ui._hotkeys) do
            if input.KeyCode == hk._key then
                for _, cb in ipairs(hk._callbacks) do
                    cb()
                end
            end
        end
    end)
    ui._hotkeyInputConnected = true
end

function ui:Hotkey(menuName, sectionName, text, defaultKey)
    local section = getSection(menuName, sectionName)
    local hotkey = {}
    hotkey._key = defaultKey or Enum.KeyCode.Unknown
    hotkey._callbacks = {}

    function hotkey:setHotkey(key)
        self._key = key
    end

    function hotkey:GetHotkey()
        return self._key
    end

    function hotkey:bindToEvent(eventName, callback)
        if eventName == "onPress" then
            table.insert(self._callbacks, callback)
        end
    end

    table.insert(ui._hotkeys, hotkey)
    ui:addHotkeyListener()
    ui.coreWindow = window

    return hotkey
end

return ui
