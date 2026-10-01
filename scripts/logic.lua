---@diagnostic disable: lowercase-global
function has(item, amount)
    local count = Tracker:ProviderCountForCode(item)
    amount = tonumber(amount)
    if not amount then
      return count > 0
    else
      return count >= amount
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

function isBerrySanity()
    return has("berry_on")
end

function isLilySanity()
    return has("lily_on")
end

function isFairySanity()
    return has("fairy_on")
end

function isCompanionSanity()
    return has("companion_on")
end

function isLunarSanity()
    return has("lunar_on")
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

function OpenOracleReward()
    return ((isFairySanity() and has("fairy", 30)) or not isFairySanity()) or FountOfRebirth()
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

-- Region Logic
function KohoVillage()
    return true
end

function SpringLeafPath()
    return KV_SP()
end

function SpringLeafPathContinued()
    return SP_SPC()
end

function OldSanctuary()
    return KV_OS()
end

function OldSanctuaryContinued()
    return OS_OSC()
end

function LunTreeRoots()
    return SPC_LTR()
end

function DemonFrontier()
    return LTR_DF()
end

function DemonFrontierContinued()
    return DF_DFC()
end

function FairySprings()
    return LTR_FS() or SPC_FS()
end

function FairyVillage()
    return FS_FV()
end

function MoonlightRepose()
    return LTR_MR()
end

function AshenHinterlands()
    return DF_AH()
end

function AshenHinterlandsContinued()
    return AH_AHC()
end

function MeikanVillage()
    return DFC_MV()
end

function MeikanVillageWindmill()
    return MV_MVW()
end

function FountOfRebirth()
    return MVW_FOR()
end

function Selin()
    return FOR_SELIN()
end

function Dora()
    return SELIN_DORA()
end

-- Connections Logic

function SP_SPC()
    return SpringLeafPath() and (SacredLeaf() or isSpringleafOpen())
end

function SPC_LTR()
    return SpringLeafPath() and (SacredAnemone() or isSpringleafOpen())
end

function SPC_FS()
    return SpringLeafPathContinued() and ((CrescentMoonflower() or SpiralShell()) and (isSpringleafOpen() or SacredAnemone()))
end

function KV_SP()
    return KohoVillage()
end

function KV_OS()
    return KohoVillage() and (SpiralShell() or (CrescentMoonflower() and (isBellHover() or LunarAttunement())))
end

function OS_OSC()
    return OldSanctuary() and (SpiralShell() or (isBellHover() and LunarAttunement() and CrescentMoonflower()))
end

function LTR_DF()
    return LunTreeRoots() and (SpiralShell() or (CrescentMoonflower() and isBellHover() and not isBerrySanity()) or (CrescentMoonflower() and isBellHover() and has("lun_berry", 1)))
end

function LTR_FS()
    return LunTreeRoots() and (CrescentMoonflower())
end

function LTR_MR()
    return LunTreeRoots() and (SpiralShell() or (CrescentMoonflower() and (isBellHover() or LunarAttunement())))
end

function DF_AH()
    return DemonFrontier() and (canAccursedAutarch() and CrescentMoonflower())
end

function DF_DFC()
    return DemonFrontier() and ((CrescentMoonflower() and (SpiralShell() or LunarAttunement())) or (SpiralShell() and (SacredAnemone() or has("perfect_chime"))))
end

function DFC_MV()
    return DemonFrontierContinued() and ((LunarAttunement() and CrescentMoonflower()) or (LunarAttunement() and SpiralShell()) or (LunarAttunement() and not isBellHover()))
end

function FS_FV()
    return FairySprings()
end

function AH_AHC()
    return AshenHinterlands() and (SpiralShell())
end

function MV_MVW()
    return MeikanVillage() and (OpenWindmill() and SpiralShell() and (CrescentMoonflower() or isBellHover()))
end

function MVW_FOR()
    return MeikanVillageWindmill() and (CrescentMoonflower() and (OpenWindmill()))
end

function FOR_SELIN()
    return FountOfRebirth() and (OpenSelin())
end

function SELIN_DORA()
    return Selin()
end

-- Locations Logic

function canSacredAnemone()
    return SpringLeafPath() and (isSpringleafOpen() or SacredLeaf())
end

function canLunarAttuenment()
    return AshenHinterlandsContinued() and (TradeDust())
end

function canServal()
    return AshenHinterlands() and (CrescentMoonflower() or ((SpiralShell() and isBellHover()) or not isBellHover()))
end

function canPerfectChime()
    return MeikanVillage() and (SpiralShell() and (isBellHover() or CrescentMoonflower()))
end

function canMendingResonance()
    return DemonFrontierContinued() and (LunarAttunement() and (CrescentMoonflower() or SpiralShell()))
end

function canResolve()
    return OldSanctuaryContinued() and (LunarAttunement())
end

function canWelkinLeaf()
    return KohoVillage() and (CrescentMoonflower() and SpiralShell())
end

function canMagicBlade()
    return DemonFrontierContinued() and (SacredLeaf())
end

function canPhantasmBlade()
    return MoonlightRepose() and (SacredLeaf())
end

function canMoonGoddessLineth()
    return FountOfRebirth()
end

function canRemnantOfAnUnknownPhantasm()
    return MoonlightRepose() and (SacredLeaf())
end

function canAccursedAutarch()
    return DemonFrontier() and (SacredLeaf())
end

function canGoldMoonlitDust()
    return OldSanctuaryContinued() and (CrescentMoonflower() or (SpiralShell() and (SacredAnemone() or has("perfect_chime"))))
end

