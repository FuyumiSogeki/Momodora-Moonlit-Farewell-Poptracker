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

function canOpenWindmill()
    return (isKeyItems() and has("windmill_key")) or not isKeyItems()
end

function canTradeDust()
    return (isKeyItems() and has("gold_moonlit_dust") and has("silver_moonlit_dust")) or not isKeyItems()
end

function canOpenSelin()
    return (isKeySelin() and has("progressive_final_boss_key",4) or not isKeySelin())
end

function canCutBarrier()
    return has("awakened_sacred_leaf")
end

function canRun()
    return has("sacred_anemone")
end

function canDoubleJump()
    return has("crescent_moonflower")
end

function canWallJump()
    return has("spiral_shell")
end

function canCrossFog()
    return has("lunar_attunement")
end

function canContinueSpringleaf()
    return canCutBarrier() or isSpringleafOpen()
end

function canReachLunTreeRoots()
    return canRun() or isSpringleafOpen()
end

function canReachFairySprings()
    return (canReachLunTreeRoots() and canDoubleJump()) or ((canDoubleJump() or canWallJump()) and (canRun() or isSpringleafOpen()))
end

function canReachOldSanctuary()
    return canWallJump() or (isBellHover() and canDoubleJump())
end

function canContinueOldSanctuary()
    return canReachOldSanctuary() and canWallJump()
end

function canReachDemonFrontier()
    return canReachLunTreeRoots() and (canWallJump() or (canDoubleJump() and isBellHover()))
end

function canReachAshenHinterlands()
    return canReachDemonFrontier() and (canDoubleJump() or (canWallJump() and canRun() and isBellHover()))
end

function canReachMoonlightRepose()
    return canReachLunTreeRoots() and canWallJump() and (canCutBarrier() or isSpringleafOpen())
end

function canContinueAshenHinterlands()
    return canReachAshenHinterlands() and canWallJump()
end

function canContinueDemonFrontier()
    return canReachDemonFrontier() and ((canWallJump() and canCrossFog()) or (canWallJump() and (canDoubleJump() or has("perfect_chime"))))
end

function canReachMeikanVillage()
    return canContinueDemonFrontier() and canCrossFog()
end

function canReachMeikanVillageWindmill()
    return canReachMeikanVillage() and (canOpenWindmill() and (canDoubleJump() or (canWallJump() and isBellHover())))
end

function canReachFountOfRebirth()
    return canReachMeikanVillageWindmill() and canDoubleJump() and canOpenWindmill()
end

function canReachSelin()
    return canReachFountOfRebirth() and canOpenSelin()
end

function canPerfect()
    return canReachMeikanVillage() and canWallJump() and (canDoubleJump() or isSpringleafOpen())
end

function canMending()
    return canContinueDemonFrontier() and canCrossFog()
end

function canResolve()
    return canContinueOldSanctuary() and canCrossFog()
end

function canWelkin()
    return canDoubleJump() and canWallJump()
end

function canLunar()
    return canReachAshenHinterlands() and canTradeDust()
end

function canOracle()
    return isOracle() and canReachFountOfRebirth()
end

function canDoMitchi()
    return canReachDemonFrontier() or has("mitchi_fast_travel")
end