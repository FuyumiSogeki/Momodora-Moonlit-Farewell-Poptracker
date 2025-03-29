-- entry point for all lua code of the pack
-- more info on the lua API: https://github.com/black-sliver/PopTracker/blob/master/doc/PACKS.md#lua-interface
ENABLE_DEBUG_LOG = true
-- get current variant
local variant = Tracker.ActiveVariantUID

-- Utility Script for helper functions etc.
ScriptHost:LoadScript("scripts/utils.lua")

--Scripts
ScriptHost:LoadScript("scripts/logic.lua")

-- Items
Tracker:AddItems("items/items.jsonc")

-- Maps
Tracker:AddMaps("maps/maps.jsonc")

-- Layouts
Tracker:AddLayouts("layouts/items.jsonc")
Tracker:AddLayouts("layouts/tracker.jsonc")

-- Locations
Tracker:AddLocations("locations/locations.json")

print("-- Example Tracker --")
print("Loaded variant: ", variant)
if ENABLE_DEBUG_LOG then
    print("Debug logging is enabled!")
end

-- AutoTracking for Poptracker
if PopVersion and PopVersion >= "0.18.0" then
    ScriptHost:LoadScript("scripts/autotracking.lua")
end
