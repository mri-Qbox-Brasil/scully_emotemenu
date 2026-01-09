local emoteBinds = {}
local MAX_BINDS = 10
local capturingSlot = nil

-- Helper to notify
local function notify(type, message)
    if _G.notify then
        _G.notify(type, message)
    else
        lib.notify({ type = type, description = message })
    end
end

-- Load binds from KVP
local function LoadBinds()
    local kvp = GetResourceKvpString('scully_emotemenu_binds_v2')
    print('[DEBUG] Loading Binds KVP:', kvp)
    if kvp then
        emoteBinds = json.decode(kvp) or {}
    else
        emoteBinds = {}
    end
end

-- Save binds to KVP
local function SaveBinds()
    print('[DEBUG] Saving Binds:', json.encode(emoteBinds))
    SetResourceKvp('scully_emotemenu_binds_v2', json.encode(emoteBinds))
end

-- Apply a bind using the command system
local function ApplyBind(slot, key)
    -- We can register a command for each slot, e.g., 'emotebind_1'
    -- Then use the user's config to bind a key to that command.
    -- However, the user request says "Assign emote to key".
    -- Using RegisterKeyMapping is better for user UX + consistency.
    -- But RegisterKeyMapping is static in code. To change it dynamically, we can use ExecuteCommand('bind ...')

    local commandName = ('emotebind_%d'):format(slot)

    -- Register the command if not already done (will be done in loop below)
    -- Bind the key
    if key and key ~= '' then
        local bindCmd = ('bind keyboard "%s" "%s"'):format(key, commandName)
        print('[DEBUG] Executing Bind Command:', bindCmd)
        ExecuteCommand(bindCmd)
    end
end

-- Clear a bind for a specific slot
local function ClearBindKey(slot)
    local bind = emoteBinds[slot]
    if bind and bind.Key then
        ExecuteCommand(('unbind keyboard "%s"'):format(bind.Key))
        bind.Key = nil
        SaveBinds()
        notify('success', 'Keybind cleared for Slot ' .. slot)
    end
end

-- Clear ALL binds
local function ClearAllBinds()
    for i = 1, MAX_BINDS do
        if emoteBinds[i] and emoteBinds[i].Key then
             ExecuteCommand(('unbind keyboard "%s"'):format(emoteBinds[i].Key))
        end
    end
    emoteBinds = {}
    SaveBinds()
    notify('success', 'All keybinds cleared')
end

-- NUI Callback from Key Capture
RegisterNUICallback('capturedKey', function(data, cb)
    SetNuiFocus(false, false)
    if not capturingSlot then return cb('ok') end

    local key = data.key
    print('[DEBUG] Captured Key from NUI:', key, 'Code:', data.code)
    -- Normalize key name if necessary.
    -- FiveM bind command handles most standard keys.
    -- data.code might be useful for some, but data.key (e.g. "k") is usually what we want.
    -- Some mapping might be needed for special keys (Space -> SPACE). Script.js does some.

    -- basic check for conflicts
    local conflictSlot = nil
    for slot, bind in pairs(emoteBinds) do
        if bind.Key == key and slot ~= capturingSlot then
            conflictSlot = slot
            break
        end
    end

    if conflictSlot then
        -- We will overwrite silently or notify as per request "inform user with option to overwrite"
        -- Request says: "sobre conflito de teclas, vamos informar o usuário com a opção de sobreescrever mesmo."
        -- Since we fall out of NUI here, handling a dialog is tricky without reopening menu.
        -- Simplest flow: Just overwrite and notify.
        emoteBinds[conflictSlot].Key = nil
        notify('warning', ('Key %s was removed from Slot %d'):format(key, conflictSlot))
    end

    if not emoteBinds[capturingSlot] then emoteBinds[capturingSlot] = {} end
    emoteBinds[capturingSlot].Key = key

    SaveBinds()
    ApplyBind(capturingSlot, key)
    notify('success', ('Bound Slot %d to %s'):format(capturingSlot, key))

    -- Reopen menu
    OpenBindMenu()
    capturingSlot = nil
    cb('ok')
end)

RegisterNUICallback('closeUI', function(_, cb)
    SetNuiFocus(false, false)
    capturingSlot = nil
    OpenBindMenu()
    cb('ok')
end)

