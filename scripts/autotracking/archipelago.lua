-- this is an example/ default implementation for AP autotracking
-- it will use the mappings defined in item_mapping.lua and location_mapping.lua to track items and locations via thier ids
-- it will also load the AP slot data in the global SLOT_DATA, keep track of the current index of on_item messages in CUR_INDEX
-- addition it will keep track of what items are local items and which one are remote using the globals LOCAL_ITEMS and GLOBAL_ITEMS
-- this is useful since remote items will not reset but local items might
ScriptHost:LoadScript("scripts/autotracking/item_mapping.lua")
ScriptHost:LoadScript("scripts/autotracking/location_mapping.lua")
ScriptHost:LoadScript("scripts/autotracking/hint_mapping.lua")

CUR_INDEX = -1
SLOT_DATA = nil
PLAYER_NUMBER = -1
TEAM_NUMBER = -1
LOCAL_ITEMS = {}
GLOBAL_ITEMS = {}

function onClear(slot_data)
    PLAYER_NUMBER = Archipelago.PlayerNumber
	TEAM_NUMBER = Archipelago.TeamNumber

	-- use bulk update to pause logic updates until we are done resetting all items/locations
	Tracker.BulkUpdate = true	

    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("called onClear, slot_data:\n%s", dump_table(slot_data)))
    end

    SLOT_DATA = slot_data
    CUR_INDEX = -1
    
    -- reset locations
    for _, v in pairs(LOCATION_MAPPING) do
        if v[1] then
            if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                print(string.format("onClear: clearing location %s", v[1]))
            end
            local obj = Tracker:FindObjectForCode(v[1])
            if obj then
                if v[1]:sub(1, 1) == "@" then
                    obj.AvailableChestCount = obj.ChestCount
                else
                    obj.Active = false
                end
            elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                print(string.format("onClear: could not find object for code %s", v[1]))
            end
        end
    end

    -- reset items
    for _, v in pairs(ITEM_MAPPING) do
        if v[1] and v[2] then
            if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                print(string.format("onClear: clearing item %s of type %s", v[1], v[2]))
            end
            local obj = Tracker:FindObjectForCode(v[1])
            if obj then
                if v[2] == "toggle" then
                    obj.Active = false
                elseif v[2] == "progressive" then
                    obj.CurrentStage = 0
                    obj.Active = false
                elseif v[2] == "consumable" then
                    obj.AcquiredCount = 0
                elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                    print(string.format("onClear: unknown item type %s for code %s", v[2], v[1]))
                end
            elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                print(string.format("onClear: could not find object for code %s", v[1]))
            end
        end
    end

    -- set settings
    if slot_data['bell_hover_generation'] then
        Tracker:FindObjectForCode("op_BH").CurrentStage = 1
    else
        Tracker:FindObjectForCode("op_BH").CurrentStage = 0
    end

    if slot_data['oracle_sigil'] then
        Tracker:FindObjectForCode("op_OS").CurrentStage = 1 
    else
        Tracker:FindObjectForCode("op_OS").CurrentStage = 0
    end

    if slot_data['open_springleaf_path'] then
        Tracker:FindObjectForCode("op_OSP").CurrentStage = 1 
    else
        Tracker:FindObjectForCode("op_OSP").CurrentStage = 0
    end

    if slot_data['randomize_key_items'] then
        Tracker:FindObjectForCode("op_RKI").CurrentStage = 1
    else
        Tracker:FindObjectForCode("op_RKI").CurrentStage = 0
    end

    if slot_data['final_boss_keys'] then
        Tracker:FindObjectForCode("op_FBK").CurrentStage = 1 
    else
        Tracker:FindObjectForCode("op_FBK").CurrentStage = 0
    end

    if slot_data['progressive_damage_upgrade'] then
        Tracker:FindObjectForCode("op_RHL").CurrentStage = 1 
    else
        Tracker:FindObjectForCode("op_RHL").CurrentStage = 0
    end

    if slot_data['progressive_health_upgrade'] then
        Tracker:FindObjectForCode("op_RDB").CurrentStage = 1 
    else
        Tracker:FindObjectForCode("op_RDB").CurrentStage = 0
    end

    if slot_data['progressive_magic_upgrade'] then
        Tracker:FindObjectForCode("op_RLB").CurrentStage = 1 
    else
        Tracker:FindObjectForCode("op_RLB").CurrentStage = 0
    end

    if slot_data['progressive_stamina_upgrade'] then
        Tracker:FindObjectForCode("op_RP").CurrentStage = 1 
    else
        Tracker:FindObjectForCode("op_RP").CurrentStage = 0
    end

    if slot_data['progressive_lumen_fairies'] then
        Tracker:FindObjectForCode("op_RF").CurrentStage = 1 
    else
        Tracker:FindObjectForCode("op_RF").CurrentStage = 0
    end

    if slot_data['victory_condition'] == 1 then
        Tracker:FindObjectForCode("op_VC").CurrentStage = 1 
    else
        Tracker:FindObjectForCode("op_VC").CurrentStage = 0
    end

    -- get hints
    if Archipelago.PlayerNumber > -1 then
        HINTS_ID = "_read_hints_"..TEAM_NUMBER.."_"..PLAYER_NUMBER

        Archipelago:SetNotify({HINTS_ID})
        Archipelago:Get({HINTS_ID})

        print(string.format("hints table dump: %s", dump_table(HINTS_ID)))
    end

    -- end clear
	LOCAL_ITEMS = {}
	GLOBAL_ITEMS = {}
	Tracker.BulkUpdate = false
    
    if SLOT_DATA == nil then
        return
    end
