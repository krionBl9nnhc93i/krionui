-- krion api
-- i cum this api cuz works sexy !!11!1!1 :)

local libraryLoader = loadstring(game:HttpGet('https://raw.githubusercontent.com/krionBl9nnhc93i/krionui/main/library.lua'))()

local core = libraryLoader({
    theme = 'grape',
    rounding = true,
    smoothDragging = true,
})

local ui = {}

-- window
local window = core.newWindow({
    text = 'Krion UI',
    resize = true,
    size = Vector2.new(550, 376),
})

local menus = {}
local sections = {}

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

-- button
function ui:Button(menuName, sectionName, text, callback)
    local section = getSection(menuName, sectionName)
    section:addButton({text = text}, callback)
end

-- toggle
function ui:Toggle(menuName, sectionName, text, callback)
    local section = getSection(menuName, sectionName)
    local toggle = section:addToggle({text = text})
    toggle:bindToEvent('onToggle', callback)
    return toggle
end

-- slider
function ui:Slider(menuName, sectionName, text, min, max, defaultValue, callback, step)
    local section = getSection(menuName, sectionName)
    local slider = section:addSlider({
        text = text,
        min = min,
        max = max,
        val = defaultValue,
        step = step or 1,
    }, callback)
    return slider
end

-- colorpicker
function ui:ColorPicker(menuName, sectionName, text, defaultColor, callback)
    local section = getSection(menuName, sectionName)
    local colorPicker = section:addColorPicker({
        text = text,
        color = defaultColor or Color3.new(1, 1, 1),
    }, callback)
    return colorPicker
end

-- textbox
function ui:Textbox(menuName, sectionName, text, callback)
    local section = getSection(menuName, sectionName)
    local textbox = section:addTextbox({text = text})
    if callback then
        textbox:bindToEvent('onFocusLost', callback)
    end
    return textbox
end

-- notify
function ui:Notify(data)
    core:notify(data)
end

-- hotkey

local UserInputService = game:GetService("UserInputService")
ui._hotkeys = {}
ui._hotkeyInputConnected = false

function ui:addHotkeyListener()
    if ui._hotkeyInputConnected then return end
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        for _, hotkey in pairs(ui._hotkeys) do
            if input.KeyCode == hotkey._key then
                for _, callback in ipairs(hotkey._callbacks) do
                    callback()
                end
            end
        end
    end)
    ui._hotkeyInputConnected = true
end

function ui:Hotkey(menuName, sectionName, text, defaultKey)
    local section = getSection(menuName, sectionName)
    local hotkey = section:addHotkey({text = text})

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

    -- hotkey listener
    table.insert(ui._hotkeys, hotkey)
    ui:addHotkeyListener()

    return hotkey
end

-- destroy
function ui:Destroy()
    if window then
        window:Destroy()
        window = nil
        menus = {}
        sections = {}
        ui._hotkeys = {}
        ui._hotkeyInputConnected = false
    end
end

return ui