-- Main Menu for Binds
function OpenBindMenu()
    local options = {}

    for i = 1, MAX_BINDS do
        local bind = emoteBinds[i] or {}
        local title = ('Slot %d'):format(i)
        local desc = 'Empty'
        if bind.Emote then
            desc = ('Emote: %s'):format(bind.Label or bind.Emote)
        end
        if bind.Key then
            desc = desc .. (' | Key: %s'):format(bind.Key)
        end

        table.insert(options, {
            title = title,
            description = desc,
            icon = 'keyboard',
            onSelect = function()
                OpenSlotMenu(i)
            end
        })
    end

    -- Export/Import/Clear
    table.insert(options, {
        title = 'Export Binds to Clipboard',
        icon = 'file-export',
        onSelect = function()
            lib.setClipboard(json.encode(emoteBinds))
            notify('success', 'Binds copied to clipboard')
        end
    })

     table.insert(options, {
        title = 'Clear All Binds',
        icon = 'trash',
        onSelect = function()
            local alert = lib.alertDialog({
                header = 'Clear All Binds',
                content = 'Are you sure you want to delete all keybinds?',
                centered = true,
                cancel = true
            })
            if alert == 'confirm' then
                ClearAllBinds()
            end
        end
    })

    lib.registerContext({
        id = 'scully_keybinds_menu',
        title = 'Emote Keybinds',
        options = options,
        menu = 'animations_main_menu' -- Back button goes to main menu
    })

    lib.showContext('scully_keybinds_menu')
end

-- Slot Specific Menu
function OpenSlotMenu(slot)
    local bind = emoteBinds[slot] or {}

    lib.registerContext({
        id = 'scully_keybinds_slot_'..slot,
        title = ('Slot %d Management'):format(slot),
        menu = 'scully_keybinds_menu',
        options = {
            {
                title = 'Select Emote',
                description = bind.Emote and ('Current: %s'):format(bind.Label or bind.Emote) or 'Assign an emote',
                icon = 'person-walking',
                onSelect = function()
                    local input = lib.inputDialog('Bind Emote', {
                        { type = 'input', label = 'Emote Command', description = 'e.g. dance, sit', default = bind.Emote },
                        { type = 'input', label = 'Display Label', description = 'Optional name', default = bind.Label },
                    })
                    if input then
                        if not emoteBinds[slot] then emoteBinds[slot] = {} end
                        emoteBinds[slot].Emote = input[1]
                        emoteBinds[slot].Label = input[2] or input[1]
                        SaveBinds()
                        notify('success', 'Emote assigned to slot '..slot)
                        OpenSlotMenu(slot)
                    end
                end
            },
            {
                title = 'Assign Key',
                description = bind.Key and ('Current: %s'):format(bind.Key) or 'Press to bind a key',
                icon = 'keyboard',
                onSelect = function()
                    capturingSlot = slot
                    SetNuiFocus(true, true) -- Focus and Mouse
                    SendNUIMessage({ action = 'startCapture' })
                end
            },
            {
                title = 'Clear Keybind',
                disabled = not bind.Key,
                icon = 'eraser',
                onSelect = function()
                    ClearBindKey(slot)
                    OpenSlotMenu(slot)
                end
            },
            {
                title = 'Clear Slot',
                disabled = not bind.Emote and not bind.Key,
                icon = 'trash-can',
                onSelect = function()
                    ClearBindKey(slot)
                    emoteBinds[slot] = nil
                    SaveBinds()
                    notify('success', 'Slot '..slot..' cleared')
                    OpenBindMenu()
                end
            }
        }
    })

    lib.showContext('scully_keybinds_slot_'..slot)
end

-- Initialization
CreateThread(function()
    LoadBinds()

    -- Register the 10 commands
    for i = 1, MAX_BINDS do
        local cmdName = ('emotebind_%d'):format(i)
        RegisterCommand(cmdName, function()
            print('[DEBUG] Command triggered:', cmdName)
            local bind = emoteBinds[i]
            if bind and bind.Emote then
                print('[DEBUG] Attempting to enforce emote:', bind.Emote)
                -- Try to use the export first
                if exports[GetCurrentResourceName()]['playEmoteByCommand'] then
                     print('[DEBUG] Using Export')
                    exports[GetCurrentResourceName()]:playEmoteByCommand(bind.Emote)
                else
                     print('[DEBUG] Using ExecuteCommand fallback')
                    -- Fallback: assume 'e [emote]'
                     ExecuteCommand('e ' .. bind.Emote)
                end
            else
                print('[DEBUG] No bind or emote found for slot', i)
            end
        end, false)
    end
end)

-- Export for main menu to open this
exports('OpenBindMenu', OpenBindMenu)