end

function checkUnusedSigil(location_id)
    if location_id == 419 then
        local objItem = Tracker:FindObjectForCode("the_fool")
        if objItem then
            objItem.Active = true
        elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
            print(string.format("onLocation: could not find The Fool"))
        end
    elseif location_id == 123 then
        local objItem = Tracker:FindObjectForCode("last_wish")
        if objItem then
            objItem.Active = true
        elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
            print(string.format("onLocation: could not find Last Wish"))
        end
    elseif location_id == 401 then
        local objItem = Tracker:FindObjectForCode("the_profiteer")
        if objItem then
            objItem.Active = true
        elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
            print(string.format("onLocation: could not find The Profiteer"))
        end
    elseif location_id == 408 then
        local objItem = Tracker:FindObjectForCode("strongfist")
        if objItem then
            objItem.Active = true
        elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
            print(string.format("onLocation: could not find Strongfist"))
        end
    elseif location_id == 422 then
        local objItem = Tracker:FindObjectForCode("fallen_hero")
        if objItem then
            objItem.Active = true
        elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
            print(string.format("onLocation: could not find Fallen Hero"))
        end
    elseif location_id == 406 then
        local objItem = Tracker:FindObjectForCode("queen_of_light")
        if objItem then
            objItem.Active = true
        elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
            print(string.format("onLocation: could not find Queen of Light"))
        end
    elseif location_id == 426 then
        local objItem = Tracker:FindObjectForCode("the_collector")
        if objItem then
            objItem.Active = true
        elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
            print(string.format("onLocation: could not find The Collector"))
        end
    elseif location_id == 431 then
        local objItem = Tracker:FindObjectForCode("chrysanth")
        if objItem then
            objItem.Active = true
        elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
            print(string.format("onLocation: could not find Chrysanth"))
        end
    elseif location_id == 437 then
        local objItem = Tracker:FindObjectForCode("queen_of_dusk")
        if objItem then
            objItem.Active = true
        elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
            print(string.format("onLocation: could not find Queen of Dusk"))
        end
    elseif location_id == 364 then
        local objItem = Tracker:FindObjectForCode("manual_dora_fight")
        if objItem then
            objItem.Active = true
        elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
            print(string.format("onLocation: could not find Dora Fight"))
        end
    end
end

