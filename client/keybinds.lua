local emoteBinds = {}
local MAX_BINDS = 10
local slotKeybinds = {}

local function LoadBinds()
    local kvp = GetResourceKvpString('scully_emotemenu_binds_v2')
    if kvp then
        emoteBinds = json.decode(kvp) or {}
    else
        emoteBinds = {}
    end
end

local function SaveBinds()
    SetResourceKvp('scully_emotemenu_binds_v2', json.encode(emoteBinds))
end

function OpenSlotMenu(slot)
    local bind = emoteBinds[slot] or {}
    local currentKey = slotKeybinds[slot] and slotKeybinds[slot].currentKey or '—'

    lib.registerMenu({
        id = 'scully_keybinds_slot_' .. slot,
        title = ('Slot %d'):format(slot),
        position = Config.MenuPosition,
        options = {
            {
                label = 'Select Emote',
                description = bind.Emote and ('Current: %s'):format(bind.Label or bind.Emote) or 'No emote assigned',
                icon = 'fa-solid fa-person-walking',
                args = 'selectEmote'
            },
            {
                label = ('Key: %s'):format(currentKey),
                description = 'Configure in Settings > Key Bindings > Emote Bind Slot ' .. slot,
                icon = 'fa-solid fa-keyboard',
                args = 'keyInfo',
                disabled = true
            },
            {
                label = 'Clear Slot',
                icon = 'fa-solid fa-trash-can',
                args = 'clearSlot',
                disabled = not bind.Emote
            }
        },
        onClose = function()
            OpenBindMenu()
        end
    }, function(_, _, args)
        if args == 'selectEmote' then
            local input = lib.inputDialog('Assign Emote', {
                { type = 'input', label = 'Emote Command', description = 'e.g. dance, sit', default = bind.Emote },
                { type = 'input', label = 'Display Label', description = 'Optional', default = bind.Label },
            })
            if input and input[1] and input[1] ~= '' then
                if not emoteBinds[slot] then emoteBinds[slot] = {} end
                emoteBinds[slot].Emote = input[1]
                emoteBinds[slot].Label = (input[2] and input[2] ~= '') and input[2] or input[1]
                SaveBinds()
                notify('success', 'Emote assigned to slot ' .. slot)
            end
            OpenSlotMenu(slot)
        elseif args == 'clearSlot' then
            emoteBinds[slot] = nil
            SaveBinds()
            notify('success', 'Slot ' .. slot .. ' cleared')
            OpenBindMenu()
        end
    end)

    lib.showMenu('scully_keybinds_slot_' .. slot)
end

function OpenBindMenu()
    local options = {}

    for i = 1, MAX_BINDS do
        local bind = emoteBinds[i] or {}
        local currentKey = slotKeybinds[i] and slotKeybinds[i].currentKey or '—'
        local desc

        if bind.Emote then
            desc = ('Emote: %s | Key: %s'):format(bind.Label or bind.Emote, currentKey)
        else
            desc = ('Empty | Key: %s'):format(currentKey)
        end

        options[#options + 1] = {
            label = ('Slot %d'):format(i),
            description = desc,
            icon = 'fa-solid fa-keyboard',
            args = i
        }
    end

    options[#options + 1] = {
        label = 'Export Binds to Clipboard',
        icon = 'fa-solid fa-file-export',
        args = 'export'
    }

    options[#options + 1] = {
        label = 'Clear All Binds',
        icon = 'fa-solid fa-trash',
        args = 'clearAll'
    }

    lib.registerMenu({
        id = 'scully_keybinds_menu',
        title = 'Emote Keybinds',
        position = Config.MenuPosition,
        options = options,
        onClose = function()
            lib.showMenu('animations_main_menu')
        end
    }, function(_, _, args)
        if type(args) == 'number' then
            OpenSlotMenu(args)
        elseif args == 'export' then
            lib.setClipboard(json.encode(emoteBinds))
            notify('success', 'Binds copied to clipboard')
        elseif args == 'clearAll' then
            local alert = lib.alertDialog({
                header = 'Clear All Binds',
                content = 'Are you sure you want to delete all keybinds?',
                centered = true,
                cancel = true
            })
            if alert == 'confirm' then
                emoteBinds = {}
                SaveBinds()
                notify('success', 'All keybinds cleared')
            end
            OpenBindMenu()
        end
    end)

    lib.showMenu('scully_keybinds_menu')
end

CreateThread(function()
    LoadBinds()

    for i = 1, MAX_BINDS do
        local index = i
        slotKeybinds[i] = lib.addKeybind({
            name = ('emotebind_%d'):format(i),
            description = ('Emote Bind Slot %d'):format(i),
            defaultKey = '',
            onPressed = function()
                local bind = emoteBinds[index]
                if bind and bind.Emote then
                    exports[GetCurrentResourceName()]:playEmoteByCommand(bind.Emote)
                end
            end
        })
    end
end)

exports('OpenBindMenu', OpenBindMenu)
