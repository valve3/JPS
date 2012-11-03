function shaman_elemental(self)
   -- Heavily Updated for Mists of Pandaria by Thorshammer
   -- The shift key will let you drop earthquake where your mouse is in all modes (multi, cds, interrupt)
   -- More widespread use of totems. Will monitor this to see how DPS is in a raid.
   -- Also helpful to healers in specific situations to help with healing abilities.
   -- Tier 1: Stone Bulwark Totem
   -- Tier 2: Windwalk Totem
   -- Tier 3: Call of the Elements
   -- Tier 4: Echo of the Elements
   -- Tier 5: Healing Tide Totem
   -- Tier 6: Elemental Blast
   -- Major Glyphs: Flame Shock (required), Spiritwalker's Grace (recommended),
   -- Minor Glyphs: Thunderstorm (required)

   local spell = nil
   local lsStacks = jps.buffStacks("lightning shield")
   local focus = "focus"
   local me = "player"
   local mh, _, _, oh, _, _, _, _, _ =GetWeaponEnchantInfo()
   local executePhase = jps.hp("target") <= 0.25
   local hero = jps.buff("heroism") or jps.buff("time warp")
   
   -- Totems
   local _, fireName, _, _, _ = GetTotemInfo(1)
   local _, earthName, _, _, _ = GetTotemInfo(2)
   local _, waterName, _, _, _ = GetTotemInfo(3)
   local _, airName, _, _, _ = GetTotemInfo(4)

   local haveFireTotem = fireName ~= ""
   local haveEarthTotem = earthName ~= ""
   local haveWaterTotem = waterName ~= ""
   local haveAirTotem = airName ~= ""


   -- Miscellaneous
   local feared = jps.debuff("fear","player") or jps.debuff("intimidating shout","player") or jps.debuff("howl of terror","player") or jps.debuff("psychic scream","player")

   local spellTable = {
   
   -- Set Me Up.
      { "lightning shield",      not jps.buff("lightning shield")  },
      { "Flametongue Weapon",   not mh},
   
   --Totems
      { "searing totem",      not haveFireTotem },
      { "fire elemental totem",   jps.UseCDs },
     { "magma totem",         jps.MultiTarget and not "fire elemental totem" },
     { "stone bulwark totem",   jps.hp() < 0.6 },
     { "grounding totem",      not haveAirTotem },
     { "capacitor totem",      jps.MultiTarget },
     { "stormlash totem",      jps.UseCDs and hero },
     
   -- Interrupts
      { "wind shear",         jps.shouldKick() },

   -- Break fear.
      { "tremor totem",       feared },

   -- Dwarf Racial for Bleeds.
      { jps.defRacial, jps.hp() < 0.6 or (jps.defRacial == "stoneform" and jps.debuff("rip","player")) },
   
   -- Self heal when critical
      { "healing surge",       jps.hp("player") <= 0.20, "player" },
     
   -- Earthquake
     { "earthquake", IsShiftKeyDown() ~= nil and GetCurrentKeyBoardFocus() == nil },
     
   --Rotation
      { "flame shock",         jps.debuffDuration("flame shock") < 2 },
      { "lava burst",         jps.debuff("flame shock") },
     { "elemental blast" },
      { "ascendance",         jps.UseCDs and (jps.debuffDuration("flame shock") > 16) },   
      { "earth shock",         lsStacks > 5 and jps.debuffDuration("flame shock") > 4 },
      { "spiritwalker's grace",   jps.Moving },
      { "chain lightning",      jps.MultiTarget },
      { "thunderstorm",         jps.mana() < .6 and jps.UseCDs },
      { "lightning bolt" },
   }

    spell = parseSpellTable(spellTable)
   if spell == "earthquake" then jps.groundClick() end
   return spell

end