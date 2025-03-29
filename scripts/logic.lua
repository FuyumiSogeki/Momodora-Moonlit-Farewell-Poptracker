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

function canJumpHigh()
    return canWalljump() and canDoubleJump()
end