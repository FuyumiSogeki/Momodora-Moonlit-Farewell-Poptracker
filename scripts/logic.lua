---@diagnostic disable: lowercase-global
function has(item, amount)
    local count = Tracker:ProviderCountForCode(item)
    amount = tonumber(amount)
    if not amount then
      return count > 0
    else
      return count == amount
    end
end

-- Tracker Settings

function isHint()
    return true
end

-- Hint Settings

function isSpringleafOpen()
    return has("open_springleaf_on")
end

function isBellHover()
    return has("bell_hover_on")
end

function isOracle()
    return has("oracle_sigil_on")
end

function isKeyItems()
    return has("key_items_on")
end

function isKeySelin()
    return has("final_boss_key_on")
end

function isDotted()
    return has("dotted_on")
end

function isLun()
    return has("lun_on")
end

function isPeach()
    return has("peach_on")
end

function isLily()
    return has("lily_on")
end

function isFairy()
    return has("fairy_on")
end

function isCompanion()
    return has("companion_on")
end


-- Settings Logic

function OpenWindmill()
    return (isKeyItems() and has("windmill_key")) or not isKeyItems()
end

function TradeDust()
    return (isKeyItems() and has("gold_moonlit_dust") and has("silver_moonlit_dust")) or not isKeyItems()
end

function OpenSelin()
    return (isKeySelin() and has("progressive_final_boss_key",4) or not isKeySelin())
end

-- Progression Items

function SacredLeaf()
    return has("awakened_sacred_leaf")
end

function SacredAnemone()
    return has("sacred_anemone")
end

function CrescentMoonflower()
    return has("crescent_moonflower")
end

function SpiralShell()
    return has("spiral_shell")
end

function LunarAttunement()
    return has("lunar_attunement")
end

-- Locations Logic

function ContinueSpringleaf()
    return (SacredLeaf() and (SacredAnemone() or CrescentMoonflower() or SpiralShell() or isBellHover())) or isSpringleafOpen()
end

function ReachLunTreeRoots()
    return SacredAnemone() or isSpringleafOpen()
end

function ReachFairySprings()
    return (ReachLunTreeRoots() and CrescentMoonflower()) or ((CrescentMoonflower() or SpiralShell()) and (SacredAnemone() or isSpringleafOpen()))
end

function ReachOldSanctuary()
    return SpiralShell() or ((isBellHover() or LunarAttunement()) and CrescentMoonflower())
end

function ContinueOldSanctuary()
    return ReachOldSanctuary() and (SpiralShell() or (isBellHover() and CrescentMoonflower() and LunarAttunement()))
end

function ReachDemonFrontier()
    return ReachLunTreeRoots() and (SpiralShell() or (CrescentMoonflower() and isBellHover()))
end

function ReachAshenHinterlands()
    return ReachDemonFrontier() and (CrescentMoonflower() or (SpiralShell() and isBellHover() and (SacredAnemone() or has("perfect_chime"))))
end

function ReachMoonlightRepose()
    return ReachLunTreeRoots() and SpiralShell() and (SacredLeaf() or isSpringleafOpen())
end

function ContinueAshenHinterlands()
    return ReachAshenHinterlands() and SpiralShell()
end

function ContinueDemonFrontier()
    return ReachDemonFrontier() and ((SpiralShell() and LunarAttunement()) or (SpiralShell() and (SacredAnemone() or has("perfect_chime"))))
end

function ReachMeikanVillage()
    return ContinueDemonFrontier() and LunarAttunement()
end

function ReachMeikanVillageWindmill()
    return ReachMeikanVillage() and (OpenWindmill() and (CrescentMoonflower() or (SpiralShell() and isBellHover())))
end

function ReachFountOfRebirth()
    return ReachMeikanVillageWindmill() and CrescentMoonflower() and OpenWindmill()
end

function ReachSelin()
    return ReachFountOfRebirth() and OpenSelin()
end

function Perfect()
    return ReachMeikanVillage() and SpiralShell() and (CrescentMoonflower() or isSpringleafOpen())
end

function Mending()
    return ContinueDemonFrontier() and LunarAttunement()
end

function Resolve()
    return ContinueOldSanctuary() and LunarAttunement()
end

function Welkin()
    return CrescentMoonflower() and SpiralShell()
end

function Lunar()
    return ReachAshenHinterlands() and TradeDust()
end

function Oracle()
    return isOracle() and ReachFountOfRebirth()
end

function DoMitchi()
    return ReachDemonFrontier() or has("mitchi_fast_travel")
end

function GoldenDust()
    return ContinueOldSanctuary() and (CrescentMoonflower() and (SpiralShell() and (has("perfect_chime") or SacredAnemone())))
end

-- Lily Logic

function RestrictedLilyInKohoVillage()
    return CrescentMoonflower() and SpiralShell()
end

function RestrictedLilyInAshenHinterlands()
    return CrescentMoonflower() and SpiralShell() and LunarAttunement()
end

-- Bell Hover glitched logic

function ReachOldSanctuary_BellHover()
    return not isBellHover() and CrescentMoonflower()
end

function ContinueOldSanctuary_BellHover()
    return (ReachOldSanctuary_BellHover() or ReachOldSanctuary()) and not isBellHover() and CrescentMoonflower() and LunarAttunement()
end

function ReachDemonFrontier_BellHover()
    return ReachLunTreeRoots() and CrescentMoonflower() and not isBellHover()
end

function ReachAshenHinterlands_BellHover()
    return (ReachDemonFrontier() or ReachDemonFrontier_BellHover()) and SpiralShell() and not isBellHover() and (SacredAnemone() or has("perfect_chime"))
end

function ReachMeikanVillageWindmill_BellHover()
    return ReachMeikanVillage() and (OpenWindmill() and (CrescentMoonflower() or (SpiralShell() and not isBellHover())))
end
