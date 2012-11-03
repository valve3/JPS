function paladin_ret(self)
   --valve
   local hPower = UnitPower("player","9")
  local Seal_stance = GetShapeshiftForm()

--Seal_stance == 1: Seal of Truth
--Seal_stance == 2: Seal of the Righteousness
--Seal_stance == 3: Seal of Insight

   local spellTable =
   {      
{ "seal of truth", stance ~= 1 and  jps.mana() >= .9 },
 { "seal of insight", stance ~= 3  and  jps.mana() <= .3 },
   { "rebuke", jps.Interrupts and jps.shouldKick() },
{ "Hammer of the Righteous",      jps.MultiTarget },  
      { "inquisition", jps.buffDuration("inquisition") < 5 },
{ "avenging wrath", jps.UseCds },
{ "execution sentence", jps.UseCds },
  { "guardian of ancient kings", jps.UseCDs },
         { "holy avenger", jps.buff("inquisition") and hPower <= 2 },
      { "templar's verdict", hPower > 2 },
      { "hammer of wrath" },
      { "exorcism", jps.buff("the art of war") },
      { "exorcism" },
      { "crusader strike" },
      { "judgment" },
 { "templar's verdict", hPower >= 3 },  
 { "flash of light", jps.hp("player") <= 0.30, "player" },
 { "lay on hands", jps.hp("player") <= 0.10, "player" },
   }
   
   return parseSpellTable(spellTable)
end