
require("OpenPredict")
require("DamageLib")

local version = "0.1"
function AutoUpdate(data)
    if tonumber(data) > tonumber(version) then
        PrintChat("New Version Found " .. data)
        PrintChat("Downloading update, please wait...")
        DownloadFileAsync("https://raw.githubusercontent.com/mvpgos/-MvP-GoS/master/MvPChampions/IllaoiGod.lua", SCRIPT_PATH .. "Illaoi.lua", function() PrintChat(string.format("<font color=\"#FC5743\"><b>Script Downloaded succesfully. please 2x f6</b></font>")) return end)
    end
end

GetWebResultAsync("https://raw.githubusercontent.com/mvpgos/-MvP-GoS/master/MvPChampions/IllaoiGod.version", AutoUpdate) 
	LevelUpTable={
			[1]={_Q,_W,_E,_W,_W,_R,_W,_Q,_W,_Q,_R,_Q,_Q,_W,_E,_R,_E,_E},

			[2]={_Q,_W,_Q,_E,_Q,_R,_Q,_E,_Q,_E,_R,_E,_E,_E,_E,_R,_W,_W},

			[3]={_Q,_E,_W,_Q,_Q,_R,_Q,_E,_Q,_E,_R,_E,_E,_W,_W,_R,_W,_W}
	}

	SpellRanges = 
	  {
	  [_Q] = {range = GetCastRange(myHero, 0)},
	  [_W] = {range = GetCastRange(myHero, 1)},
	  [_E] = {range = GetCastRange(myHero, 2)},
	  [_R] = {range = GetCastRange(myHero, 3)}
	  }

	Dmg = 
		{
		[0] = function(target, source) return getdmg("Q",GetCurrentTarget(), myHero, 3) end,
		[1] = function(target, source) return getdmg("W",GetCurrentTarget(), myHero, 3) end,
		[2] = function(target, source) return getdmg("E",GetCurrentTarget(), myHero, 3) end,
		[3] = function(target, source) return getdmg("R",GetCurrentTarget(), myHero, 3) end
	}


	Ignite = { name = "summonerdot", range = 600, slot = nil }
	local sAllies = GetAllyHeroes()
	function HealSlot()
		if GetCastName(myHero, SUMMONER_1):lower():find("summonerheal") then
			realheals = true
		end
		if GetCastName(myHero, SUMMONER_1):lower():find("summonerheal") then
			return SUMMONER_1
		elseif GetCastName(myHero, SUMMONER_2):lower():find("summonerheal")  then
			return SUMMONER_2
		end
	end

SummonerSlot = GetCastName(myHero, SUMMONER_1):lower() == "summonerboost" or GetCastName(myHero, SUMMONER_2):lower() == "summonerboost"
ignite = GetCastName(myHero, SUMMONER_1):lower() == "summonerdot" or GetCastName(myHero, SUMMONER_2):lower() == "summonerdot" or nil
heal = HealSlot()

local IllaoiMenu = MenuConfig("Illaoi", "|MvP| Illaoi")
IllaoiMenu:Menu("Combo", "["..myHero.charName.."] - Combo Settings")
	IllaoiMenu.Combo:KeyBinding("comboKey", "Combo Key", 32)
	IllaoiMenu.Combo:Boolean("cYes", "Enable Combo", true)
	IllaoiMenu.Combo:Boolean("rYes", "Use R in combo", true)
	IllaoiMenu.Combo:Slider("cEnemies", "Minimum enemies around to cast R", 1, 1, 5)
	IllaoiMenu.Combo:Slider("cLife", "Minimum % of life to cast R", 50, 1, 100)

IllaoiMenu:Menu("Harass", "["..myHero.charName.."] - Harass Settings")
	IllaoiMenu.Harass:KeyBinding("harassKey", "Combo Key", string.byte("C"))
	IllaoiMenu.Harass:Boolean("harassQ", "Use Q on Harass", true)
	IllaoiMenu.Harass:Boolean("harassW", "Use W on Harass", true)
	IllaoiMenu.Harass:Boolean("harassE", "Use E on Harass", false)

