<<<<<<< fork
local gameBuild, currentWalk, currentExpression = GetGameBuildNumber(), GetResourceKvpString('animations_walkstyle') or 'default', GetResourceKvpString('animations_expression') or 'default'
local isActionsLimited, isPlayingAnimation = false, false
local isRagdoll, isPointing, returnStance = false, false, false
local emoteCooldown, lastEmote, lastVariant, ptfxCanHold, otherPlayer, clone = 0, nil, nil, false, nil, nil
local playerParticles, keybinds, registeredEmotes, cloneProps = {}, {}, {}, {}
local function try_require_locale(loc)
    if not loc or loc == '' then return nil end
    local ok, res = pcall(require, 'locales.' .. loc)
    if ok and type(res) == 'table' then return res end
    return nil
end

-- Determine menu locale from server convar `ox_locale`, fallback to config then 'en'
local serverLocale = GetConvar('ox_locale', '') or ''
local chosenLocale = serverLocale ~= '' and try_require_locale(serverLocale) and serverLocale or (try_require_locale(Config.Language) and Config.Language or 'en')
local lang = try_require_locale(chosenLocale) or try_require_locale(Config.Language) or try_require_locale('en') or {}
local pedTypes = require('data.ped_types')
local pedsObjects = {}

-- Menu Options
local mainMenuOptions, emoteMenuOptions, emoteMenuBindsOptions = {
    -- Main Menu
    {label = lang.search, description = lang.search_for_animation, icon = 'fa-solid fa-magnifying-glass', args = 'animations_search'},
    {label = lang.keybinds, description = lang.create_delete_binds, icon = 'fa-solid fa-keyboard', args = 'animations_emote_binds_menu'},
    {label = lang.emote_menu, description = lang.open_emote_menu, icon = 'fa-solid fa-person', args = 'animations_emote_menu'},
    {label = lang.walking_styles, icon = 'fa-solid fa-person-walking', values = {}, args = 'Walks', close = false},
    {label = lang.scenarios, icon = 'fa-solid fa-person-walking-with-cane', values = {}, args = 'Scenarios', close = false},
    {label = lang.facial_expressions, icon = 'fa-solid fa-face-angry', values = {}, args = 'Expressions', close = false},
    {label = lang.cancel, values = {{label = lang.emote, description = lang.cancel_your_emote}, {label = lang.walk_style, description = lang.reset_walk_style}, {label = lang.expression, description = lang.reset_your_expression}, {label = lang.all, description = lang.cancel_reset_everything}}, icon = 'fa-solid fa-ban', args = 'cancel', close = false}
}, {
    -- Emote Menu
    {label = lang.emotes, icon = 'fa-solid fa-person-walking', values = {}, args = 'Emotes', close = false},
    {label = lang.prop_emotes, icon = 'fa-solid fa-person-hiking', values = {}, args = 'PropEmotes', close = false},
    {label = lang.consumable_emotes, icon = 'fa-solid fa-pizza-slice', values = {}, args = 'ConsumableEmotes', close = false},
    {label = lang.dance_emotes, icon = 'fa-solid fa-person-running', values = {}, args = 'DanceEmotes', close = false},
    {label = lang.synced_emotes, icon = 'fa-solid fa-people-carry', values = {}, args = 'SynchronizedEmotes', close = false},
    {label = lang.animal_emotes, icon = 'fa-solid fa-dog', values = {}, args = 'AnimalEmotes', close = false}
}, {
    -- Emote Bind Menu
    {label = lang.none, description = lang.new_bind, icon = 'fa-solid fa-1', args = 'animations_create_bind'},
    {label = lang.none, description = lang.new_bind, icon = 'fa-solid fa-2', args = 'animations_create_bind'},
    {label = lang.none, description = lang.new_bind, icon = 'fa-solid fa-3', args = 'animations_create_bind'},
    {label = lang.none, description = lang.new_bind, icon = 'fa-solid fa-4', args = 'animations_create_bind'},
    {label = lang.none, description = lang.new_bind, icon = 'fa-solid fa-5', args = 'animations_create_bind'}
||||||| base
local gameBuild, currentWalk, currentExpression = GetGameBuildNumber(), GetResourceKvpString('animations_walkstyle') or 'default', GetResourceKvpString('animations_expression') or 'default'
local emoteBinds, isActionsLimited, isPlayingAnimation = json.decode(GetResourceKvpString('animations_binds')) or {}, false, false
local isRagdoll, isPointing, returnStance = false, false, false
local emoteCooldown, lastEmote, lastVariant, ptfxCanHold, otherPlayer, clone = 0, nil, nil, false, nil, nil
local playerParticles, keybinds, registeredEmotes, cloneProps = {}, {}, {}, {}
local lang = require('locales.' .. Config.Language)
local pedTypes = require('data.ped_types')

-- Menu Options
local mainMenuOptions, emoteMenuOptions, emoteMenuBindsOptions = {
    -- Main Menu
    {label = lang.search, description = lang.search_for_animation, icon = 'fa-solid fa-magnifying-glass', args = 'animations_search'},
    {label = lang.keybinds, description = lang.create_delete_binds, icon = 'fa-solid fa-keyboard', args = 'animations_emote_binds_menu'},
    {label = lang.emote_menu, description = lang.open_emote_menu, icon = 'fa-solid fa-person', args = 'animations_emote_menu'},
    {label = lang.walking_styles, icon = 'fa-solid fa-person-walking', values = {}, args = 'Walks', close = false},
    {label = lang.scenarios, icon = 'fa-solid fa-person-walking-with-cane', values = {}, args = 'Scenarios', close = false},
    {label = lang.facial_expressions, icon = 'fa-solid fa-face-angry', values = {}, args = 'Expressions', close = false},
    {label = lang.cancel, values = {{label = lang.emote, description = lang.cancel_your_emote}, {label = lang.walk_style, description = lang.reset_walk_style}, {label = lang.expression, description = lang.reset_your_expression}, {label = lang.all, description = lang.cancel_reset_everything}}, icon = 'fa-solid fa-ban', args = 'cancel', close = false}
}, {
    -- Emote Menu
    {label = lang.emotes, icon = 'fa-solid fa-person-walking', values = {}, args = 'Emotes', close = false},
    {label = lang.prop_emotes, icon = 'fa-solid fa-person-hiking', values = {}, args = 'PropEmotes', close = false},
    {label = lang.consumable_emotes, icon = 'fa-solid fa-pizza-slice', values = {}, args = 'ConsumableEmotes', close = false},
    {label = lang.dance_emotes, icon = 'fa-solid fa-person-running', values = {}, args = 'DanceEmotes', close = false},
    {label = lang.synced_emotes, icon = 'fa-solid fa-people-carry', values = {}, args = 'SynchronizedEmotes', close = false},
    {label = lang.animal_emotes, icon = 'fa-solid fa-dog', values = {}, args = 'AnimalEmotes', close = false}
}, {
    -- Emote Bind Menu
    {label = lang.none, description = lang.new_bind, icon = 'fa-solid fa-1', args = 'animations_create_bind'},
    {label = lang.none, description = lang.new_bind, icon = 'fa-solid fa-2', args = 'animations_create_bind'},
    {label = lang.none, description = lang.new_bind, icon = 'fa-solid fa-3', args = 'animations_create_bind'},
    {label = lang.none, description = lang.new_bind, icon = 'fa-solid fa-4', args = 'animations_create_bind'},
    {label = lang.none, description = lang.new_bind, icon = 'fa-solid fa-5', args = 'animations_create_bind'}
=======
KVP = require 'client.modules.kvp'
Utils = require 'shared.modules.utils'
Config = lib.load('shared.data.config')
Walks = lib.load('shared.data.walks')
Scenarios = lib.load('shared.data.scenarios')
Expressions = lib.load('shared.data.expressions')
Emotes = {
    lib.load('shared.data.emotes.general_emotes'),
    lib.load('shared.data.emotes.prop_emotes'),
    lib.load('shared.data.emotes.consumable_emotes'),
    lib.load('shared.data.emotes.dance_emotes'),
    lib.load('shared.data.emotes.synchronized_emotes'),
    lib.load('shared.data.emotes.synchronized_dance_emotes'),
    lib.load('shared.data.emotes.animal_emotes')
>>>>>>> upstream
}
ExitEmotes = lib.load('shared.data.emotes.exit_emotes')

EmoteBinds = KVP.getTable('keybinds')
PlayerState = LocalPlayer.state

local pedTypes = lib.load('client.data.ped_types')
local scenarioModels = lib.load('client.data.scenario_models')
local placement = require 'client.modules.placement'
local keybinds = {}
local registeredEmotes = {}
local pedProps = {}
local pedPtfx = {}

<<<<<<< fork
-- Import customs animations
for _type, emoteList in pairs(custom) do
    for i = 1, #emoteList do
        AnimationList[_type][#AnimationList[_type] + 1] = emoteList[i]
    end
end

-- Mark base entries as English by default so we can filter menu language later
for _type, list in pairs(AnimationList) do
    for i = 1, #list do
        local e = list[i]
        if e and not e.__locale then e.__locale = 'en' end
    end
end

-- Load Portuguese translations as aliases (commands in pt-br) so both english and
-- portuguese commands work. Matching is done by unique resource keys (Walk,
-- Scenario, Expression or Animation+Dictionary).
local function shallowCopy(t)
    local out = {}
    for k, v in pairs(t) do out[k] = v end
    return out
end

local translationMapping = {
    Walks = { file = 'walks_pt-br', keys = { 'Walk' } },
    Scenarios = { file = 'scenarios_pt-br', keys = { 'Scenario' } },
    Expressions = { file = 'expressions_pt-br', keys = { 'Expression' } },
    Emotes = { file = 'emotes_pt-br', keys = { 'Animation', 'Dictionary' } },
    PropEmotes = { file = 'prop_emotes_pt-br', keys = { 'Animation', 'Dictionary' } },
    ConsumableEmotes = { file = 'consumable_emotes_pt-br', keys = { 'Animation', 'Dictionary' } },
    DanceEmotes = { file = 'dance_emotes_pt-br', keys = { 'Animation', 'Dictionary' } },
    SynchronizedEmotes = { file = 'synchronized_emotes_pt-br', keys = { 'Animation', 'Dictionary' } },
    AnimalEmotes = { file = 'animal_emotes_pt-br', keys = { 'Animation', 'Dictionary' } },
}

local function entriesMatch(keys, a, b)
    for i = 1, #keys do
        local k = keys[i]
        if not a[k] or not b[k] or a[k] ~= b[k] then return false end
    end
    return true
end

for _type, info in pairs(translationMapping) do
    local ok, transList = pcall(require, 'data.animations.' .. info.file)
    if ok and type(transList) == 'table' then
        for i = 1, #transList do
            local trans = transList[i]
            if trans and trans.Command then
                local exists = false
                for j = 1, #AnimationList[_type] do
                    if AnimationList[_type][j].Command == trans.Command then
                        exists = true
                        break
                    end
                end

                if not exists then
                    local found = nil
                    for j = 1, #AnimationList[_type] do
                        local orig = AnimationList[_type][j]
                        if entriesMatch(info.keys, trans, orig) then
                            found = orig
                            break
                        end
                    end

                    if found then
                        local alias = shallowCopy(found)
                        alias.Command = trans.Command
                        alias.Label = trans.Label or alias.Label
                        -- mark alias with locale derived from filename (e.g. 'pt-br')
                        local locale = info.file:match('_([%w%-]+)$') or 'pt-br'
                        alias.__locale = locale
                        AnimationList[_type][#AnimationList[_type] + 1] = alias
                    end
                end
            end
        end
    end
end

-- Find if there is a translation for a given entry in the desired locale
local function has_translation(_type, entry, locale)
    if not entry or not locale or locale == 'en' then return false end
    local info = translationMapping[_type]
    if not info then return false end
    for i = 1, #AnimationList[_type] do
        local candidate = AnimationList[_type][i]
        if candidate and candidate.__locale == locale and entriesMatch(info.keys, entry, candidate) then
            return true
        end
    end
    return false
end

local function should_show_entry(entry, _type)
    if not entry then return false end
    local entryLocale = entry.__locale or 'en'
    if entryLocale == chosenLocale then return true end
    -- if no translation exists for this entry in chosenLocale, show the English entry
    if entryLocale == 'en' and not has_translation(_type, entry, chosenLocale) then return true end
    return false
end

-- Functions
---Closes the animation menu
function closeMenu()
    local currentMenu = lib.getOpenMenu()
    if currentMenu ~= 'animations_main_menu' and currentMenu ~= 'animations_emote_menu' then return end

    lib.hideMenu()
end
exports('closeMenu', closeMenu)

---Toggles the animation menu
function toggleMenu()
    local currentMenu = lib.getOpenMenu()

    if not currentMenu then
        lib.showMenu('animations_main_menu')
    else
        closeMenu()
    end
end
exports('toggleMenu', toggleMenu)

---Opens list of emotes
---@param _type string
function listEmotes(_type)
    local emotes = AnimationList[_type]

    if not emotes then emotes = AnimationList.Emotes end

    local emoteCount, emoteTable = #emotes, {}

    for i = 1, emoteCount do
        local emote = emotes[i]

        if emote and emote.Label and emote.Command and should_show_entry(emote, _type) then
            emoteTable[#emoteTable + 1] = '- ' .. emote.Label .. ' - ' .. emote.Command
        end
    end

    local content = table.concat(emoteTable, '\n')

    lib.alertDialog({
        header = lang.emote_list,
        content = content,
        centered = true,
        size = 'lg',
        overflow = true,
        labels = {cancel = '', confirm = lang.close}
    })
end
exports('listEmotes', listEmotes)

---Toggle player limitations
---@param limited boolean
function setLimitation(limited)
    isActionsLimited = limited
end
exports('setLimitation', setLimitation)

---Check if the player is currently limited
||||||| base
-- Import customs animations
for _type, emoteList in pairs(custom) do
    for i = 1, #emoteList do
        AnimationList[_type][#AnimationList[_type] + 1] = emoteList[i]
    end
end

-- Functions
---Closes the animation menu
function closeMenu()
    local currentMenu = lib.getOpenMenu()
    if currentMenu ~= 'animations_main_menu' and currentMenu ~= 'animations_emote_menu' then return end

    lib.hideMenu()
end
exports('closeMenu', closeMenu)

---Toggles the animation menu
function toggleMenu()
    local currentMenu = lib.getOpenMenu()

    if not currentMenu then
        lib.showMenu('animations_main_menu')
    else
        closeMenu()
    end
end
exports('toggleMenu', toggleMenu)

---Opens list of emotes
---@param _type string
function listEmotes(_type)
    local emotes = AnimationList[_type]

    if not emotes then emotes = AnimationList.Emotes end

    local emoteCount, emoteTable = #emotes, {}

    for i = 1, emoteCount do
        local emote = emotes[i]

        if emote and emote.Label and emote.Command then
            emoteTable[#emoteTable + 1] = '- ' .. emote.Label .. ' - ' .. emote.Command
        end
    end

    local content = table.concat(emoteTable, '\n')

    lib.alertDialog({
        header = lang.emote_list,
        content = content,
        centered = true,
        size = 'lg',
        overflow = true,
        labels = {cancel = '', confirm = lang.close}
    })
end
exports('listEmotes', listEmotes)

---Toggle player limitations
---@param limited boolean
function setLimitation(limited)
    isActionsLimited = limited
end
exports('setLimitation', setLimitation)

---Check if the player is currently limited
=======
---Check if the player is in an emote
>>>>>>> upstream
---@return boolean
function IsInEmote()
    return PlayerState.isInEmote
end
<<<<<<< fork
exports('isLimited', isLimited)

---Remove multiple entries from a table
---@param _table table
---@param keep function
function removeFromTable(_table, keep)
    local _index = 1

    for i = 1, #_table do
        if keep(_table, i) then
            if i ~= _index then
                _table[_index] = _table[i]
                _table[i] = nil
            end
            _index += 1
        else
            _table[i] = nil
        end
    end

    return _table
end

---Display a notification
---@param _type string
---@param message string
function notify(_type, message)
    lib.notify({
        description = message,
        position = Config.NotificationPosition,
        duration = 2500,
        style = {
            backgroundColor = '#141517',
            color = '#d6d6d6'
        },
        icon = _type == 'error' and 'ban' or 'circle-exclamation',
        iconColor = _type == 'error' and '#D30000' or '#2ea4f7'
    })
end
exports('customNotifyFn', function(fn) if fn then notify = fn end end)

---Displays a text UI
---@param icon? string
---@param text string
function showHelpAlert(icon, text)
    lib.showTextUI(text, {
        position = Config.HelpAlertPosition,
        icon = icon,
        style = {
            borderRadius = 0,
            backgroundColor = '#141517',
            color = 'white'
        }
    })
end
exports('customHelpAlertFn', function(fn) if fn then showHelpAlert = fn end end)

---Register emotes to be used within external resources
---@param emote table
function registerEmote(emote)
    registeredEmotes[emote.Name] = emote
end
exports('registerEmote', registerEmote)

---Play a registered emote
---@param emote string
function playRegisteredEmote(emote)
    local registeredEmote = registeredEmotes[emote]

    if not registeredEmote then
        notify('error', lang.not_valid_registered_emote)
        return
    end

    if registeredEmote.Type == 'Walks' then
        setWalk(registeredEmote.Walk)
    else
        playEmote(registeredEmote, registeredEmote.Variant)
    end
end
exports('playRegisteredEmote', playRegisteredEmote)

---Remove emotes from the menu
---@param _type string
function removeEmotes(_type)
    local checkMenus = {
        'Walks',
        'Scenarios',
        'Expressions',
        'Emotes',
        'PropEmotes',
        'ConsumableEmotes',
        'DanceEmotes',
        'SynchronizedEmotes',
        'AnimalEmotes'
    }

    for i = 1, #checkMenus do
        AnimationList[checkMenus[i]] = removeFromTable(AnimationList[checkMenus[i]], function(_table, _index)
            return not _table[_index][_type]
        end)
    end
end

---Add emotes to the menu
---@param _type string
---@param command string
function addEmotesToMenu(_type, command)
    for option = 1, #mainMenuOptions do
        if mainMenuOptions[option].args == _type then
            for emote = 1, #AnimationList[_type] do
                local _emote = AnimationList[_type][emote]

                if _emote and _emote.Label and not _emote.Hide and should_show_entry(_emote, _type) then
                    mainMenuOptions[option].values[#mainMenuOptions[option].values + 1] = {label = _emote.Label, description = ('%s %s'):format(command, _emote.Command)}
                end
            end

            break
        end
    end

    for option = 1, #emoteMenuOptions do
        if emoteMenuOptions[option].args == _type then
            for emote = 1, #AnimationList[_type] do
                local _emote = AnimationList[_type][emote]

                if _emote and _emote.Label and not _emote.Hide and should_show_entry(_emote, _type) then
                    emoteMenuOptions[option].values[#emoteMenuOptions[option].values + 1] = {label = _emote.Label, description = ('%s %s'):format(command, _emote.Command)}
                end
            end

            break
        end
    end
end

---Add emotes to the radial menu
---@param _type string
---@param id string
---@param icon string
---@param cancel RadialItem
function addEmotesToRadial(_type, id, icon, cancel)
    local options = {{
        label = lang.emote_list,
        icon = 'list',
        onSelect = function()
            listEmotes(_type)
        end
    }, cancel}

    for i = 1, #AnimationList[_type] do
        local emote = AnimationList[_type][i]
        if emote and emote.Label and not emote.Hide and should_show_entry(emote, _type) then
            options[#options + 1] = {
                label = emote.Label,
                icon = icon,
                onSelect = function()
                    if isActionsLimited then return end

                    if _type == 'Walks' then
                        setWalk(emote.Walk)
                    else
                        playEmote(emote)
                    end
                end
            }
        end
    end

    lib.registerRadial({
        id = id,
        items = options
    })
end

---Get an emote based on the command
---@param name string
---@return string? _type Emote type
---@return table? _emote Emote table
function getEmoteByCommand(name)
    local _type, _emote, checkMenus = nil, nil, {
        'Walks',
        'Scenarios',
        'Expressions',
        'Emotes',
        'PropEmotes',
        'ConsumableEmotes',
        'DanceEmotes',
        'SynchronizedEmotes',
        'AnimalEmotes'
    }

    for i = 1, #checkMenus do
        local animType = checkMenus[i]
        local animList = AnimationList[animType]

        for emote = 1, #animList do
            if animList[emote] and (animList[emote].Command == name) then
                _type, _emote = animType, animList[emote]
                break
            end
        end
    end

    return _type, _emote
end

---Check if the player is in an animation
---@return boolean
function isInEmote()
    return isPlayingAnimation
end
exports('isInEmote', isInEmote)
||||||| base
exports('isLimited', isLimited)

---Remove multiple entries from a table
---@param _table table
---@param keep function
function removeFromTable(_table, keep)
    local _index = 1

    for i = 1, #_table do
        if keep(_table, i) then
            if i ~= _index then
                _table[_index] = _table[i]
                _table[i] = nil
            end
            _index += 1
        else
            _table[i] = nil
        end
    end

    return _table
end

---Display a notification
---@param _type string
---@param message string
function notify(_type, message)
    lib.notify({
        description = message,
        position = Config.NotificationPosition,
        duration = 2500,
        style = {
            backgroundColor = '#141517',
            color = '#d6d6d6'
        },
        icon = _type == 'error' and 'ban' or 'circle-exclamation',
        iconColor = _type == 'error' and '#D30000' or '#2ea4f7'
    })
end
exports('customNotifyFn', function(fn) if fn then notify = fn end end)

---Displays a text UI
---@param icon? string
---@param text string
function showHelpAlert(icon, text)
    lib.showTextUI(text, {
        position = Config.HelpAlertPosition,
        icon = icon,
        style = {
            borderRadius = 0,
            backgroundColor = '#141517',
            color = 'white'
        }
    })
end
exports('customHelpAlertFn', function(fn) if fn then showHelpAlert = fn end end)

---Register emotes to be used within external resources
---@param emote table
function registerEmote(emote)
    registeredEmotes[emote.Name] = emote
end
exports('registerEmote', registerEmote)

---Play a registered emote
---@param emote string
function playRegisteredEmote(emote)
    local registeredEmote = registeredEmotes[emote]

    if not registeredEmote then
        notify('error', lang.not_valid_registered_emote)
        return
    end

    if registeredEmote.Type == 'Walks' then
        setWalk(registeredEmote.Walk)
    else
        playEmote(registeredEmote, registeredEmote.Variant)
    end
end
exports('playRegisteredEmote', playRegisteredEmote)

---Remove emotes from the menu
---@param _type string
function removeEmotes(_type)
    local checkMenus = {
        'Walks',
        'Scenarios',
        'Expressions',
        'Emotes',
        'PropEmotes',
        'ConsumableEmotes',
        'DanceEmotes',
        'SynchronizedEmotes',
        'AnimalEmotes'
    }

    for i = 1, #checkMenus do
        AnimationList[checkMenus[i]] = removeFromTable(AnimationList[checkMenus[i]], function(_table, _index)
            return not _table[_index][_type]
        end)
    end
end

---Add emotes to the menu
---@param _type string
---@param command string
function addEmotesToMenu(_type, command)
    for option = 1, #mainMenuOptions do
        if mainMenuOptions[option].args == _type then
            for emote = 1, #AnimationList[_type] do
                local _emote = AnimationList[_type][emote]

                if _emote and _emote.Label and not _emote.Hide then
                    mainMenuOptions[option].values[#mainMenuOptions[option].values + 1] = {label = _emote.Label, description = ('%s %s'):format(command, _emote.Command)}
                end
            end

            break
        end
    end

    for option = 1, #emoteMenuOptions do
        if emoteMenuOptions[option].args == _type then
            for emote = 1, #AnimationList[_type] do
                local _emote = AnimationList[_type][emote]

                if _emote and _emote.Label and not _emote.Hide then
                    emoteMenuOptions[option].values[#emoteMenuOptions[option].values + 1] = {label = _emote.Label, description = ('%s %s'):format(command, _emote.Command)}
                end
            end

            break
        end
    end
end

---Add emotes to the radial menu
---@param _type string
---@param id string
---@param icon string
---@param cancel RadialItem
function addEmotesToRadial(_type, id, icon, cancel)
    local options = {{
        label = lang.emote_list,
        icon = 'list',
        onSelect = function()
            listEmotes(_type)
        end
    }, cancel}

    for i = 1, #AnimationList[_type] do
        local emote = AnimationList[_type][i]

        if emote and emote.Label and not emote.Hide then
            options[#options + 1] = {
                label = emote.Label,
                icon = icon,
                onSelect = function()
                    if isActionsLimited then return end

                    if _type == 'Walks' then
                        setWalk(emote.Walk)
                    else
                        playEmote(emote)
                    end
                end
            }
        end
    end

    lib.registerRadial({
        id = id,
        items = options
    })
end

---Get an emote based on the command
---@param name string
---@return string? _type Emote type
---@return table? _emote Emote table
function getEmoteByCommand(name)
    local _type, _emote, checkMenus = nil, nil, {
        'Walks',
        'Scenarios',
        'Expressions',
        'Emotes',
        'PropEmotes',
        'ConsumableEmotes',
        'DanceEmotes',
        'SynchronizedEmotes',
        'AnimalEmotes'
    }

    for i = 1, #checkMenus do
        local animType = checkMenus[i]
        local animList = AnimationList[animType]

        for emote = 1, #animList do
            if animList[emote] and (animList[emote].Command == name) then
                _type, _emote = animType, animList[emote]
                break
            end
        end
    end

    return _type, _emote
end

---Check if the player is in an animation
---@return boolean
function isInEmote()
    return isPlayingAnimation
end
exports('isInEmote', isInEmote)
=======
exports('isInEmote', IsInEmote)
>>>>>>> upstream

---Get the last emote a player used
---@return table?, number?
function GetLastEmote()
    if not PlayerState.lastEmote then return end

    return PlayerState.lastEmote[1], PlayerState.lastEmote[2]
end
exports('getLastEmote', GetLastEmote)

<<<<<<< fork
function requestSynchronizedEmote(senderData)
    local playerPos = GetEntityCoords(cache.ped)
    local targetId = lib.getClosestPlayer(playerPos, 3.0, false)

    if not targetId then
        notify('error', lang.no_player_nearby)
        return
    end

    local _type, emote = getEmoteByCommand(senderData.Options.Shared.OtherAnimation)

    if _type ~= 'SynchronizedEmotes' then
        notify('error', lang.not_valid_synced_emote)
        return
    end

    TriggerServerEvent('scully_emotemenu:requestSynchronizedEmote', GetPlayerServerId(targetId), senderData, emote)
end

---Play an emote by command
---@param command string
---@param variant? number
function playEmoteByCommand(command, variant, ped)
    local _type, emote = getEmoteByCommand(command)

    if not _type or _type == 'Walks' then
        notify('error', lang.not_valid_emote)
        return
    end

    if _type == 'SynchronizedEmotes' then
        requestSynchronizedEmote(emote)
        return
    end

    playEmote(emote --[[@as table]], variant, ped)
end
exports('playEmoteByCommand', playEmoteByCommand)

---Play an animation
||||||| base
function requestSynchronizedEmote(senderData)
    local playerPos = GetEntityCoords(cache.ped)
    local targetId = lib.getClosestPlayer(playerPos, 3.0, false)

    if not targetId then
        notify('error', lang.no_player_nearby)
        return
    end

    local _type, emote = getEmoteByCommand(senderData.Options.Shared.OtherAnimation)

    if _type ~= 'SynchronizedEmotes' then
        notify('error', lang.not_valid_synced_emote)
        return
    end

    TriggerServerEvent('scully_emotemenu:requestSynchronizedEmote', GetPlayerServerId(targetId), senderData, emote)
end

---Play an emote by command
---@param command string
---@param variant? number
function playEmoteByCommand(command, variant)
    local _type, emote = getEmoteByCommand(command)

    if not _type or _type == 'Walks' then
        notify('error', lang.not_valid_emote)
        return
    end

    if _type == 'SynchronizedEmotes' then
        requestSynchronizedEmote(emote)
        return
    end

    playEmote(emote --[[@as table]], variant)
end
exports('playEmoteByCommand', playEmoteByCommand)

---Play an animation
=======
---Play an emote or scenario
>>>>>>> upstream
---@param data table
---@param variation? number
<<<<<<< fork
function playEmote(data, variation, ped)
    if data.PedTypes then
        if IsPedHuman(ped and ped or cache.ped) then
            notify('error', lang.not_valid_ped)
||||||| base
function playEmote(data, variation)
    if data.PedTypes then
        if IsPedHuman(cache.ped) then
            notify('error', lang.not_valid_ped)
=======
function PlayEmote(data, variation)
    if PlayerState.isLimited then return end

    if data.CanGroupEmote and IsControlPressed(0, 47) and not data.StartGroupEmote then
        TriggerServerEvent('scully_emotemenu:requestGroupEmote', data)
    elseif data.Synchronized and not data.StartSynchronized then
        local coords = GetEntityCoords(cache.ped)
        local targetId = lib.getClosestPlayer(coords, 3.0, false)

        if not targetId then
            Utils.notify('error', locale('no_players_nearby'))
>>>>>>> upstream
            return
        end

<<<<<<< fork
        local validPed = false
        local playerModel = GetEntityModel(ped and ped or cache.ped)
||||||| base
        local validPed = false
        local playerModel = GetEntityModel(cache.ped)
=======
        local otherEmote

        for i = 1, #Emotes do
            local emotes = Emotes[i]

            for k = 1, #emotes.options do
                local emote = emotes.options[k]

                if emote.Command == data.Options.Shared.OtherEmote then
                    otherEmote = emote
                    break
                end
            end

            if otherEmote then break end
        end

        if not otherEmote then
            Utils.notify('error', locale('not_valid_emote'))
            return
        end

        TriggerServerEvent('scully_emotemenu:requestSynchronizedEmote', GetPlayerServerId(targetId), data, otherEmote)
        return
    end

    if data.PedTypes then
        if IsPedHuman(cache.ped) then
            Utils.notify('error', locale('not_valid_ped'))
            return
        end

        local isValid = false
        local model = GetEntityModel(cache.ped)
>>>>>>> upstream

        for i = 1, #data.PedTypes do
            local allowed = pedTypes[data.PedTypes[i]]
            local found = lib.table.contains(allowed, model)

            if found then
                isValid = true
                break
            end
        end

        if not isValid then
            Utils.notify('error', locale('not_valid_ped'))
            return
        end
    end

    if not data.PedTypes and not IsPedHuman(ped and ped or cache.ped) then
        Utils.notify('error', locale('not_valid_ped'))
        return
    end

    if Config.enableWeaponBlock and IsPedArmed(cache.ped, 7) then
        Utils.notify('error', locale('not_with_weapon'))
        return
    end

<<<<<<< fork
    if Config.EnableWeaponBlock and IsPedArmed(ped and ped or cache.ped, 7) then
        notify('error', lang.not_with_weapon)
        return
    end

    if Config.EnableAimShootBlock then
||||||| base
    if Config.EnableWeaponBlock and IsPedArmed(cache.ped, 7) then
        notify('error', lang.not_with_weapon)
        return
    end

    if Config.EnableAimShootBlock then
=======
    if Config.enableAimShootBlock then
>>>>>>> upstream
        CreateThread(function()
<<<<<<< fork
            while isPlayingAnimation and not IsPedRagdoll(cache.ped) and not ped do
||||||| base
            while isPlayingAnimation and not IsPedRagdoll(cache.ped) do
=======
            while PlayerState.isInEmote do
>>>>>>> upstream
                Wait(0)

                DisableControlAction(0, 25, true)
                DisablePlayerFiring(cache.playerId, true)
            end

            CancelEmote()
        end)
    end

    local duration, movementFlag = nil, cache.vehicle and 51 or 0

    if not Config.enableEmotesInVehicles and cache.vehicle and not ped then
        Utils.notify('error', locale('not_in_vehicle'))
        return
    end

    local gameTimer = GetGameTimer()
    local emoteCooldown = PlayerState.emoteCooldown

    if emoteCooldown and ((gameTimer - emoteCooldown) < Config.emoteCooldown) and not ped then return end

    PlayerState:set('emoteCooldown', gameTimer, true)
    PlayerState:set('emoteProps', nil, true)
    PlayerState:set('emotePtfx', false, true)

    if data.Scenario then
<<<<<<< fork
        if cache.vehicle and not ped then
            notify('error', lang.no_scenarios_in_vehicle)
            return
        end

        ClearPedTasks(ped and ped or cache.ped)
        TaskStartScenarioInPlace(ped and ped or cache.ped, data.Scenario, 0, true)

        isPlayingAnimation = ped and false or true
||||||| base
        if cache.vehicle then
            notify('error', lang.no_scenarios_in_vehicle)
            return
        end

        ClearPedTasks(cache.ped)
        TaskStartScenarioInPlace(cache.ped, data.Scenario, 0, true)

        isPlayingAnimation = true
=======
        PlayScenario(data.Scenario)
>>>>>>> upstream
        return
    end

    if Config.enableEmotePlacement and data.Placement and not data.Advanced then
        lib.hideMenu()
        placement.start(data)
        return
    end

    local dictionaryName, animationName = data.Dictionary, data.Animation

    if type(dictionaryName) == 'table' and type(animationName) == 'table' then
        local randomIndex = math.random(1, #animationName)

        dictionaryName = dictionaryName[randomIndex]
        animationName = animationName[randomIndex]
    end

    local isValid = lib.requestAnimDict(dictionaryName)

    if not isValid then
        Utils.notify('error', locale('not_valid_emote'))
        return
    end

    if data.NSFW and Config.enableNSFWEmotes == 'limited' and not PlayerState.allowNSFWEmotes then
        Utils.notify('error', locale('nsfw_limited'))
        return
    end

    local options = data.Options

    if options then
        duration = options.Duration

        if options.Delay then Wait(options.Delay) end

        if (not cache.vehicle or ped) and options.Flags then
            movementFlag = options.Flags.Stuck and 50 or options.Flags.Move and 51 or options.Flags.Loop and 1 or movementFlag

            if options.Flags.Loop and not ped then
                PlayerState.lastEmote = { data, variation }
            end
        end

        if options.Props then
            local props = {}

            for i = 1, #options.Props do
                local prop = options.Props[i]
                
                if variation then
                    if prop.Variations and prop.Variations[variation] then
                        prop.Variant = prop.Variations[variation]
                    end
                end

                props[i] = {
                    name = prop.Name,
                    hash = joaat(prop.Name),
                    bone = prop.Bone,
                    placement = prop.Placement,
                    variant = prop.Variant,
                    hasPtfx = options?.Ptfx?.AttachToProp
                }
            end

            PlayerState:set('emoteProps', props, true)
        end

        local ptfx = options.Ptfx

        if ptfx then
            local hasAutomatedPtfx = Config.enableAutoPtfx and ptfx.Auto

            PlayerState:set('ptfx', {
                asset = ptfx.Asset,
                name = ptfx.Name,
                placement = ptfx.Placement,
                bone = ptfx.Bone,
                color = ptfx.Color,
                canHold = ptfx.CanHold
            }, true)

            if Config.ptfxKey and not hasAutomatedPtfx then
                keybinds.Ptfx:disable(false)
                Utils.notify('success', (locale('press_for_ptfx'):format(keybinds.Ptfx:getCurrentKey())))
            else
                keybinds.Ptfx:disable(true)

                if hasAutomatedPtfx then
                    PlayerState:set('emotePtfx', true, true)
                end
            end
        else
            if Config.ptfxKey then keybinds.Ptfx:disable(true) end
        end
    end

    if data.Advanced then
        local coords = data.Advanced.Coords

        TaskPlayAnimAdvanced(ped and ped or cache.ped, dictionaryName, animationName, coords.x, coords.y, coords.z, 0, 0, data.Advanced.Heading, 2.0, 2.0, duration or -1, movementFlag, 1.0, false, false)
    else
        TaskPlayAnim(ped and ped or cache.ped, dictionaryName, animationName, 2.0, 2.0, duration or -1, movementFlag, 0, false, false, false)
    end

    RemoveAnimDict(dictionaryName)

    isPlayingAnimation = ped and false or true
    local secondaryEmote = options?.SecondaryEmote

    if secondaryEmote then
        local isSecondaryValid = lib.requestAnimDict(secondaryEmote.Dictionary, 1000)

<<<<<<< fork
        if secondaryEmote then
            local isSecondaryValid = lib.requestAnimDict(secondaryEmote.Dictionary, 1000)

            if not isSecondaryValid then
                notify('error', lang.not_valid_emote)
                return
            end

            TaskPlayAnim(ped and ped or cache.ped, secondaryEmote.Dictionary, secondaryEmote.Animation, 2.0, 2.0, secondaryEmote.Duration or -1, 51, 0, false, false, false)
            RemoveAnimDict(secondaryEmote.Dictionary)
||||||| base
        if secondaryEmote then
            local isSecondaryValid = lib.requestAnimDict(secondaryEmote.Dictionary, 1000)

            if not isSecondaryValid then
                notify('error', lang.not_valid_emote)
                return
            end

            TaskPlayAnim(cache.ped, secondaryEmote.Dictionary, secondaryEmote.Animation, 2.0, 2.0, secondaryEmote.Duration or -1, 51, 0, false, false, false)
            RemoveAnimDict(secondaryEmote.Dictionary)
=======
        if not isSecondaryValid then
            Utils.notify('error', locale('not_valid_emote'))
            return
>>>>>>> upstream
        end

<<<<<<< fork
        local propData = data.Options.Props

        if propData then
            local propCount = #propData

            if propCount > 0 then
                Wait(duration or 0)

                local propList = {}

                for i = 1, propCount do
                    local prop = propData[i]
                    local variant = prop.Variant

                    if variation then
                        if prop.Variations and prop.Variations[variation] then
                            variant = prop.Variations[variation]
                        end
                    end

                    propList[#propList + 1] = {
                        hash = joaat(prop.Name),
                        bone = prop.Bone,
                        placement = prop.Placement,
                        variant = variant,
                        hasPTFX = i == 1 and data.Options.Ptfx and data.Options.Ptfx.AttachToProp
                    }
                end

                if ped then
                    local coords = GetEntityCoords(ped)
                    for i = 1, #propList do
                        local prop = propList[i]
                        pedsObjects[#pedsObjects + 1] = CreateObject(prop.hash, coords.x, coords.y, coords.z, false)
                        addPropToPlayer(pedsObjects[#pedsObjects], prop.bone, prop.placement, prop.variant, ped)
                    end
                return end

                local props = lib.callback.await('scully_emotemenu:spawnProps', false, propList)

                if props then
                    for i = 1, #props do
                        local prop = props[i]
                        local object = NetworkGetEntityFromNetworkId(prop.object)

                        if DoesEntityExist(object) then
                            local hasControl = lib.waitFor(function()
                                local hasControl = NetworkGetEntityOwner(object) == cache.playerId

                                if hasControl then
                                    return true
                                end

                                NetworkRequestControlOfEntity(object)
                            end, ('Failed to gain entity control of entity'), 3000)


                            if hasControl then
                                addPropToPlayer(object, prop.bone, prop.placement, prop.variant)
                            end
                        end
                    end
                end
            end
        end
||||||| base
        local propData = data.Options.Props

        if propData then
            local propCount = #propData

            if propCount > 0 then
                Wait(duration or 0)

                local propList = {}

                for i = 1, propCount do
                    local prop = propData[i]
                    local variant = prop.Variant

                    if variation then
                        if prop.Variations and prop.Variations[variation] then
                            variant = prop.Variations[variation]
                        end
                    end

                    propList[#propList + 1] = {
                        hash = joaat(prop.Name),
                        bone = prop.Bone,
                        placement = prop.Placement,
                        variant = variant,
                        hasPTFX = i == 1 and data.Options.Ptfx and data.Options.Ptfx.AttachToProp
                    }
                end

                local props = lib.callback.await('scully_emotemenu:spawnProps', false, propList)

                if props then
                    for i = 1, #props do
                        local prop = props[i]
                        local object = NetworkGetEntityFromNetworkId(prop.object)

                        if DoesEntityExist(object) then
                            local hasControl = lib.waitFor(function()
                                local hasControl = NetworkGetEntityOwner(object) == cache.playerId

                                if hasControl then
                                    return true
                                end

                                NetworkRequestControlOfEntity(object)
                            end, ('Failed to gain entity control of entity'), 3000)


                            if hasControl then
                                addPropToPlayer(object, prop.bone, prop.placement, prop.variant)
                            end
                        end
                    end
                end
            end
        end
=======
        TaskPlayAnim(cache.ped, secondaryEmote.Dictionary, secondaryEmote.Animation, 2.0, 2.0, secondaryEmote.Duration or -1, 51, 0, false, false, false)
        RemoveAnimDict(secondaryEmote.Dictionary)
>>>>>>> upstream
    end

    PlayerState:set('isInEmote', true, true)
end
exports('playEmote', PlayEmote)

---Cancel an emote or scenario
---@param skipReset? boolean
function CancelEmote(skipReset)
    if PlayerState.isInEmote and not PlayerState.isLimited then
        :: cancelEmote ::

        local isScenario = IsPedUsingAnyScenario(cache.ped)

<<<<<<< fork
    local clonePos = GetOffsetFromEntityInWorldCoords(ped and ped or cache.ped, 0.0, 4.5, 0.0)
    local cloneHeading = GetEntityHeading(ped and ped or cache.ped) + 180
||||||| base
    local clonePos = GetOffsetFromEntityInWorldCoords(cache.ped, 0.0, 4.5, 0.0)
    local cloneHeading = GetEntityHeading(cache.ped) + 180
=======
        if isScenario then SetPedShouldPlayImmediateScenarioExit(cache.ped) end
>>>>>>> upstream

<<<<<<< fork
    clone = ClonePed(ped and ped or cache.ped, false, false, true)

    SetEntityCoords(clone, clonePos.x, clonePos.y, clonePos.z, false, false, false, false)
    SetEntityHeading(clone, cloneHeading)
    SetEntityAlpha(clone, 200, false)

    Wait(200)

    local hasAutomatedPtfx, dictionaryName, animationName = false, data.Dictionary, data.Animation

    if type(dictionaryName) == 'table' and type(animationName) == 'table' then
        local randomIndex = math.random(1, #animationName)

        dictionaryName = dictionaryName[randomIndex]
        animationName = animationName[randomIndex]
    end

    local isValid = lib.requestAnimDict(dictionaryName, 1000)

    if not isValid then
        notify('error', lang.not_valid_emote)
        return
    end

    if data.Options then
        duration = data.Options.Duration

        if data.Options.Delay then Wait(data.Options.Delay) end

        if not cache.vehicle and data.Options.Flags then
            if data.Options.Flags.Loop then movementFlag = 1 end
            if data.Options.Flags.Move then movementFlag = 51 end
            if data.Options.Flags.Stuck then movementFlag = 50 end
        end

        if data.Options.Ptfx then
            -- TO-DO
        end
    end

    local cloneDuration = GetAnimDuration(dictionaryName, animationName)

    if data.Advanced then
        local coords = data.Advanced.Coords

        TaskPlayAnimAdvanced(clone, dictionaryName, animationName, coords.x, coords.y, coords.z, 0, 0, data.Advanced.Heading, 2.0, 2.0, duration or -1, movementFlag, 1.0, false, false)
    else
        TaskPlayAnim(clone, dictionaryName, animationName, 2.0, 2.0, duration or -1, movementFlag, 0, false, false, false)
    end

    RemoveAnimDict(dictionaryName)

    if data.Options then
        local secondaryEmote = data.Options.SecondaryEmote

        if secondaryEmote then
            local isSecondaryValid = lib.requestAnimDict(secondaryEmote.Dictionary, 1000)

            if not isSecondaryValid then
                notify('error', lang.not_valid_emote)
                return
            end

            TaskPlayAnim(clone, secondaryEmote.Dictionary, secondaryEmote.Animation, 2.0, 2.0, secondaryEmote.Duration or -1, 51, 0, false, false, false)
            RemoveAnimDict(secondaryEmote.Dictionary)
        end

        local propData = data.Options.Props

        if propData then
            local propCount = #propData

            if propCount > 0 then
                Wait(duration or 0)

                local propList = {}

                for i = 1, propCount do
                    local prop = propData[i]
                    local variant = prop.Variant

                    if variation then
                        if prop.Variations and prop.Variations[variation] then
                            variant = prop.Variations[variation]
                        end
                    end

                    propList[#propList + 1] = {
                        hash = joaat(prop.Name),
                        bone = prop.Bone,
                        placement = prop.Placement,
                        variant = variant
                    }
                end

                if #propList > 0 then
                    for i = 1, #propList do
                        local prop = propList[i]

                        lib.requestModel(prop.hash, 1000)

                        local object = CreateObject(prop.hash, clonePos.x, clonePos.y, clonePos.z, false, false, false)
                        SetEntityCollision(object, false, false)
                        AttachEntityToEntity(object, clone, GetPedBoneIndex(clone, prop.bone), prop.placement[1].x, prop.placement[1].y, prop.placement[1].z, prop.placement[2].x, prop.placement[2].y, prop.placement[2].z, true, true, false, true, 1, true)

                        cloneProps[#cloneProps + 1] = object

                        SetModelAsNoLongerNeeded(prop.hash)
                    end
                end
            end
        end
    end

    local endTimer = ((cloneDuration or 0) + 1) * 1000

    if endTimer > 5000 then
        endTimer = 5000
    end

    Wait(endTimer)

    for i = 1, #cloneProps do
        DeleteEntity(cloneProps[i])
    end

    cloneProps = {}

    DeleteEntity(clone)
end

---Cancel the animation you're currently playing
---@param skipReset boolean
function cancelEmote(skipReset)
    if isPlayingAnimation and not isActionsLimited then
        if IsPedUsingAnyScenario(cache.ped) then ClearPedTasksImmediately(cache.ped) end
        if LocalPlayer.state.ptfx then LocalPlayer.state:set('ptfx', false, true) end
        if Config.PtfxKeybind then keybinds.PlayPtfx:disable(true) end

        ClearPedTasks(cache.ped)
||||||| base
    clone = ClonePed(cache.ped, false, false, true)

    SetEntityCoords(clone, clonePos.x, clonePos.y, clonePos.z, false, false, false, false)
    SetEntityHeading(clone, cloneHeading)
    SetEntityAlpha(clone, 200, false)

    Wait(200)

    local hasAutomatedPtfx, dictionaryName, animationName = false, data.Dictionary, data.Animation

    if type(dictionaryName) == 'table' and type(animationName) == 'table' then
        local randomIndex = math.random(1, #animationName)

        dictionaryName = dictionaryName[randomIndex]
        animationName = animationName[randomIndex]
    end

    local isValid = lib.requestAnimDict(dictionaryName, 1000)

    if not isValid then
        notify('error', lang.not_valid_emote)
        return
    end

    if data.Options then
        duration = data.Options.Duration

        if data.Options.Delay then Wait(data.Options.Delay) end

        if not cache.vehicle and data.Options.Flags then
            if data.Options.Flags.Loop then movementFlag = 1 end
            if data.Options.Flags.Move then movementFlag = 51 end
            if data.Options.Flags.Stuck then movementFlag = 50 end
        end

        if data.Options.Ptfx then
            -- TO-DO
        end
    end

    local cloneDuration = GetAnimDuration(dictionaryName, animationName)

    if data.Advanced then
        local coords = data.Advanced.Coords

        TaskPlayAnimAdvanced(clone, dictionaryName, animationName, coords.x, coords.y, coords.z, 0, 0, data.Advanced.Heading, 2.0, 2.0, duration or -1, movementFlag, 1.0, false, false)
    else
        TaskPlayAnim(clone, dictionaryName, animationName, 2.0, 2.0, duration or -1, movementFlag, 0, false, false, false)
    end

    RemoveAnimDict(dictionaryName)

    if data.Options then
        local secondaryEmote = data.Options.SecondaryEmote

        if secondaryEmote then
            local isSecondaryValid = lib.requestAnimDict(secondaryEmote.Dictionary, 1000)

            if not isSecondaryValid then
                notify('error', lang.not_valid_emote)
                return
            end

            TaskPlayAnim(clone, secondaryEmote.Dictionary, secondaryEmote.Animation, 2.0, 2.0, secondaryEmote.Duration or -1, 51, 0, false, false, false)
            RemoveAnimDict(secondaryEmote.Dictionary)
        end

        local propData = data.Options.Props

        if propData then
            local propCount = #propData

            if propCount > 0 then
                Wait(duration or 0)

                local propList = {}

                for i = 1, propCount do
                    local prop = propData[i]
                    local variant = prop.Variant

                    if variation then
                        if prop.Variations and prop.Variations[variation] then
                            variant = prop.Variations[variation]
                        end
                    end

                    propList[#propList + 1] = {
                        hash = joaat(prop.Name),
                        bone = prop.Bone,
                        placement = prop.Placement,
                        variant = variant
                    }
                end

                if #propList > 0 then
                    for i = 1, #propList do
                        local prop = propList[i]

                        lib.requestModel(prop.hash, 1000)

                        local object = CreateObject(prop.hash, clonePos.x, clonePos.y, clonePos.z, false, false, false)
                        SetEntityCollision(object, false, false)
                        AttachEntityToEntity(object, clone, GetPedBoneIndex(clone, prop.bone), prop.placement[1].x, prop.placement[1].y, prop.placement[1].z, prop.placement[2].x, prop.placement[2].y, prop.placement[2].z, true, true, false, true, 1, true)

                        cloneProps[#cloneProps + 1] = object

                        SetModelAsNoLongerNeeded(prop.hash)
                    end
                end
            end
        end
    end

    local endTimer = ((cloneDuration or 0) + 1) * 1000

    if endTimer > 5000 then
        endTimer = 5000
    end

    Wait(endTimer)

    for i = 1, #cloneProps do
        DeleteEntity(cloneProps[i])
    end

    cloneProps = {}

    DeleteEntity(clone)
end

---Cancel the animation you're currently playing
---@param skipReset boolean
function cancelEmote(skipReset)
    if isPlayingAnimation and not isActionsLimited then
        if IsPedUsingAnyScenario(cache.ped) then ClearPedTasksImmediately(cache.ped) end
        if LocalPlayer.state.ptfx then LocalPlayer.state:set('ptfx', false, true) end
        if Config.PtfxKeybind then keybinds.PlayPtfx:disable(true) end

        ClearPedTasks(cache.ped)
=======
>>>>>>> upstream
        DetachEntity(cache.ped, true, false)
        PlayerState:set('isInEmote', false, true)
        PlayerState:set('emoteProps', nil, true)
        PlayerState:set('emotePtfx', false, true)

        if Config.ptfxKey then keybinds.Ptfx:disable(true) end

        if PlayerState.inSynchronizedEmote then
            PlayerState:set('inSynchronizedEmote', nil, true)
        end

        if isScenario then
            local coords = GetEntityCoords(cache.ped)

            for i = 1, #scenarioModels do
                local model = scenarioModels[i]
                local entity = GetClosestObjectOfType(coords.x, coords.y, coords.z, 1.0, model, false, true, true)

                if entity ~= 0 then
                    SetEntityAsMissionEntity(entity, false, true)
                    DeleteEntity(entity)
                end
            end
        end

        local exitEmoteName = PlayerState?.lastEmote?[1]?.Options?.ExitEmote

        if not skipReset then
            PlayerState.lastEmote = nil
            
            if exitEmoteName then
                local exitEmote = ExitEmotes[exitEmoteName]

                PlayEmote(exitEmote)

                if exitEmote?.Options?.Duration then
                    Wait(exitEmote.Options.Duration)
    
                    goto cancelEmote
                end
                
                return
            end
        end

        ClearPedTasks(cache.ped)
    end
end
exports('cancelEmote', CancelEmote)

---Play an emote by command
---@param command string
---@param variant? number
function PlayEmoteByCommand(command, variant)
    local found

    for i = 1, #Scenarios do
        local scenario = Scenarios[i]

        if scenario.Command == command then
            found = scenario
            break
        end
    end

    if not found then
        for i = 1, #Emotes do
            local emotes = Emotes[i]
    
            for k = 1, #emotes.options do
                local emote = emotes.options[k]
    
                if emote.Command == command then
                    found = emote
                    break
                end
            end
        end
    end

    if not found then
        Utils.notify('error', locale('not_valid_emote'))
        return
    end

    PlayEmote(found, variant)
end
exports('playEmoteByCommand', PlayEmoteByCommand)

---Get the players current walk style
---@return string?
function GetCurrentWalk()
    return PlayerState.walkstyle
end
exports('getCurrentWalk', GetCurrentWalk)

---Set the players current walk style
---@param name string
function SetWalk(name)
    lib.requestAnimSet(name, 1000)
    SetPedMovementClipset(cache.ped, name, 0.2)
    RemoveAnimSet(name)

    if Config.preventWalkStyleAbuse then
        local dict = Utils.isPedMale(cache.ped) and 'move_m@multiplayer' or 'move_f@multiplayer'

        lib.requestAnimDict(dict)
        SetPedAlternateMovementAnim(cache.ped, 2, dict, 'run', 0, true)
        RemoveAnimDict(dict)
    end

    KVP.update('walkstyle', name)
    PlayerState:set('walkstyle', name, true)
end
exports('setWalk', SetWalk)

---Reset the players walk style
function ResetWalk()
    ResetPedMovementClipset(cache.ped, 0)
    KVP.delete('walkstyle')
    PlayerState:set('walkstyle', nil, true)
end
exports('resetWalk', resetWalk)

---Set the players current walk style using the command
---@param command string
function SetWalkByCommand(command)
    local found

    for i = 1, #Walks do
        local walk = Walks[i]

        if walk.Command == command then
            found = walk
            break
        end
    end

    if not found then
        Utils.notify('error', locale('not_valid_walk'))
        return
    end

    SetWalk(found.Walk)
end
exports('setWalkByCommand', SetWalkByCommand)

<<<<<<< fork
---Attach a prop to the player
---@param object number
---@param bone number
---@param placement table
---@param variant number
function addPropToPlayer(object, bone, placement, variant, ped)
    SetEntityCollision(object, false, false)

    if variant then SetObjectTextureVariation(object, variant) end

    AttachEntityToEntity(object, ped and ped or cache.ped, GetPedBoneIndex(ped and ped or cache.ped, bone), placement[1].x, placement[1].y, placement[1].z, placement[2].x, placement[2].y, placement[2].z, true, true, false, true, 1, true)
end

---Remove unsupported emotes
function removeUnsupportedEmotes()
    local checkMenus = {
        'Walks',
        'Scenarios',
        'Expressions',
        'Emotes',
        'PropEmotes',
        'ConsumableEmotes',
        'DanceEmotes',
        'SynchronizedEmotes',
        'AnimalEmotes'
    }

    local DoesAnimDictExist = DoesAnimDictExist
    local IsModelValid = IsModelValid

    for i = 1, #checkMenus do
        if AnimationList[checkMenus[i]] then
            AnimationList[checkMenus[i]] = removeFromTable(AnimationList[checkMenus[i]], function(_table, _index)
                local animation, doesExist = _table[_index], true

                if gameBuild < 2699 then
                    if animation.Dictionary and not DoesAnimDictExist(animation.Dictionary) then doesExist = false end
                    if animation.Options and animation.Options.Props then
                        local props = animation.Options.Props
                        local propCount = #props

                        if propCount > 0 then
                            for k = 1, propCount do
                                if not IsModelValid(joaat(props[k].Name)) then
                                    doesExist = false
                                    break
                                end
                            end
                        end
                    end

                    if not doesExist then
                        print(lang.gamebuild_not_supported:format(animation.Label))
                    end
                end

                return doesExist
            end)
        end
    end
end

---Search for animations
---@param query string
function searchMenu(query)
    Wait(500)

    local checkMenus, foundEmotes = {
        'Walks',
        'Scenarios',
        'Expressions',
        'Emotes',
        'PropEmotes',
        'ConsumableEmotes',
        'DanceEmotes',
        'SynchronizedEmotes',
        'AnimalEmotes'
    }, {}

    for i = 1, #checkMenus do
        local animType = checkMenus[i]
        local animList = AnimationList[animType]

        if animList then
            for emote = 1, #animList do
                local anim = animList[emote]

                if anim and anim.Command and string.find(string.lower(anim.Command), query) then
                    anim.CommandHandle = animType == 'Walks' and Config.WalkSetCommands[1] or Config.EmotePlayCommands[1]
                    anim.Type = animType
                    foundEmotes[#foundEmotes + 1] = anim
                end
            end
        end
    end

    if #foundEmotes == 0 then
        notify('error', lang.no_animations_found)
        lib.showMenu('animations_main_menu')
||||||| base
---Attach a prop to the player
---@param object number
---@param bone number
---@param placement table
---@param variant number
function addPropToPlayer(object, bone, placement, variant)
    SetEntityCollision(object, false, false)

    if variant then SetObjectTextureVariation(object, variant) end

    AttachEntityToEntity(object, cache.ped, GetPedBoneIndex(cache.ped, bone), placement[1].x, placement[1].y, placement[1].z, placement[2].x, placement[2].y, placement[2].z, true, true, false, true, 1, true)
end

---Remove unsupported emotes
function removeUnsupportedEmotes()
    local checkMenus = {
        'Walks',
        'Scenarios',
        'Expressions',
        'Emotes',
        'PropEmotes',
        'ConsumableEmotes',
        'DanceEmotes',
        'SynchronizedEmotes',
        'AnimalEmotes'
    }

    local DoesAnimDictExist = DoesAnimDictExist
    local IsModelValid = IsModelValid

    for i = 1, #checkMenus do
        if AnimationList[checkMenus[i]] then
            AnimationList[checkMenus[i]] = removeFromTable(AnimationList[checkMenus[i]], function(_table, _index)
                local animation, doesExist = _table[_index], true

                if gameBuild < 2699 then
                    if animation.Dictionary and not DoesAnimDictExist(animation.Dictionary) then doesExist = false end
                    if animation.Options and animation.Options.Props then
                        local props = animation.Options.Props
                        local propCount = #props

                        if propCount > 0 then
                            for k = 1, propCount do
                                if not IsModelValid(joaat(props[k].Name)) then
                                    doesExist = false
                                    break
                                end
                            end
                        end
                    end

                    if not doesExist then
                        print(lang.gamebuild_not_supported:format(animation.Label))
                    end
                end

                return doesExist
            end)
        end
    end
end

---Search for animations
---@param query string
function searchMenu(query)
    Wait(500)

    local checkMenus, foundEmotes = {
        'Walks',
        'Scenarios',
        'Expressions',
        'Emotes',
        'PropEmotes',
        'ConsumableEmotes',
        'DanceEmotes',
        'SynchronizedEmotes',
        'AnimalEmotes'
    }, {}

    for i = 1, #checkMenus do
        local animType = checkMenus[i]
        local animList = AnimationList[animType]

        if animList then
            for emote = 1, #animList do
                local anim = animList[emote]

                if anim and anim.Command and string.find(string.lower(anim.Command), query) then
                    anim.CommandHandle = animType == 'Walks' and Config.WalkSetCommands[1] or Config.EmotePlayCommands[1]
                    anim.Type = animType
                    foundEmotes[#foundEmotes + 1] = anim
                end
            end
        end
    end

    if #foundEmotes == 0 then
        notify('error', lang.no_animations_found)
        lib.showMenu('animations_main_menu')
=======
---Play a scenario
---@param name string 
function PlayScenario(name)
    if cache.vehicle then
        Utils.notify('error', locale('no_scenarios_in_vehicle'))
>>>>>>> upstream
        return
    end

    ClearPedTasks(cache.ped)
    TaskStartScenarioInPlace(cache.ped, name, 0, true)
    PlayerState:set('isInEmote', true, true)
end

---Get the players current expression
---@return string
function GetCurrentExpression()
    return PlayerState.expression
end
exports('getCurrentExpression', GetCurrentExpression)

---Set the players current expression
---@param name string
function SetExpression(name)
    SetFacialIdleAnimOverride(cache.ped, name, 0)
    KVP.update('expression', name)
    PlayerState:set('expression', name, true)
end
exports('setExpression', SetExpression)

---Reset the players expression
function ResetExpression()
    ClearFacialIdleAnimOverride(cache.ped)
    KVP.delete('expression')
    PlayerState:set('expression', nil, true)
end
exports('resetExpression', ResetExpression)

---Set the players current expression using the command
---@param command string
function SetExpressionByCommand(command)
    local found

    for i = 1, #Expressions do
        local expression = Expressions[i]

        if expression.Command == command then
            found = expression
            break
        end
    end

    if not found then
        Utils.notify('error', locale('not_valid_expression'))
        return
    end

    SetExpression(found.Expression)
end
exports('setExpressionByCommand', SetExpressionByCommand)

---Register emotes to be used within external resources
---@param emote table
function RegisterEmote(emote)
    registeredEmotes[emote.Name] = emote
end
exports('registerEmote', RegisterEmote)

---Play a registered emote
---@param emote string
function PlayRegisteredEmote(emote)
    local registeredEmote = registeredEmotes[emote]

    if not registeredEmote then
        Utils.notify('error', locale('not_valid_emote'))
        return
    end

    PlayEmote(emote)
end
exports('playRegisteredEmote', PlayRegisteredEmote)

<<<<<<< fork
---Open the emote bind menu
function openBindMenu()
    exports[GetCurrentResourceName()]:OpenBindMenu()
end
||||||| base
---Open the emote bind menu
function openBindMenu()
    lib.registerMenu({
        id = 'animations_emote_binds_menu',
        title = lang.emote_menu,
        position = Config.MenuPosition,
        options = emoteMenuBindsOptions,
        onClose = function()
            lib.showMenu('animations_main_menu')
        end,
    }, function(selected, _, option)
        if isActionsLimited then return end

        if option == 'animations_create_bind' then
            local query = lib.inputDialog(lang.create_emote_bind, {lang.emote_command_name})

            if not query then return end

            local _type, emote = getEmoteByCommand(query[1] --[[@as string]])

            if not _type or _type == 'Walks' then
                notify('error', lang.not_valid_emote)
                return
            end

            if emote?.BlockBinding then
                notify('error', lang.not_allowed_to_bind)
                return
            end

            createBind(selected, emote --[[@as table]])

            return
        end

        deleteBind(option)
    end)

    lib.showMenu('animations_emote_binds_menu')
end
=======
---Add an emote to the menu
---@param data table
function AddEmoteToMenu(menu, data)
    for i = 1, #Emotes do
        local emotes = Emotes[i]

        if emotes.name == menu then
            emotes.options[#emotes.options + 1] = data
            break
        end
    end

    RegisterMenu()
end
exports('addEmoteToMenu', AddEmoteToMenu)

---Add multiple emotes to the menu
---@param data table
function AddEmotesToMenu(menu, data)
    for i = 1, #Emotes do
        local emotes = Emotes[i]

        if emotes.name == menu then
            for k = 1, #data do
                emotes.options[#emotes.options + 1] = data[k]
            end
            break
        end
    end

    RegisterMenu()
end
exports('addEmotesToMenu', AddEmotesToMenu)

---Get a list of props from your current emote
---@return table?
function GetEmoteProps()
    return pedProps[cache.serverId]
end
exports('getEmoteProps', GetEmoteProps)

---Create props and attach them to a ped
---@param ped number
---@param data table
---@return table
function CreateProps(ped, data)
    local props = {}

    for i = 1, #data do
        local prop = data[i]
        local success, result = pcall(lib.requestModel, prop.hash)

        if not success then
            Utils.notify('error', result or '')

            goto skipProp
        end

        local min, max = GetModelDimensions(prop.hash)
        local size = max - min
        local largestDimension = math.max(size.x, size.y, size.z)

        if largestDimension > 5.0 or IsModelAPed(prop.hash) or IsModelAVehicle(prop.hash) then
            Utils.notify('error', locale('not_valid_prop', prop.name))
>>>>>>> upstream

            goto skipProp
        end
        
        local coords = GetEntityCoords(ped)
        local object = CreateObject(prop.hash, coords.x, coords.y, coords.z, false, false, false)
        
        SetEntityCollision(object, false, false)
        
        if prop.variant then SetObjectTextureVariation(object, prop.variant) end
        
        AttachEntityToEntity(object, ped, GetPedBoneIndex(ped, prop.bone), prop.placement[1].x, prop.placement[1].y, prop.placement[1].z, prop.placement[2].x, prop.placement[2].y, prop.placement[2].z, true, true, false, true, 1, true)
        SetModelAsNoLongerNeeded(prop.hash)

        props[i] = {
            entity = object,
            hasPtfx = prop.hasPtfx
        }

<<<<<<< fork
    lib.addRadialItem({{
        id = 'scully_emotemenu:open',
        label = lang.emotes,
        icon = 'person-walking',
        menu = 'scully_emotemenu:main'
    }})

    addEmotesToRadial('Walks', 'scully_emotemenu:walks', 'person-walking', {
        label = lang.cancel,
        icon = 'ban',
        onSelect = function()
            resetWalk()
        end
    })

    addEmotesToRadial('Expressions', 'scully_emotemenu:expressions', 'face-angry', {
        label = lang.cancel,
        icon = 'ban',
        onSelect = function()
            resetExpression()
        end
    })
end

if not Config.EnableSearch then
    mainMenuOptions = removeFromTable(mainMenuOptions, function(_table, _index)
        return _table[_index].args ~= 'animations_search'
    end)
end


||||||| base
    lib.addRadialItem({{
        id = 'scully_emotemenu:open',
        label = lang.emotes,
        icon = 'person-walking',
        menu = 'scully_emotemenu:main'
    }})

    addEmotesToRadial('Walks', 'scully_emotemenu:walks', 'person-walking', {
        label = lang.cancel,
        icon = 'ban',
        onSelect = function()
            resetWalk()
        end
    })

    addEmotesToRadial('Expressions', 'scully_emotemenu:expressions', 'face-angry', {
        label = lang.cancel,
        icon = 'ban',
        onSelect = function()
            resetExpression()
        end
    })
end

if not Config.EnableSearch then
    mainMenuOptions = removeFromTable(mainMenuOptions, function(_table, _index)
        return _table[_index].args ~= 'animations_search'
    end)
end

if Config.EnableEmoteBinds then
    local binds = emoteBinds

    for i = 1, 5 do
        local command = ('emotebind-%s'):format(i)

        RegisterCommand(command, function()
            local bind = emoteBinds[i]
            if bind then
                playEmoteByCommand(bind.Emote)
            end
        end, false)

        RegisterKeyMapping(command, command, 'keyboard', '')
    end

    for i = 1, #binds do
        local bind = binds[i]

        if bind then
            emoteMenuBindsOptions[i] = {label = bind.Label, description = lang.delete_bind, icon = ('fa-solid fa-%s'):format(i), args = bind.Index}
        end
    end
else
    mainMenuOptions = removeFromTable(mainMenuOptions, function(_table, _index)
        return _table[_index].args ~= 'animations_emote_binds_menu'
    end)
end
=======
        ::skipProp::
    end

    return props
end

---Delete props attached to a player
---@param serverId number
function DeleteProps(serverId)
    local props = pedProps[serverId]

    if not props then return end

    for i = 1, #props do
        local prop = props[i]
        
        if DoesEntityExist(prop.entity) then
            DeleteEntity(prop.entity)
        end
    end

    props = nil
end
>>>>>>> upstream

---Creates a list for the chosen table
---@param title string
---@param tbl table
---@param command string
function CreateList(title, tbl, command)
    local list = {}

    for i = 1, #tbl do
        local entry = tbl[i]

        if entry.icon then
            list[#list + 1] = ('__**%s**__'):format(entry.name)

            for k = 1, #entry.options do
                local option = entry.options[k]

<<<<<<< fork
    if option == 'animations_search' then
        local query = lib.inputDialog(lang.emote_search, {lang.emote})

        if not query then return end

        searchMenu(string.lower(query[1] --[[@as string]]))

        return
    elseif option == 'animations_emote_binds_menu' then
        openBindMenu()

        return
    elseif option == 'animations_emote_menu' then
        lib.showMenu('animations_emote_menu')

        return
    elseif option == 'cancel' then
        if scrollIndex == 1 then
            cancelEmote(false)
        elseif scrollIndex == 2 then
            resetWalk()
        elseif scrollIndex == 3 then
            resetExpression()
        elseif scrollIndex == 4 then
            cancelEmote(false)
            resetWalk()
            resetExpression()
        end

        return
    end

    local emote = AnimationList[option][scrollIndex]

    if not emote then
        notify('error', lang.not_valid_emote)

        return
    end

    if option == 'Walks' then
        setWalk(emote.Walk)

        return
    end

    playEmote(emote)
end)

--- Emote Menu
lib.registerMenu({
    id = 'animations_emote_menu',
    title = lang.emote_menu,
    position = Config.MenuPosition,
    options = emoteMenuOptions,
    onClose = function()
        lib.showMenu('animations_main_menu')
    end,
}, function(selected, scrollIndex, option)
    if isActionsLimited then return end

    local emote = AnimationList[option][scrollIndex]

    if not emote then
        notify('error', lang.not_valid_emote)

        return
    end

    if option == 'SynchronizedEmotes' then
        requestSynchronizedEmote(emote)

        return
    end

    if IsControlPressed(0, 38) and Config.EnableEmotePreview then
        initCloneEmote(emote)
        return
    end

    playEmote(emote)
end)

-- Commands
for i = 1, #Config.MenuOpenCommands do
    RegisterCommand(Config.MenuOpenCommands[i], function(source, args, rawCommand)
        if isActionsLimited then return end

        toggleMenu()
    end, false)
end

for i = 1, #Config.EmotePlayCommands do
    RegisterCommand(Config.EmotePlayCommands[i], function(source, args, rawCommand)
        if isActionsLimited then return end

        if not args[1] then
            notify('error', lang.not_valid_emote)

            return
        end

        local emoteName = args[1]:lower()

        if emoteName == 'c' then
            cancelEmote(false)

            return
        end

        if emoteName == 'l' then
            listEmotes('Emotes')

            return
        end

        local _type, emote = getEmoteByCommand(emoteName)

        if not _type or _type == 'Walks' then
            notify('error', lang.not_valid_emote)

            return
        end

        if _type == 'SynchronizedEmotes' then
            requestSynchronizedEmote(emote)

            return
        end

        local variant = nil
        local selectedVariant = args[2]

        if selectedVariant then
            local index = tonumber(selectedVariant)

            if index then variant = index end
        end

        playEmote(emote --[[@as table]], variant)
    end, false)
end

for i = 1, #Config.WalkSetCommands do
    RegisterCommand(Config.WalkSetCommands[i], function(_, args)
        if isActionsLimited then return end

        if not args[1] then
            notify('error', lang.not_valid_walk)

            return
        end

        local walkName = args[1]:lower()

        if walkName == 'c' then
            resetWalk()

            return
        end

        if walkName == 'l' then
            listEmotes('Walks')

            return
        end

        local _type, emote = getEmoteByCommand(walkName)

        if not _type or (_type ~= 'Walks') then
            notify('error', lang.not_valid_walk)

            return
        end

        setWalk(emote?.Walk)
    end, false)
end

-- Keybinds
if Config.MenuKeybind ~= '' then
    if #Config.MenuOpenCommands > 0 then
        RegisterKeyMapping(Config.MenuOpenCommands[1], lang.open_emote_menu, 'keyboard', Config.MenuKeybind)
    end
end

if Config.CancelEmoteKey ~= '' then
    keybinds.CancelKey = lib.addKeybind({
        name = 'mri_Qbox-ecancel',
        description = lang.cancel_your_emote,
        defaultKey = Config.CancelEmoteKey,
        onPressed = function()
            cancelEmote(false)
        end
    })
end

if Config.RagdollKeybind ~= '' then
    local IsPedOnFoot = IsPedOnFoot
    local SetPedToRagdoll = SetPedToRagdoll

    keybinds.Ragdoll = lib.addKeybind({
        name = 'ragdoll',
        description = lang.ragdoll_character,
        defaultKey = Config.RagdollKeybind,
        onPressed = function()
            if isActionsLimited or isPlayingAnimation then return end

            isRagdoll = not isRagdoll

            while isRagdoll do
                Wait(0)
                if isActionsLimited then
                    isRagdoll = false
                    break
                end

                if IsPedOnFoot(cache.ped) then
                    SetPedToRagdoll(cache.ped, 1000, 1000, 0, false, false, false)
                end
            end
        end
    })
end

if Config.HandsUpKey ~= '' then
    keybinds.HandsUp = lib.addKeybind({
        name = 'mri_Qbox-handsup',
        description = lang.hands_up,
        defaultKey = Config.HandsUpKey,
        onPressed = function(data)
            if isActionsLimited then return end

            if GetVehiclePedIsEntering(cache.ped) ~= 0 then return end -- return if ped trying to enter a vehicle

            local onBike = false

            if cache.vehicle then
                local model = GetEntityModel(cache.vehicle)

                onBike = IsThisModelABike(model)
||||||| base
    if option == 'animations_search' then
        local query = lib.inputDialog(lang.emote_search, {lang.emote})

        if not query then return end

        searchMenu(string.lower(query[1] --[[@as string]]))

        return
    elseif option == 'animations_emote_binds_menu' then
        openBindMenu()

        return
    elseif option == 'animations_emote_menu' then
        lib.showMenu('animations_emote_menu')

        return
    elseif option == 'cancel' then
        if scrollIndex == 1 then
            cancelEmote(false)
        elseif scrollIndex == 2 then
            resetWalk()
        elseif scrollIndex == 3 then
            resetExpression()
        elseif scrollIndex == 4 then
            cancelEmote(false)
            resetWalk()
            resetExpression()
        end

        return
    end

    local emote = AnimationList[option][scrollIndex]

    if not emote then
        notify('error', lang.not_valid_emote)

        return
    end

    if option == 'Walks' then
        setWalk(emote.Walk)

        return
    end

    playEmote(emote)
end)

--- Emote Menu
lib.registerMenu({
    id = 'animations_emote_menu',
    title = lang.emote_menu,
    position = Config.MenuPosition,
    options = emoteMenuOptions,
    onClose = function()
        lib.showMenu('animations_main_menu')
    end,
}, function(selected, scrollIndex, option)
    if isActionsLimited then return end

    local emote = AnimationList[option][scrollIndex]

    if not emote then
        notify('error', lang.not_valid_emote)

        return
    end

    if option == 'SynchronizedEmotes' then
        requestSynchronizedEmote(emote)

        return
    end

    if IsControlPressed(0, 38) and Config.EnableEmotePreview then
        initCloneEmote(emote)
        return
    end

    playEmote(emote)
end)

-- Commands
for i = 1, #Config.MenuOpenCommands do
    RegisterCommand(Config.MenuOpenCommands[i], function(source, args, rawCommand)
        if isActionsLimited then return end

        toggleMenu()
    end, false)
end

for i = 1, #Config.EmotePlayCommands do
    RegisterCommand(Config.EmotePlayCommands[i], function(source, args, rawCommand)
        if isActionsLimited then return end

        if not args[1] then
            notify('error', lang.not_valid_emote)

            return
        end

        local emoteName = args[1]:lower()

        if emoteName == 'c' then
            cancelEmote(false)

            return
        end

        if emoteName == 'l' then
            listEmotes('Emotes')

            return
        end

        local _type, emote = getEmoteByCommand(emoteName)

        if not _type or _type == 'Walks' then
            notify('error', lang.not_valid_emote)

            return
        end

        if _type == 'SynchronizedEmotes' then
            requestSynchronizedEmote(emote)

            return
        end

        local variant = nil
        local selectedVariant = args[2]

        if selectedVariant then
            local index = tonumber(selectedVariant)

            if index then variant = index end
        end

        playEmote(emote --[[@as table]], variant)
    end, false)
end

for i = 1, #Config.WalkSetCommands do
    RegisterCommand(Config.WalkSetCommands[i], function(_, args)
        if isActionsLimited then return end

        if not args[1] then
            notify('error', lang.not_valid_walk)

            return
        end

        local walkName = args[1]:lower()

        if walkName == 'c' then
            resetWalk()

            return
        end

        if walkName == 'l' then
            listEmotes('Walks')

            return
        end

        local _type, emote = getEmoteByCommand(walkName)

        if not _type or (_type ~= 'Walks') then
            notify('error', lang.not_valid_walk)

            return
        end

        setWalk(emote?.Walk)
    end, false)
end

-- Keybinds
if Config.MenuKeybind ~= '' then
    if #Config.MenuOpenCommands > 0 then
        RegisterKeyMapping(Config.MenuOpenCommands[1], lang.open_emote_menu, 'keyboard', Config.MenuKeybind)
    end
end

if Config.CancelEmoteKey ~= '' then
    keybinds.CancelKey = lib.addKeybind({
        name = 'ecancel',
        description = lang.cancel_your_emote,
        defaultKey = Config.CancelEmoteKey,
        onPressed = function()
            cancelEmote(false)
        end
    })
end

if Config.RagdollKeybind ~= '' then
    local IsPedOnFoot = IsPedOnFoot
    local SetPedToRagdoll = SetPedToRagdoll

    keybinds.Ragdoll = lib.addKeybind({
        name = 'ragdoll',
        description = lang.ragdoll_character,
        defaultKey = Config.RagdollKeybind,
        onPressed = function()
            if isActionsLimited or isPlayingAnimation then return end

            isRagdoll = not isRagdoll

            while isRagdoll do
                Wait(0)
                if isActionsLimited then
                    isRagdoll = false
                    break
                end

                if IsPedOnFoot(cache.ped) then
                    SetPedToRagdoll(cache.ped, 1000, 1000, 0, false, false, false)
                end
            end
        end
    })
end

if Config.HandsUpKey ~= '' then
    keybinds.HandsUp = lib.addKeybind({
        name = 'handsup',
        description = lang.hands_up,
        defaultKey = Config.HandsUpKey,
        onPressed = function(data)
            if isActionsLimited then return end

            if GetVehiclePedIsEntering(cache.ped) ~= 0 then return end -- return if ped trying to enter a vehicle

            local onBike = false

            if cache.vehicle then
                local model = GetEntityModel(cache.vehicle)

                onBike = IsThisModelABike(model)
=======
                list[#list + 1] = ('- %s (/%s %s)'):format(option.Label, command, option.Command)
>>>>>>> upstream
            end

            list[#list + 1] = '\n'
        else
            list[i] = ('- %s (/%s %s)'):format(entry.Label, command, entry.Command)
        end
    end

    list = table.concat(list, '\n')

    lib.alertDialog({
        header = title,
        content = list,
        centered = true,
        size = 'lg',
        overflow = true,
        labels = { cancel = '', confirm = locale('close') }
    })
end

---Toggle player limitations
---@param limited boolean
function SetLimitation(limited)
    PlayerState:set('isLimited', limited, true)
end
exports('setLimitation', SetLimitation)

---Check if the player is currently limited
---@return boolean
function IsLimited()
    return PlayerState.isLimited
end
exports('isLimited', IsLimited)

local IsControlJustPressed = IsControlJustPressed

---Handles the emote request interface
---@param label string
---@param cb function
local function emoteRequest(label, cb)
    PlaySoundFrontend(-1, 'NAV', 'HUD_AMMO_SHOP_SOUNDSET', false)

    local timeout = 5

    CreateThread(function()
        while timeout >= 0 do
            lib.showTextUI(locale('accept_deny', timeout, label))

            timeout -= 1

            Wait(1000)
        end

        lib.hideTextUI()
    end)

    while timeout >= 0 do
        if IsControlJustPressed(0, 246) then
            cb()
            break
        elseif IsControlJustPressed(0, 306) then
            break
        end

        Wait(0)
    end

    timeout = -1
end

RegisterNetEvent('scully_emotemenu:groupEmoteRequest', function(senderId, senderData)
    emoteRequest(senderData.Label, function()
        local sender = GetPlayerFromServerId(senderId)

        if sender ~= -1 then
            local senderPed = GetPlayerPed(sender)

            if DoesEntityExist(senderPed) then
                senderData.StartGroupEmote = true

                PlayEmote(senderData)

                Wait(100)

                local animTime = GetEntityAnimCurrentTime(senderPed, value.dict, value.anim)

                SetEntityAnimCurrentTime(cache.ped, value.dict, value.anim, animTime)
            end
        end
    end)
end)

RegisterNetEvent('scully_emotemenu:synchronizedEmoteRequest', function(sender, senderData, targetData)
    emoteRequest(targetData.Label, function()
        TriggerServerEvent('scully_emotemenu:synchronizedEmoteResponse', sender, senderData, targetData)
    end)
end)

RegisterNetEvent('scully_emotemenu:targetStartSynchronizedEmote', function(sender, senderData, targetData)
    local isValid = lib.requestAnimDict(targetData.Dictionary)

    if not isValid then
        Utils.notify('error', locale('not_valid_emote'))
        return
    end

    if targetData.Options.Shared.Attach and not senderData.Options.Shared.Attach then
        local senderId = GetPlayerFromServerId(sender)
        local senderPed = GetPlayerPed(senderId)
        local bone = targetData.Options.Shared.Bone or -1
        local placement = targetData.Options.Shared.Placement
        local xP, yP, zP, xR, yR, zR = 0.0, 0.0, 0.0, 0.0, 0.0, 0.0

        if placement then
            xP, yP, zP, xR, yR, zR = placement[1].x, placement[1].y, placement[1].z, placement[2].x, placement[2].y, placement[2].z
        end

        AttachEntityToEntity(cache.ped, senderPed, GetPedBoneIndex(senderPed, bone), xP, yP, zP, xR, yR, zR, false, false, false, true, 1, true)
    end

    targetData.StartSynchronized = true

    PlayEmote(targetData)
    PlayerState:set('inSynchronizedEmote', sender, true)
end)

RegisterNetEvent('scully_emotemenu:senderStartSynchronizedEmote', function(target, senderData)
    local isValid = lib.requestAnimDict(senderData.Dictionary)

    if not isValid then
        Utils.notify('error', locale('not_valid_emote'))
        return
    end

    local targetId = GetPlayerFromServerId(target)
    local targetPed = GetPlayerPed(targetId)
    local frontOffset, sideOffset, heightOffset, headingOffset = 1.0, 0.0, 0.0, 180.1

    if senderData.Options.Shared.FrontOffset then
        frontOffset = senderData.Options.Shared.FrontOffset + 0.0
    end

    if senderData.Options.Shared.SideOffset then
        sideOffset = senderData.Options.Shared.SideOffset + 0.0
    end

    if senderData.Options.Shared.HeightOffset then
        heightOffset = senderData.Options.Shared.HeightOffset + 0.0
    end

    if senderData.Options.Shared.HeadingOffset then
        headingOffset = senderData.Options.Shared.HeadingOffset + 0.0
    end

    if senderData.Options.Shared.Attach then
        local bone = senderData.Options.Shared.Bone or -1
        local placement = senderData.Options.Shared.Placement
        local xP, yP, zP, xR, yR, zR = 0.0, 0.0, 0.0, 0.0, 0.0, 0.0

        if placement then
            xP, yP, zP, xR, yR, zR = placement[1].x, placement[1].y, placement[1].z, placement[2].x, placement[2].y, placement[2].z
        end

        AttachEntityToEntity(cache.ped, targetPed, GetPedBoneIndex(targetPed, bone), xP, yP, zP, xR, yR, zR, false, false, false, true, 1, true)
    end

    local targetCoords = GetOffsetFromEntityInWorldCoords(targetPed, sideOffset, frontOffset, heightOffset)
    local targetHeading = GetEntityHeading(targetPed)

    SetEntityHeading(cache.ped, targetHeading - headingOffset)
    SetEntityCoordsNoOffset(cache.ped, targetCoords.x, targetCoords.y, targetCoords.z, false, false, false)

    senderData.StartSynchronized = true

    PlayEmote(senderData)
    PlayerState:set('inSynchronizedEmote', target, true)
end)

RegisterNetEvent('scully_emotemenu:toggleMenu', ToggleMenu)
RegisterNetEvent('scully_emotemenu:closeMenu', CloseMenu)
RegisterNetEvent('scully_emotemenu:addEmoteMenuOption', AddEmoteMenuOption)
RegisterNetEvent('scully_emotemenu:playEmote', PlayEmote)
RegisterNetEvent('scully_emotemenu:cancelEmote', CancelEmote)
RegisterNetEvent('scully_emotemenu:playEmoteByCommand', PlayEmoteByCommand)
RegisterNetEvent('scully_emotemenu:setWalk', SetWalk)
RegisterNetEvent('scully_emotemenu:resetWalk', ResetWalk)
RegisterNetEvent('scully_emotemenu:setWalkByCommand', SetWalkByCommand)
RegisterNetEvent('scully_emotemenu:setExpression', SetExpression)
RegisterNetEvent('scully_emotemenu:resetExpression', ResetExpression)
RegisterNetEvent('scully_emotemenu:setExpressionByCommand', SetExpressionByCommand)
RegisterNetEvent('scully_emotemenu:registerEmote', RegisterEmote)
RegisterNetEvent('scully_emotemenu:playRegisteredEmote', PlayRegisteredEmote)
RegisterNetEvent('scully_emotemenu:setLimitation', SetLimitation)
RegisterNetEvent('scully_emotemenu:addEmoteToMenu', AddEmoteToMenu)
RegisterNetEvent('scully_emotemenu:addEmotesToMenu', AddEmotesToMenu)

RegisterNetEvent('onPlayerDropped', function(serverId)
    DeleteProps(serverId)

    local hasPtfx = pedPtfx[serverId]

    if hasPtfx then
        StopParticleFxLooped(hasPtfx, false)
        
        pedPtfx[serverId] = nil
    end
end)

<<<<<<< fork
-- Clear pedsObjects list and delete objects
function clearpedsObjects()
    for i = 1, #pedsObjects do
        DeleteEntity(pedsObjects[i])
    end

    pedsObjects = {}
end
exports('clearpedsObjects', clearpedsObjects)

-- Cache
lib.onCache('ped', function(playerPed)
    if cache.ped ~= playerPed then
        if currentExpression ~= 'default' then
            setExpression(currentExpression)
||||||| base
-- Cache
lib.onCache('ped', function(playerPed)
    if cache.ped ~= playerPed then
        if currentExpression ~= 'default' then
            setExpression(currentExpression)
=======
AddStateBagChangeHandler('emoteProps', nil, function(bagName, key, value, reserved, replicated)
    if replicated then return end

    local player = GetPlayerFromStateBagName(bagName)

    if player == 0 then return end

    local ped = GetPlayerPed(player)
    local serverId = GetPlayerServerId(player)
    
    if not value then
        DeleteProps(serverId)
        return
    end

    pedProps[serverId] = CreateProps(ped, value)
end)

AddStateBagChangeHandler('emotePtfx', nil, function(bagName, key, value, reserved, replicated)
    if replicated then return end

    local player = GetPlayerFromStateBagName(bagName)

    if player == 0 then return end

    local ped = GetPlayerPed(player)
    local serverId = GetPlayerServerId(player)
    local state = Player(serverId).state
    local ptfx = state?.ptfx
    local hasPtfx = pedPtfx[serverId]

    if hasPtfx and not value then
        if hasPtfx then
            StopParticleFxLooped(hasPtfx, false)

            pedPtfx[serverId] = nil
>>>>>>> upstream
        end

        return
    end

    if hasPtfx or not ptfx then return end
    if ptfx?.canHold and not state.emotePtfx then return end

    local props = pedProps[serverId]
    local target = ped

    if props then
        for i = 1, #props do
            local prop = props[i]

            if prop.hasPtfx then
                target = prop.entity
                break
            end
        end
    end

    local boneIndex = ptfx.bone and GetPedBoneIndex(ped, ptfx.bone) or GetEntityBoneIndexByName(ptfx.name, 'VFX')

    lib.requestNamedPtfxAsset(ptfx.asset)
    UseParticleFxAsset(ptfx.asset)

    local effect = StartParticleFxLoopedOnEntityBone(ptfx.name, target, ptfx.placement[1].x, ptfx.placement[1].y, ptfx.placement[1].z, ptfx.placement[2].x, ptfx.placement[2].y, ptfx.placement[2].z, boneIndex, ptfx.placement[3] + 0.0, false, false, false)

    if ptfx.color then
        if ptfx.color[1] and type(ptfx.color[1]) == 'table' then
            local randomIndex = math.random(1, #ptfx.color)

            ptfx.color = ptfx.color[randomIndex]
        end

        SetParticleFxLoopedAlpha(effect, ptfx.color.A)
        SetParticleFxLoopedColour(effect, ptfx.color.R / 255, ptfx.color.G / 255, ptfx.color.B / 255, false)
    end

    pedPtfx[serverId] = effect

    Wait(1000)

    RemoveNamedPtfxAsset(ptfx.asset)
end)

AddStateBagChangeHandler('inSynchronizedEmote', nil, function(bagName, key, value, reserved, replicated)
    if replicated then return end

    local inSynchronizedEmote = PlayerState.inSynchronizedEmote

    if not inSynchronizedEmote then return end

    local player = GetPlayerFromStateBagName(bagName)

    if player == 0 then return end

    local serverId = GetPlayerServerId(player)
    
    if not value and inSynchronizedEmote == serverId then
        Utils.notify('error', locale('emote_cancelled'))
        CancelEmote()
    end
end)

if Config.emoteCommands then
    for i = 1, #Config.emoteCommands do
        Utils.addCommand(Config.emoteCommands[i], {
            help = locale('emote_command_help'),
            params = {
                { name = locale('emote_command_param1_name'), help = locale('emote_command_param1_help') },
                { name = locale('emote_command_param2_name'), help = locale('emote_command_param2_help') }
            }
        }, function(source, args, raw)
            local param1 = args[1]

            if not param1 then
                Utils.notify('error', locale('not_valid_emote'))
                return
            end

            local emoteName = param1:lower()

            if emoteName == 'c' then
                CancelEmote()
                return
            end

            if emoteName == 'l' then
                CreateList(locale('emotes'), Emotes, Config.emoteCommands[1])
                return
            end

            local variant
            local param2 = args[2]

            if param2 then
                local index = tonumber(param2)

                if index then variant = index end
            end

            PlayEmoteByCommand(emoteName, variant)
        end)
    end
end

if Config.walkCommands then
    for i = 1, #Config.walkCommands do
        Utils.addCommand(Config.walkCommands[i], {
            help = locale('walk_command_help'),
            params = {
                { name = locale('walk_command_param1_name'), help = locale('walk_command_param1_help') }
            }
        }, function(source, args, raw)
            local param1 = args[1]

            if not param1 then
                Utils.notify('error', locale('not_valid_walk'))
                return
            end

            local walkName = param1:lower()

            if walkName == 'c' then
                ResetWalk()
                return
            end

            if walkName == 'l' then
                CreateList(locale('walking_styles'), Walks, Config.walkCommands[1])
                return
            end

            SetWalkByCommand(walkName)
        end)
    end
end

if Config.expressionCommands then
    for i = 1, #Config.expressionCommands do
        Utils.addCommand(Config.expressionCommands[i], {
            help = locale('expression_command_help'),
            params = {
                { name = locale('expression_command_param1_name'), help = locale('expression_command_param1_help') }
            }
        }, function(source, args, raw)
            local param1 = args[1]

            if not param1 then
                Utils.notify('error', locale('not_valid_expression'))
                return
            end

            local expressionName = param1:lower()

            if expressionName == 'c' then
                ResetExpression()
                return
            end

            if expressionName == 'l' then
                CreateList(locale('facial_expressions'), Expressions, Config.expressionCommands[1])
                return
            end

            SetExpressionByCommand(expressionName)
        end)
    end
end

if Config.emoteCancelKey then
    lib.addKeybind({
        name = 'emoteCancelKey',
        description = locale('cancel_emote'),
        defaultKey = Config.emoteCancelKey,
        onPressed = function()
            CancelEmote()
        end
    })
end

if Config.ptfxKey then
    keybinds.Ptfx = lib.addKeybind({
        name = 'ptfxKey',
        disabled = true,
        description = locale('play_ptfx'),
        defaultKey = Config.ptfxKey,
        onPressed = function()
            PlayerState:set('emotePtfx', true, true)

            if not PlayerState?.ptfx?.canHold then
                PlayerState:set('emotePtfx', false, true)
            end
        end,
        onReleased = function()
            if PlayerState?.ptfx?.canHold then
                PlayerState:set('emotePtfx', false, true)
            end
        end
    })
end

if Config.enableEmoteBinds then
    for i = 1, 5 do
        local index = tostring(i)
    
        lib.addKeybind({
            name = ('emotebindKey-%s'):format(index),
            description = locale('emote_bind', index),
            defaultKey = '',
            onPressed = function()
                local emote = EmoteBinds[index]
    
                if emote then
                    PlayEmote(emote)
                end
            end
        })
    end
end

lib.onCache('ped', function(ped)
    local walkstyle = KVP.getString('walkstyle')

    if walkstyle then
        SetWalk(walkstyle)
    end

    local expression = KVP.getString('expression')

    if expression then
        SetExpression(expression)
    end
end)

AddEventHandler('playerSpawned', function()
    Wait(1000)

    local walkstyle = KVP.getString('walkstyle')

    if walkstyle then
        SetWalk(walkstyle)
    end

    local expression = KVP.getString('expression')

    if expression then
        SetExpression(expression)
    end
end)

AddEventHandler('entityDamaged', function(entity)
    if cache.ped == entity then
        if not IsPedFatallyInjured(cache.ped) then return end

        CancelEmote()
    end
end)

local openingDoor = false
local IsPedOpeningADoor = IsPedOpeningADoor

AddEventHandler('CEventOpenDoor', function()
    if not PlayerState.isInEmote then return end
    if openingDoor then return end

    openingDoor = true

    while IsPedOpeningADoor(cache.ped) do
        Wait(100)
    end

    Wait(100)

    openingDoor = false

    local lastEmote = PlayerState.lastEmote

    if lastEmote then
        CancelEmote(true)
        Wait(10)
        PlayEmote(lastEmote[1], lastEmote[2])
    end
end)

local hitTimeout, hittingPed = 500, false

AddEventHandler('CEventPlayerCollisionWithPed', function()
    if not PlayerState.isInEmote then return end

    if hittingPed then
        hitTimeout = 500
        return
    end

    hitTimeout, hittingPed = 500, true

    while hitTimeout > 0 do
        Wait(100)

        hitTimeout -= 100
    end

    Wait(100)

    local lastEmote = PlayerState.lastEmote

    if lastEmote then
        hitTimeout, hittingPed = 500, false

        CancelEmote(true)
        Wait(10)
        PlayEmote(lastEmote[1], lastEmote[2])
    end
end)

<<<<<<< fork
AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        clearpedsObjects()
        cancelEmote(false)
    end
end)
||||||| base
AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        cancelEmote(false)
    end
end)
=======
if Config.handsUpKey ~= '' then require 'client.modules.handsup' end
if Config.stanceKey ~= '' then require 'client.modules.stance' end
if Config.pointKey ~= '' then require 'client.modules.point' end
if Config.ragdollKey ~= '' then require 'client.modules.ragdoll' end
>>>>>>> upstream
