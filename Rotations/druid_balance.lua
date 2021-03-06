-- jpganis
-- simcrafty
--TODO: add tab-dotting everything.

function druid_balance(self)
	-- bpt virtual trackers
	local Energy = UnitPower("player",SPELL_POWER_ECLIPSE)
	local Direction = GetEclipseDirection()

	if Direction == "none" then Direction = "sun" end

	-- Insect Swarm and Moonfire /fastest/ tick times.
	local isTick = 1.3
	local mfTick = 1.3

	-- Eclipse Buffs
	local sEclipse = jps.buff("eclipse (solar)")
	local lEclipse = jps.buff("eclipse (lunar)")

	-- Dot Durations
	local mfDuration = jps.debuffDuration("moonfire") - jps.castTimeLeft()
	local sfDuration = jps.debuffDuration("sunfire") - jps.castTimeLeft()
	
	-- Focus dots
	local focusDotting, focusIS, focusMF, focusSF
	if UnitExists("focus") then focusDotting = true
	else focusDotting = false end

	if focusDotting then
		focusMF = jps.debuffDuration("moonfire","focus")
		focusSF = jps.debuffDuration("sunfire","focus")
	end

	local spellTable =
	{
		{ "starfall" },
		{ "force of nature" },
		{ "sunfire", jps.Moving },
		{ "starsurge", jps.Moving and jps.buff("shooting stars") },
		{ "incarnation", sEclipse or lEclipse },
		{ "celestial alignment", ((Direction=="moon" and Energy <= 0) or (Direction=="sun" and Energy >= 0)) and (not select(5,GetTalentInfo(11,"player")) or jps.buff("Incarnation: Chosen of Elune")) },
		{ "wrath", Energy <= -70 and Direction == "moon" },
		{ "starfire", Energy >= 60 and Direction == "sun" },
		{ "moonfire", mfDuration == 0 and not jps.buff("celestial alignment") },
		{ "sunfire", sfDuration == 0 and not jps.buff("celestial alignment") },
		{ "starsurge" },
		{ "starfire", jps.buff("celestial alignment") },
		{ "starfire", Direction == "sun" },
		{ "wrath", Direction == "moon" },
		{ "moonfire", jps.Moving and sfDuration == 0 },
		{ "sunfire" , jps.Moving and mfDuration == 0 },
		{ "moonfire", jps.Moving and lEclipse },
	}

	spell = parseSpellTable( spellTable )


	if spell == "force of nature" or spell == "wild mushroom" then
		jps.groundClick()
	--	Petattack("target")
	end

	return spell
end