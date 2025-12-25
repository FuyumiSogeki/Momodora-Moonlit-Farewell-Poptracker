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

-- Hint Settings

function isHint()
    return has("scout_hint")
end

-- Tracker Settings

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

function isDoraGoal()
    return has("dora_goal")
end

-- Settings Logic

function OpenWindmill()
    return (isKeyItems() and has("windmill_key")) or not isKeyItems()
end

function TradeDust()
    return (isKeyItems() and has("gold_moonlit_dust") and has("silver_moonlit_dust")) or not isKeyItems()
end

function OpenSelin()
    return (isKeySelin() and has("progressive_final_boss_key",4)) or not isKeySelin()
end

function GetOracleReward()
    return (isFairy() and has("fairy", 30)) or (not isFairy() and ReachFountOfRebirth())
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

function ContinueSpringleafLeaf()
    return SacredLeaf() or isSpringleafOpen()
end

function ContinueSpringleafDash()
    return SacredAnemone() or isSpringleafOpen()
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
    return ReachDemonFrontier() and (SacredLeaf() or isSpringleafOpen()) and (CrescentMoonflower() or (SpiralShell() and isBellHover() and (SacredAnemone() or has("perfect_chime"))))
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

-- Sigil Logic

function Perfect()
    return SpiralShell() and (CrescentMoonflower() or isBellHover())
end

function Mending()
    return LunarAttunement()
end

function Resolve()
    return LunarAttunement()
end

function Welkin()
    return CrescentMoonflower() and SpiralShell()
end

function Lunar()
    return ReachAshenHinterlands() and TradeDust()
end

-- Location Setting Logic

function Oracle()
    return isOracle() and GetOracleReward()
end

function GoldenDust()
    return CrescentMoonflower() or (SpiralShell() and (has("perfect_chime") or SacredAnemone()))
end

-- Lily Logic

function RestrictedLilyInKohoVillage()
    return CrescentMoonflower() and SpiralShell()
end

function RestrictedLilyInFairyVillage()
    return CrescentMoonflower() or (SpiralShell() and isBellHover())
end

function RestrictedLilyInAshenHinterlands()
    return CrescentMoonflower() and SpiralShell()
end

-- Dotted Logic

function RestrictedDottedInLunTreeRoots()
    return SacredLeaf() or isSpringleafOpen()
end

function RestrictedDottedInDemonFrontier()
    return CrescentMoonflower()
end

function RestrictedDottedInAshenHinterlands()
    return CrescentMoonflower() and (SpiralShell() or LunarAttunement())
end

-- Lun Logic

function RestrictedLunInKohoVillage()
    return CrescentMoonflower() or SpiralShell()
end

function RestrictedLunInSpringleafPath()
    return SacredLeaf() or isSpringleafOpen() or SpiralShell()
end

function RestrictedLunInLunTreeRoots()
    return SacredLeaf() or isSpringleafOpen()
end

function RestrictedLunInAshenHinterlands()
    return CrescentMoonflower() and SpiralShell()
end

function RestrictedLunInDemonFrontier()
    return CrescentMoonflower() and SpiralShell()
end

-- Peach Logic

function RestrictedPeachInAshenHinterlands()
    return LunarAttunement()
end

-- Fairy Logic

function RestrictedFairy2InSpringleafPath()
    return CrescentMoonflower() or SpiralShell()
end

function RestrictedFairy4InLunTreeRoots()
    return isBellHover() or CrescentMoonflower() or SpiralShell()
end

function RestrictedFairyInMoonlightRepose()
    return CrescentMoonflower()
end

function RestrictedFairy5InLunTreeRoots()
    return (CrescentMoonflower() or SpiralShell()) and (has("perfect_chime") or SacredAnemone())
end

function RestrictedFairy1InFairySprings()
    return CrescentMoonflower() or (isBellHover() and (has("perfect_chime") or SacredAnemone()))
end

function RestrictedFairy2InFairySprings()
    return CrescentMoonflower() or SpiralShell()
end

function RestrictedFairy3InFairySprings()
    return isBellHover() or SpiralShell()
end

function RestrictedFairy4InFairySprings()
    return CrescentMoonflower()
end

function RestrictedFairyInFairyVillage()
    return CrescentMoonflower() or (SpiralShell() and isBellHover())
end

function RestrictedFairy4InDemonFrontier()
    return CrescentMoonflower()
end

function RestrictedFairy5InDemonFrontier()
    return CrescentMoonflower() or has("the_blessed")
end

function RestrictedFairy5InAshenHinterlands()
    return SpiralShell()
end

function RestrictedFairy4InSpringleafPath()
    return CrescentMoonflower() or SpiralShell()
end

-- Bell Hover glitched logic

function ReachOldSanctuary_BellHover()
    return not isBellHover() and (CrescentMoonflower() or SpiralShell())
end

function ContinueOldSanctuary_BellHover()
    return (ReachOldSanctuary_BellHover() or ReachOldSanctuary()) and not isBellHover() and ((CrescentMoonflower() and LunarAttunement()) or SpiralShell())
end

function ReachDemonFrontier_BellHover()
    return ReachLunTreeRoots() and ((CrescentMoonflower() and not isBellHover()) or SpiralShell())
end

function ReachAshenHinterlands_BellHover()
    return (ReachDemonFrontier() or ReachDemonFrontier_BellHover()) and SacredLeaf() and (CrescentMoonflower() or (SpiralShell() and not isBellHover() and (SacredAnemone() or has("perfect_chime"))))
end

function ContinueAshenHinterlands_BellHover()
    return (ReachAshenHinterlands() or ReachAshenHinterlands_BellHover()) and SpiralShell() and not isBellHover()
end

function ReachMeikanVillageWindmill_BellHover()
    return ReachMeikanVillage() and (OpenWindmill() and (CrescentMoonflower() or (SpiralShell() and not isBellHover())))
end

function Lunar_BellHover()
    return (ReachAshenHinterlands() or ReachAshenHinterlands_BellHover()) and TradeDust() and not isBellHover()
end

function Perfect_BellHover()
    return SpiralShell() and (CrescentMoonflower() or not isBellHover())
end

function RestrictedFairy1InFairySprings_BellHover()
    return CrescentMoonflower() or (not isBellHover() and SacredAnemone())
end

function RestrictedFairy3InFairySprings_BellHover()
    return not isBellHover() or SpiralShell()
end

function RestrictedLilyInFairyVillage_BellHover()
    return CrescentMoonflower() or (SpiralShell() and not isBellHover())
end

function RestrictedFairyInFairyVillage_BellHover()
    return CrescentMoonflower() or (SpiralShell() and not isBellHover())
end

function RestrictedFairy4InLunTreeRoots_BellHover()
    return not isBellHover() or CrescentMoonflower() or SpiralShell()
end