IllaoiMenu:SubMenu("ks", "["..myHero.charName.."] - KillSteal Settings")
		IllaoiMenu.ks:Boolean("killSteal", "Use Smart Kill Steal", true)
		IllaoiMenu.ks:Boolean("autoIgnite", "Auto Ignite", true)

IllaoiMenu:SubMenu("drawing", "["..myHero.charName.."] - Draw Settings")	
	IllaoiMenu.drawing:Boolean("mDraw", "Disable All Range Draws", false)
	IllaoiMenu.drawing:Boolean("Target", "Draw Circle on Target", true)
	IllaoiMenu.drawing:Boolean("Text", "Draw Text on Target", true)
	IllaoiMenu.drawing:Boolean("myHero", "Draw My Range", true)
	
for i = 0,3 do
local str = {[0] = "Q", [1] = "W", [2] = "E", [3] = "R"}
    IllaoiMenu.drawing:Boolean(str[i], "Draw "..str[i], true)
    IllaoiMenu.drawing:ColorPick(str[i].."c", "Drawing Color", {255, 25, 221, 175})
end

IllaoiMenu:SubMenu("misc", "["..myHero.charName.."] - Misc Settings")
		IllaoiMenu.misc:Slider("skinList", "Choose your skin",1, 1, 2)

IllaoiMenu:SubMenu("SubReq", "["..myHero.charName.."] - AutoLevel Settings")
    IllaoiMenu.SubReq:Boolean("LevelUp", "Level Up Skills", true)
    IllaoiMenu.SubReq:Slider("Start_Level", "Level to enable lvlUP", 1, 1, 17)
    IllaoiMenu.SubReq:DropDown("autoLvl", "Skill order", 1, {"Q-W-E","Q-W-Q","Q-E-W",})
    IllaoiMenu.SubReq:Boolean("Humanizer", "Enable Level Up Humanizer", true)

