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
    return canWallJump()
end

function canReachDemonFrontier()
    return canReachLunTreeRoots() and (canWallJump() or (canDoubleJump() and isBellHover()))
end

function canReachAshenHinterlands()
    return canReachDemonFrontier() and (canDoubleJump() or (canWallJump() and isBellHover()))
end

function canReachMoonlightRepose()
    return canReachLunTreeRoots() and canWallJump()
end

function canContinueAshenHinterlands()
    return canReachAshenHinterlands() and canWallJump()
end

function canContinueDemonFrontier()
    return canReachDemonFrontier() and (canWallJump() and (canDoubleJump() or has("perfect_chime")))
end

function canReachMeikanVillage()
    return canContinueDemonFrontier() and canCrossFog()
end

function canReachMeikanVillageWindmill()
    return canReachMeikanVillage() and (canDoubleJump() or (canWallJump() and isBellHover()))
end

function canReachFountOfRebirth()
    return canReachMeikanVillageWindmill() and canDoubleJump()
end

function canMending()
    return canContinueDemonFrontier() and canCrossFog()
end

function canResolve()
    return canReachOldSanctuary() and canCrossFog()
end

function canWelking()
    return canDoubleJump() and canWallJump()
end

function canDark()
    return CanWallJump() and (canDoubleJump() or has("perfect_chime"))
end