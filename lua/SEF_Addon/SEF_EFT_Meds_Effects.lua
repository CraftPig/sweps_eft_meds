local AffectedEffects = { "Fatigue", "DarkVision", "Stunned" }
StatusEffects.OnPainkillers = {
    Name = "On Painkillers",
    Icon = "SEF_Icons/SEF_onpainkillers.png",
    Desc = "You're on painkillers, some debuffs are delayed.",
	Type = "BUFF",
	EffectBegin = function(ent)
		if not ent.GetTime then
            ent.GetTime = {}
        end
		for _, effectName in ipairs(AffectedEffects) do
			ent.GetTime[effectName] = 0
		end
		ent.GetTimeOnPainkillers = 0 + ent:GetTimeLeft("OnPainkillers")
    end,
    Effect = function(ent, time)   
		for _, effectName in ipairs(AffectedEffects) do
			if ent:HaveEffect(effectName) then
				local remainingTime = ent:GetTimeLeft(effectName)
				ent.GetTime[effectName] = remainingTime + ent.GetTime[effectName]
				-- print(effectName .. " remaining time: " .. remainingTime)
				ent:RemoveEffect(effectName)
			end
		end
    end,
	EffectEnd = function(ent)
		-- print("Remaining time for DarkVision: " .. (ent.GetTime["DarkVision"] or "Not found"))
		
		for _, effectName in ipairs(AffectedEffects) do
			if ent.GetTime[effectName] ~= 0 then
				ent:ApplyEffect(effectName, ent.GetTime[effectName] - ent.GetTimeOnPainkillers)
			end
		end
    end
}