function canSilverMoonlitDust()
    return MoonlightRepose() and (canRemnantOfAnUnknownPhantasm())
end

function canOracle()
    return FairyVillage() and OpenOracleReward()
end

function canHeavenlyLilyKohoVillage()
    return KohoVillage() and (CrescentMoonflower() and SpiralShell())
end

function canHeavenlyLily1FairyVillage()
    return FairyVillage() and (CrescentMoonflower() or (SpiralShell() and isBellHover()))
end

function canHeavenlyLily2AshenHinterlands()
    return AshenHinterlandsContinued() and (CrescentMoonflower() and SpiralShell())
end

function canHeavenlyLily3AshenHinterlands()
    return AshenHinterlandsContinued() and (CrescentMoonflower() and SpiralShell() and LunarAttunement())
end

function canHeavenlyLily3MeikanVillage()
    return MeikanVillageWindmill() and (FountOfRebirth())
end

function canHeavenlyLily2MoonlightRepose()
    return MoonlightRepose() and (canRemnantOfAnUnknownPhantasm())
end

function canDottedBerry1LunTreeRoots()
    return LunTreeRoots() and (SacredLeaf())
end

function canDottedBerry1DemonFrontier()
    return DemonFrontierContinued() and (CrescentMoonflower())
end

function canDottedBerry2AshenHinterlands()
    return AshenHinterlandsContinued() and (CrescentMoonflower() and (SpiralShell() or (LunarAttunement())))
end

function canDottedBerry3MeikanVillage()
    return MeikanVillageWindmill() and (FountOfRebirth())
end

function canDottedBerryMoonlightRepose()
    return MoonlightRepose() and (canRemnantOfAnUnknownPhantasm())
end

function canLunBerryKohoVillage()
    return KohoVillage() and (CrescentMoonflower() or SpiralShell())
end

function canLunBerrySpringleafPath()
    return SpringLeafPath() and (SacredLeaf() or SpiralShell())
end

function canLunBerryLunTreeRoots()
    return LunTreeRoots() and (SacredLeaf())
end

function canLunBerryAshenHinterlands()
    return AshenHinterlandsContinued() and (CrescentMoonflower() and SpiralShell())
end

function canLunBerryDemonFrontier()
    return DemonFrontierContinued() and (CrescentMoonflower() and SpiralShell())
end

function canLunBerryFountOfRebirth()
    return FountOfRebirth() and (Selin())
end

function canPeachAshenHinterlands()
    return AshenHinterlandsContinued() and (LunarAttunement())
end

function canPeachSpringleafPath()
    return SpringLeafPathContinued() and (isSpringleafOpen() or SacredLeaf())
end

function canPeachMoonlightRepose()
    return LunTreeRoots() and (SpiralShell() or (CrescentMoonflower() and (LunarAttunement() or isBellHover())))
end

function canBlackBerryLunTreeRoots()
    return LunTreeRoots() and (isBellHover() or CrescentMoonflower() or SpiralShell())
end

function canLumenFairy2SpringleafPath()
    return SpringLeafPath() and ((isSpringleafOpen() or SacredLeaf()) and (CrescentMoonflower() or SpiralShell()))
end

function canLumenFairy4LunTreeRoots()
    return LunTreeRoots() and (isBellHover() or CrescentMoonflower() or SpiralShell())
end

function canLumenFairyMoonlightRepose()
    return MoonlightRepose() and (CrescentMoonflower())
end

function canLumenFairy5LunTreeRoots()
    return LunTreeRoots() and (CrescentMoonflower())
end

function canLumenFairy1FairySprings()
    return FairySprings() and (CrescentMoonflower() or (isBellHover() and (SacredAnemone() or has("perfect_chime"))))
end

function canLumenFairy2FairySprings()
    return FairySprings() and (CrescentMoonflower() or SpiralShell())
end

function canLumenFairy3FairySprings()
    return FairySprings() and ((isBellHover() and CrescentMoonflower() and LunarAttunement) or SpiralShell())
end

function canLumenFairy4FairySprings()
    return FairySprings() and (CrescentMoonflower())
end

function canLumenFairyFairyVillage()
    return FairyVillage() and (CrescentMoonflower() or (SpiralShell() and isBellHover()))
end

function canLumenFairy4DemonFrontier()
    return DemonFrontier() and (CrescentMoonflower())
end

function canLumenFairy5DemonFrontier()
    return DemonFrontier() and (AshenHinterlands() and (CrescentMoonflower() or has("the_blessed")))
end

function canLumenFairy5AshenHinterlands()
    return AshenHinterlandsContinued() and (SpiralShell())
end

function canLumenFairy4SpringleafPath()
    return SpringLeafPath() and (CrescentMoonflower() or SpiralShell())
end

function canBakman()
    return SpringLeafPath() and (CrescentMoonflower() or SpiralShell())
end

function canSimpleCube()
    return LunTreeRoots() and (SpiralShell() or (CrescentMoonflower() and (LunarAttunement() or (isBellHover() and ((has("lun_berry", 3) and isBerrySanity()) or not isBerrySanity())))))
end

function canNun()
    return FountOfRebirth() and (has("crysanth") and has("fallen_hero") and has("magic_blade"))
end

function canLunarCrystalBranch4DemonFrontier()
    return DemonFrontierContinued() and (CrescentMoonflower() or SpiralShell())
end

function canLunarCrystalBranch1FairySprings()
    return FairySprings() and (CrescentMoonflower() or SpiralShell())
end

function canLunarCrystalBranchMoonlightRepose()
    return LunTreeRoots() and (SpiralShell() or (CrescentMoonflower() and (LunarAttunement() or isBellHover())))
end