IllaoiMenu:SubMenu("Awareness", "["..myHero.charName.."] - Awareness Settings")
    IllaoiMenu.Awareness:Boolean("AwarenessON", "Enable Awareness", true)

	if heal then
		IllaoiMenu:SubMenu("heal", "["..myHero.charName.."] - Summoner Heal")
			IllaoiMenu.heal:Boolean("enable", "Use Heal", true)
			IllaoiMenu.heal:Slider("health", "If My Health % is Less Than", 10, 0, 100)
		if realheals then
			IllaoiMenu.heal:Boolean("ally", "Also use on ally", false)
		end
	end

	if ignite then
		IllaoiMenu:SubMenu("ignite", "["..myHero.charName.."] - Ignite Settings")
			IllaoiMenu.ignite:DropDown("set", "Use Smart Ignite", 2, {"OFF", "Optimal", "Aggressive", "Very Aggressive"})	
	end

	if GetCastName(myHero, SUMMONER_1):lower():find("summonerdot") then
			Ignite.slot = SUMMONER_1
		elseif GetCastName(myHero, SUMMONER_2):lower():find("summonerdot") then
			Ignite.slot = SUMMONER_2
		end

	function AutoSkillLevelUp()
		if IllaoiMenu.SubReq.LevelUp:Value() and GetLevelPoints(myHero) >= 1 and GetLevel(myHero) >= IllaoiMenu.SubReq.Start_Level:Value() then
	        if IllaoiMenu.SubReq.Humanizer:Value() then
	            DelayAction(function() LevelSpell(LevelUpTable[IllaoiMenu.SubReq.autoLvl:Value()][GetLevel(myHero)-GetLevelPoints(myHero)+1]) end, math.random(0.3286,1.33250))
	        else
	            LevelSpell(LevelUpTable[IllaoiMenu.SubReq.autoLvl:Value()][GetLevel(myHero)-GetLevelPoints(myHero)+1])
	        end
	    end
    end

	function findClosestAlly(obj)
	    local closestAlly = nil
	    local currentAlly = nil
		for i, currentAlly in pairs(sAllies) do
	        if currentAlly and not currentAlly.dead then
	            if closestAlly == nil then
	                closestAlly = currentAlly
				end
	            if GetDistanceSqr(currentAlly.pos, obj) < GetDistanceSqr(closestAlly.pos, obj) then
					closestAlly = currentAlly
	            end
	        end
	    end
		return closestAlly
	end

	function IgniteProperties(unit)
		if Ignite.ready and GetDistance(unit) < 600 then
			if IllaoiMenu.ignite.set:Value() ~= 1 then 
				if IllaoiMenu.ignite.set:Value() == 2 and KeyIsDown(IllaoiMenu.Combo.comboKey:Key()) then
					if unit.health <= 50 + (20-0.03 * myHero.level) then
						CastTargetSpell(unit, Ignite.slot)
					end
				elseif IllaoiMenu.ignite.set:Value() == 3 and KeyIsDown(IllaoiMenu.Combo.comboKey:Key()) and GetPercentHP(unit) < 30 then
					CastTargetSpell(unit, Ignite.slot)
			    elseif  IllaoiMenu.ignite.set:Value() == 4 and GetPercentHP(unit) < 70 then
			    	CastTargetSpell(unit, Ignite.slot)
			    end
			end
		end
	end

	function HealMeHealAlly()
		if heal then
			if ValidTarget(GetCurrentTarget(), 1000) then
				if Settings.heal.enable:Value() and CanUseSpell(myHero, heal) == READY then
					if GetLevel(myHero) > 5 and GetCurrentHP(myHero)/GetMaxHP(myHero) < Settings.heal.health:Value() /100 then
						CastSpell(heal)
					elseif  GetLevel(myHero) < 6 and GetCurrentHP(myHero)/GetMaxHP(myHero) < (Settings.heal.health:Value()/100)*.75 then
						CastSpell(heal)
					end
					
					if realheals and Settings.heal.ally:Value() then
						local ally = Teemo:findClosestAlly(myHero)
						if ally and not ally.dead and GetDistance(ally) < 850 then
							if  GetCurrentHP(ally)/GetMaxHP(ally) < Settings.heal.health:value()/100 then
								CastSpell(heal)
							end
						end
					end
				end
			end
		end
	end

	function CastQ(unit)
		if unit ~= nil and GetDistance(unit) <= GetCastRange(myHero, 0) and Ready(0) then
			local qPredInfo = { width = 150, delay = 0.75, speed = 3000, range = 850 }
			local qPred = GetPrediction(unit, qPredInfo)
			if qPred and qPred.hitChance >= 0.25 then
		    	CastSkillShot(0, qPred.castPos)
		    end
		end
	end

	function CastW(unit)
		if unit ~= nil and GetDistance(unit) <= GetCastRange(myHero, 1) and Ready(1) then
		    CastSpell(1)
		end
	end

	function CastE(unit)
		if unit ~= nil and GetDistance(unit) <= GetCastRange(myHero, 2) and Ready(2) then
			local ePredInfo = { width = 75, speed = 1600, range = 900, delay = 0.251 }
			local ePred = GetPrediction(unit, ePredInfo)
			if ePred and ePred.hitChance >= 0.15 and not ePred:mCollision(1) then
		    	CastSkillShot(2, ePred.castPos)
		    end
		end
	end

	function CastR(unit)
		if unit ~= nil and GetDistance(unit) <= GetCastRange(myHero, 3) and Ready(3) then
			CastSpell(3)
		end
	end

	function KillSteal()
		local target = GetCurrentTarget()
		for _, target in pairs(GetEnemyHeroes()) do
			if ValidTarget(target, 850) and target.visible then	
				if GetCurrentHP(GetCurrentTarget()) <= Dmg[0](target, myHero) then
					CastQ(target)
				elseif GetCurrentHP(GetCurrentTarget()) <= Dmg[1](target, myHero) then
					CastW(target)
				elseif GetCurrentHP(GetCurrentTarget()) <= Dmg[3](target, myHero) then
					CastR(target)
				elseif GetCurrentHP(GetCurrentTarget()) <= (Dmg[3](target, myHero) + Dmg[0](target, myHero)) then
					CastQ(target)
					CastR(target)
				end
				if IllaoiMenu.ks.autoIgnite:Value() then
					AutoIgnite(target)
				end
			end
		end
	end

	function Harass(target)
		if IllaoiMenu.Harass.harassQ:Value() then
			CastQ(target)
		end
		if IllaoiMenu.Harass.harassW:Value() then
			CastW(target)
		end
		if IllaoiMenu.Harass.harassE:Value() then
			CastE(target)
		end
	end

	function SimpleAwareness()
		DrawCircle(myHero.pos, 2300, 1, 8, ARGB(140,34,122,155))
		for _, enemy in pairs(GetEnemyHeroes()) do
				if enemy ~= nil and not enemy.dead then
					if EnemiesAround(myHero, 2300) >= 1 then
						if GetDistance(enemy) <= 2300 then
						--local V = GetOrigin(myHero) + Vector(Vector(enemy) + Vector(myHero)):normalized()*300
						--DrawText("algo", V.x)
							if GetDistance(enemy, myHero) >= 1600 then
								DrawLine(WorldToScreen(0, GetOrigin(myHero)).x,WorldToScreen(0, GetOrigin(myHero)).y,WorldToScreen(0, GetOrigin(enemy)).x,WorldToScreen(0, GetOrigin(enemy)).y,5,ARGB(130, 177, 70, 219))
							elseif GetDistance(enemy, myHero) < 1600 and GetDistance(enemy, myHero) >= 900 then
								DrawLine(WorldToScreen(0, GetOrigin(myHero)).x,WorldToScreen(0, GetOrigin(myHero)).y,WorldToScreen(0, GetOrigin(enemy)).x,WorldToScreen(0, GetOrigin(enemy)).y,5,ARGB(130, 228, 247, 103))
							elseif GetDistance(enemy, myHero) < 900 then
								DrawLine(WorldToScreen(0, GetOrigin(myHero)).x,WorldToScreen(0, GetOrigin(myHero)).y,WorldToScreen(0, GetOrigin(enemy)).x,WorldToScreen(0, GetOrigin(enemy)).y,5,ARGB(130, 250, 94, 26))
							end
						end
					end
				end
		end
	end

	function SkinChanger()
		HeroSkinChanger(myHero, IllaoiMenu.misc.skinList:Value() -1)
	end

	OnTick(function(myHero)
		Ignite.ready = (Ignite.slot ~= nil and myHero:CanUseSpell(Ignite.slot) == READY)

		AutoSkillLevelUp()
		KillSteal()
		HealMeHealAlly()
		IgniteProperties(GetCurrentTarget())
		target = GetCurrentTarget()

		if KeyIsDown(IllaoiMenu.Combo.comboKey:Key()) then
			if IllaoiMenu.Combo.cYes:Value() then
				if GetDistance(target) < 900 and GetDistance(target) > 450 then
					CastQ(target)
						DelayAction(function() 
							CastE(target)
						end, 0.0901)
				elseif GetDistance(target) < 450 then
					CastE(target)
						DelayAction(function() 
							CastQ(target)
								DelayAction(function()
									CastW(target)
								end, 0.10)
						end, 0.055)
					if GetLevel(myHero) > 6 and IllaoiMenu.Combo.rYes:Value() then
						if Ready(3) and EnemiesAround(myHero, GetCastRange(myHero, 3)) >= IllaoiMenu.Combo.cEnemies:Value() then
							for i,enemy in ipairs (GetEnemyHeroes()) do
								if not enemy.dead and GetPercentHP(enemy) < IllaoiMenu.Combo.cLife:Value() then
									CastR(target)
								end
							end
						end
					end
				end
			end
		end

		if KeyIsDown(IllaoiMenu.Harass.harassKey:Key()) then
			Harass(target)
		end
	end)

	OnDraw(function()
		if IllaoiMenu.Awareness.AwarenessON:Value() then
			SimpleAwareness()
		end

		SkinChanger()

		if not IllaoiMenu.drawing.mDraw:Value() then
				for i,s in pairs({"Q","W","E","R"}) do
				    if IllaoiMenu.drawing[s]:Value() then
				      DrawCircle(myHero.pos, SpellRanges[i-1].range, 2, 100, IllaoiMenu.drawing[s.."c"]:Value())
				    end
				end
			end
	end)