function onLocation(location_id, location_name)
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("called onLocation: %s, %s", location_id, location_name))
    end

    local v = LOCATION_MAPPING[location_id]

    if not v and AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("onLocation: could not find location mapping for id %s", location_id))
    end

    if not v[1] then
        return
    end

    local obj = Tracker:FindObjectForCode(v[1])

    if obj then
        if v[1]:sub(1, 1) == "@" then
            obj.AvailableChestCount = obj.AvailableChestCount - 1
        else
            obj.Active = true
        end

        checkUnusedSigil(location_id)
    elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("onLocation: could not find object for code %s", v[1]))
    end
end

function onNotify(key, value, old_value)
    if value ~= old_value and key == HINTS_ID then
        for _, hint in ipairs(value) do
            if hint.finding_player == Archipelago.PlayerNumber then
                updateHints(hint.location, hint.found)
            end
        end
    end
end

function onNotifyLaunch(key, value)
    if key == HINTS_ID then
        for _, hint in ipairs(value) do
            if hint.finding_player == Archipelago.PlayerNumber then
                updateHints(hint.location, hint.found)
            end
        end
    end
end

function updateHints(locationID, foundItem)
    local v = HINT_MAPPING[locationID]
    if v then
        print(string.format("checking object for code %s", v[1]))
        local obj = Tracker:FindObjectForCode(v[1])

        if obj then
            obj.Active = not foundItem
        else
            print(string.format("No object found for code: %s", v[1]))
        end
    else
        print(string.format("could not find object at %s", locationID))
    end
end

function onItem(index, item_id, item_name, player_number)
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("called onItem: %s, %s, %s, %s, %s", index, item_id, item_name, player_number, CUR_INDEX))
    end

    if index <= CUR_INDEX then
        return
    end

    local is_local = player_number == Archipelago.PlayerNumber
    CUR_INDEX = index;
    local v = ITEM_MAPPING[item_id]

    if not v then
        if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
            print(string.format("onItem: could not find item mapping for id %s", item_id))
        end
        return
    end

    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("onItem: code: %s, type %s", v[1], v[2]))
    end

    if not v[1] then
        return
    end

    local obj = Tracker:FindObjectForCode(v[1])

    if obj then
        if v[2] == "toggle" then
            obj.Active = true
        elseif v[2] == "progressive" then
            if obj.Active then
                obj.CurrentStage = obj.CurrentStage + 1
            else
                obj.Active = true
            end
        elseif v[2] == "consumable" then
            obj.AcquiredCount = obj.AcquiredCount + obj.Increment
        elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
            print(string.format("onItem: unknown item type %s for code %s", v[2], v[1]))
        end
    elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("onItem: could not find object for code %s", v[1]))
    end

    -- track local items via snes interface
    if is_local then
        if LOCAL_ITEMS[v[1]] then
            LOCAL_ITEMS[v[1]] = LOCAL_ITEMS[v[1]] + 1
        else
            LOCAL_ITEMS[v[1]] = 1
        end
    else
        if GLOBAL_ITEMS[v[1]] then
            GLOBAL_ITEMS[v[1]] = GLOBAL_ITEMS[v[1]] + 1
        else
            GLOBAL_ITEMS[v[1]] = 1
        end
    end

    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("local items: %s", dump_table(LOCAL_ITEMS)))
        print(string.format("global items: %s", dump_table(GLOBAL_ITEMS)))
    end
end

-- add AP callbacks
-- un-/comment as needed
Archipelago:AddClearHandler("clear handler", onClear)

if AUTOTRACKER_ENABLE_ITEM_TRACKING then
	Archipelago:AddItemHandler("item handler", onItem)
end

if AUTOTRACKER_ENABLE_LOCATION_TRACKING then
	Archipelago:AddLocationHandler("location handler", onLocation)
end

Archipelago:AddSetReplyHandler("notify handler", onNotify)
Archipelago:AddRetrievedHandler("notify launch handler", onNotifyLaunch)