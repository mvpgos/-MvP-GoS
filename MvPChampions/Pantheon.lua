local version = "0.1"
function AutoUpdate(data)
    if tonumber(data) > tonumber(version) then
        PrintChat("New Pantheon Version Found " .. data)
        PrintChat("Downloading update, please wait...")
        DownloadFileAsync("https://raw.githubusercontent.com/mvpgos/-MvP-GoS/master/MvPChampions/Pantheon.lua", SCRIPT_PATH .. "Pantheon.lua", function() PrintChat(string.format("<font color=\"#FC5743\"><b>Script Downloaded succesfully. please 2x f6</b></font>")) return end)
    end
end
GetWebResultAsync("https://raw.githubusercontent.com/mvpgos/-MvP-GoS/master/MvPChampions/Pantheon.version", AutoUpdate)

if GetObjectName(GetMyHero()) ~= "Pantheon" then return end
if FileExist(COMMON_PATH.."MixLib.lua") then
 require('MixLib')
else
 PrintChat("MixLib not found. Please wait for download.")
 DownloadFileAsync("https://raw.githubusercontent.com/VTNEETS/NEET-Scripts/master/MixLib.lua", COMMON_PATH.."MixLib.lua", function() Print("Update Complete, please 2x F6!") return end)
end

if FileExist(SCRIPT_PATH.."Draw.lua") then
 require('Draw')
else
 PrintChat("Draw.lua not found. Please wait for download.")
 DownloadFileAsync("https://raw.githubusercontent.com/LoggeL/GoS/master/draw.lua", SCRIPT_PATH.."Draw.lua", function() PrintChat("Update Complete, please 2x F6!") return end)
end 

require('OpenPredict')
require("DamageLib")
local Pantheon = Menu("MvP Pantheon", "MvP Pantheon")
Pantheon:SubMenu("Combo", "["..myHero.charName.."] - Combo")
	Pantheon.Combo:KeyBinding("Combo", "Combo", 32)
	Pantheon.Combo:Boolean("Q","use Q", true)
	Pantheon.Combo:Boolean("W","use W", true)
	Pantheon.Combo:Boolean("E","use E", true)
	Pantheon.Combo:Boolean("items", "use items", true)
	Pantheon.Combo:DropDown("Logic", "Required Logic", 2, {"Simple Logic", "Advanced Logic", "GodLike Logic (Improving Stuff) -- choose under your own risk [kappa]"})
Pantheon:SubMenu("harass", "["..myHero.charName.."] - Harass Settings")
	Pantheon.harass:KeyBinding("harassKey", "Harass Key", string.byte("C"))
	Pantheon.harass:Boolean("useQ", "Use (Q) in Harass", true)
	Pantheon.harass:DropDown("hMode", "Harass Mode", 1, { "Q", "W+E" })
	Pantheon.harass:Slider("harassMana", "Min. Mana Percent: ", 50, 0, 100)
Pantheon:SubMenu("SubReq", "["..myHero.charName.."] - AutoLevel Settings")
 	Pantheon.SubReq:Boolean("LevelUp", "Level Up Skills", true)
    	Pantheon.SubReq:Slider("Start_Level", "Level to enable lvlUP", 1, 1, 17)
    	Pantheon.SubReq:DropDown("autoLvl", "Skill order", 1, {"Q-W-E","Q-W-Q","Q-E-W",})
    	Pantheon.SubReq:Boolean("Humanizer", "Enable Level Up Humanizer", true)
Pantheon:SubMenu("drawing", "["..myHero.charName.."] - Draw Settings")
	Pantheon.drawing:Boolean("mDraw", "Disable All Range Draws", false)
	Pantheon.drawing:Boolean("HpPer", "Draw minions under 15%HP", true)
Pantheon:SubMenu("misc", "["..myHero.charName.."] - Misc Settings")
	Pantheon.misc:Slider("skin", "Select Skin", 8, 1, 8)
for i = 0,3 do
local str = {[0] = "Q", [1] = "W", [2] = "E", [3] = "R"}
    Pantheon.drawing:Boolean(str[i], "Draw "..str[i], true)
    Pantheon.drawing:ColorPick(str[i].."c", "Drawing Color", {255, 25, 221, 175})
end
if heal then
	Pantheon:SubMenu("heal", "["..myHero.charName.."] - Summoner Heal")
		Pantheon.heal:Boolean("enable", "Use Heal", true)
		Pantheon.heal:Slider("health", "If My Health % is Less Than", 10, 0, 100)
	if realheals then
		Pantheon.heal:Boolean("ally", "Also use on ally", false)
	end
end



eAoe ={ range = 5500, delay = 2, radius = 700}
AARange = GetRange(myHero)

local Sable = 3144
local Rey = 3153
local Hextech = 3146
local Hidra = 3074
local Tiamat = 3077
local Titanic = 3748
local Youmuu = 3142
Dmg = 
	{
	[0] = function(target, source) return getdmg("Q",GetCurrentTarget(), myHero, 3) end,
	[1] = function(target, source) return getdmg("W",GetCurrentTarget(), myHero, 3) end,
	[2] = function(target, source) return getdmg("E",GetCurrentTarget(), myHero, 3) end,
	[3] = function(target, source) return getdmg("R",GetCurrentTarget(), myHero, 3) end
	}
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
	  [_R] = {range = GetCastRange(myHero, 3) + 257}
	  }

lastSkin = 0
local function SkinChanger()
	if Pantheon.misc.skin:Value() ~= lastSkin then
		lastSkin = Pantheon.misc.skin:Value()
		HeroSkinChanger(myHero, Pantheon.misc.skin:Value() -1)
	end
end

local function Under15()
	if Pantheon.drawing.HpPer:Value() then
		for i, minion in ipairs(minionManager.objects) do
            if GetTeam(minion) ~= myHero.team and not minion.dead then
            	if GetDistance(minion) <= 2193-142+150-123+166 then
	            	if GetPercentHP(minion) <= 15 then
	            		DrawCircle(minion.pos, 43, 2, 100, GoS.Red)
	            	end
	            end
            end
        end
        for i, enemy in ipairs(GetEnemyHeroes()) do
        	if GetDistance(enemy) <= 2193-142+150-123+166 then
        		if GetPercentHP(enemy) <= 15 and not enemy.dead then
	            	DrawCircle(enemy.pos, 60, 2, 100, GoS.Green)
	            end
	        end
	    end
    end
end

function isLow(what, unit, slider)
	if what == 'Mana' then
		if unit.mana < (unit.maxMana * (slider / 100)) then
			return true
		else
			return false
		end
	elseif what == 'HP' then
		if unit.health < (unit.maxHealth * (slider / 100)) then
			return true
		else
			return false
		end
	end
end

local function SkillDrawings()
	if not Pantheon.drawing.mDraw:Value() then
		for i,s in pairs({"Q","W","E","R"}) do
			if Pantheon.drawing[s]:Value() then
				DrawCircle(myHero.pos, SpellRanges[i-1].range+31, 2, 100, Pantheon.drawing[s.."c"]:Value())
			end
		end
	end
end

local function AutoSkillLevelUp()
	if GetLevel(myHero) < 19 then
		if Pantheon.SubReq.LevelUp:Value() and GetLevelPoints(myHero) >= 1 and GetLevel(myHero) >= Pantheon.SubReq.Start_Level:Value() then
		    if Pantheon.SubReq.Humanizer:Value() then
		        DelayAction(function() LevelSpell(LevelUpTable[Pantheon.SubReq.autoLvl:Value()][GetLevel(myHero)-GetLevelPoints(myHero)+1]) end, math.random(0.3286,1.33250))
		    else
		        LevelSpell(LevelUpTable[Pantheon.SubReq.autoLvl:Value()][GetLevel(myHero)-GetLevelPoints(myHero)+1])
		    end
		end
	end
end

local sAllies = GetAllyHeroes()
local function HealSlot()
	if GetCastName(myHero, SUMMONER_1):lower():find("summonerheal") then
		realheals = true
	end
	if GetCastName(myHero, SUMMONER_1):lower():find("summonerheal") then
		return SUMMONER_1
	elseif GetCastName(myHero, SUMMONER_2):lower():find("summonerheal")  then
		return SUMMONER_2
	end
end

heal = HealSlot()

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

local function HealMeHealAlly()
	if heal then
		if ValidTarget(GetCurrentTarget(), 1000) then
			if Settings.heal.enable:Value() and CanUseSpell(myHero, heal) == READY then
				if GetLevel(myHero) > 5 and GetCurrentHP(myHero)/GetMaxHP(myHero) < Settings.heal.health:Value() /100 then
					CastSpell(heal)
				elseif  GetLevel(myHero) < 6 and GetCurrentHP(myHero)/GetMaxHP(myHero) < (Settings.heal.health:Value()/100)*.75 then
					CastSpell(heal)
				end
					
				if realheals and Settings.heal.ally:Value() then
					local ally = self:findClosestAlly(myHero)
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

local function QReady()
	return CanUseSpell(myHero, _Q) == READY 
end

local function WReady()
	return CanUseSpell(myHero, _W) == READY
end

local function EReady()
	return CanUseSpell(myHero, _E) == READY
end

local function RReady()
	return CanUseSpell(myHero, _R) == READY
end

local function CastQ(unit)
	CastTargetSpell(unit, _Q)
end	

local function CastW(unit)
	CastTargetSpell(unit, _W)
end

local function CastE(unit)
	CastTargetSpell(unit, _E) --Yes i know it is a skillshot but i prefer doing it like this
end

local function CastR(unit)
	local rAOE = GetCircularAOEPrediction(enemy, eAoe)
	if ValidTarget(enemy, GetCastRange(myHero, 3)) and Ready(3) and rAOE.hitChance >= 0.10 and rAOE then
		Mix:BlockMovement(true) 
		Mix:BlockAttack(true) 
		Mix:BlockOrb(true)
		CastSkillShot(3, rAOE.castPos)
	elseif not Ready(3) then
		Mix:BlockMovement(false) 
		Mix:BlockAttack(false) 
		Mix:BlockOrb(false)
	end
end

local function InAA(unit)
	if GetDistance(unit,myHero) <= AARange then
		AttackUnit(unit)
	end
end

local function WhileTarget(itemID, unit)
	if GetItemSlot(myHero, itemID) > 0 then
		if not unit then unit = myHero end
		if CanUseSpell(myHero, GetItemSlot(myHero, itemID)) == READY then
			CastTargetSpell(unit, GetItemSlot(myHero, itemID))
		end
	end
end

local function GotItemReady(itemID)
	if GetItemSlot(myHero, itemID) > 0 then
		if CanUseSpell(myHero, GetItemSlot(myHero, itemID)) == READY then	
			return true
		else 
			return false
		end
	else 
		return false
	end
end

local function CastOffensiveItems2(unit)
	WhileTarget(3077)
	WhileTarget(3074)
	WhileTarget(3144, unit)
	WhileTarget(3153, unit)
	WhileTarget(3146, unit)
	WhileTarget(3748)
	WhileTarget(3142)
end

local function Harass(unit)
	Target = GetCurrentTarget()
	if KeyIsDown(Pantheon.harass.harassKey:Key()) then
		if ValidTarget(unit, 600) and unit ~= nil then
			if not isLow('Mana', myHero, Pantheon.harass.harassMana:Value()) then
				--- Harass Mode 1 Q ---
				if Pantheon.harass.hMode:Value() == 1 then
					if QReady() then
						CastQ(Target)
					end
				end

				--- Harass Mode 2 W+E ---
				if Pantheon.harass.hMode:Value() == 2 then
					CastW(Target)
					if not WReady() then 
						CastE(Target) 
					end
				end
			end
		end
	end
end

local function Combo()
	target = GetCurrentTarget()
	if Pantheon.Combo.Combo:Value() then
		if Pantheon.Combo.Logic:Value() == 1 then
			if Pantheon.Combo.Q:Value() and QReady() and GetDistance(target) <= GetCastRange(myHero, 0) then
				CastQ(target)
			end
			if GetDistance(target, myHero) < AARange-23 and (GotItemReady(Hidra) or GotItemReady(Tiamat)) and Pantheon.Combo.items:Value() then
				CastOffensiveItems2(target)
			end
			if Pantheon.Combo.W:Value() and WReady() and GetDistance(target) <= GetCastRange(myHero, 1) then
				CastW(target)
			end
			if Pantheon.Combo.E:Value() and EReady() and GetDistance(target) <= GetCastRange(myHero, 2)-40 then
				CastE(target)
			end
			if Pantheon.Combo.Q:Value() and QReady() and GetDistance(target) <= GetCastRange(myHero, 0) then
				CastQ(target)
			end
			if GetDistance(target, myHero) < AARange-23 and (GotItemReady(Hidra) or GotItemReady(Tiamat)) and Pantheon.Combo.items:Value() then
				CastOffensiveItems2(target)
			end
		end
	end
end

local function KillSteal()
	for _, enemy in pairs(GetEnemyHeroes()) do
		if enemy ~= nil then
		local targetHP = GetCurrentHP(enemy)
			if targetHP < Dmg[0](target, myHero) and QReady() then
				CastQ(enemy)
			elseif targetHP < Dmg[1](target, myHero) and WReady() then
				CastW(enemy)
			elseif targetHP < Dmg[1](target, myHero) and EReady() then
				CastE(enemy)
			elseif targetHP < Dmg[0](target, myHero) + Dmg[1](target, myHero) and QReady() and WReady() then
				CastW(enemy)
			elseif targetHP < Dmg[0](target, myHero) + Dmg[1](target, myHero) and QReady() and EReady() then
				CastQ(enemy)
			elseif targetHP < Dmg[1](target, myHero) + Dmg[2](target, myHero) and WReady() and EReady() then
				CastW(enemy)
			end
		end
	end
end


OnUpdateBuff(function(unit, buff)
  	if unit and unit.isMe then
  		if buff.Name:lower() == "pantheonesound" then
  			BlockInput(true)
			Mix:BlockMovement(true) 
			Mix:BlockAttack(true) 
			Mix:BlockOrb(true)
		elseif buff.Name:lower() =="pantheonpassiveshield" then
			Escudo = 1
		end
	end
end)

OnRemoveBuff(function(unit, buff)
  	if unit and unit.isMe then
	  	if buff.Name:lower() == "pantheonesound" then
	  		BlockInput(false)
			Mix:BlockMovement(false) 
			Mix:BlockAttack(false) 
			Mix:BlockOrb(false)
		elseif buff.Name:lower() =="pantheonpassiveshield" then
			Escudo = 0
		end
	end
end)



local function mayor(unit)
	return GetPercentHP(myHero) < GetPercentHP(unit)
end

local function BestEnemyTarget()
	local BestEnemy = nil
	local CurrentEnemy = nil
	for i, CurrentEnemy in pairs(GetEnemyHeroes()) do
		if EnemiesAround(myHero, 1000) >= 1 then
		    if CurrentEnemy and not CurrentEnemy.dead then
			    if BestEnemy == nil then
			        BestEnemy = CurrentEnemy
				end
			    if GetCurrentHP(CurrentEnemy) < GetCurrentHP(BestEnemy) then
					BestEnemy = CurrentEnemy
		        end
		    end
		end
	end
		return BestEnemy
end

local function NothingReady()
	if not QReady() and not WReady() and not EReady() and not RReady() then
		return true
	else
		return false
	end
end 

local function UltStealWarning()
	if GetLevel(myHero) >= 6 then
		for _, enemy in pairs(GetEnemyHeroes()) do
			if enemy ~= nil and not enemy.dead then
			local targetHP = GetCurrentHP(enemy)
				if targetHP < Dmg[3](enemy, myHero) and RReady() then
					DrawLine(WorldToScreen(0, GetOrigin(myHero)).x,WorldToScreen(0, GetOrigin(myHero)).y,WorldToScreen(0, GetOrigin(enemy)).x,WorldToScreen(0, GetOrigin(enemy)).y, 18, ARGB(255, 10, 255, 10))
					DrawText("" ..enemy.charName.. " killable with R", 54, GetResolution().x/2-100, GetResolution().y/2, ARGB(211, 254, 15, 123))
				end
			end
		end
	end
end

function MayorCombo()
	QRange = GetCastRange(myHero, _Q)
	WRange = GetCastRange(myHero, _W)
	ERange = GetCastRange(myHero, _E)
	RRange = GetCastRange(myHero, _R)
	target = GetCurrentTarget()
	local escudo
	local mejor = BestEnemyTarget()
	-- a function was here
		-- another was here
			if Pantheon.Combo.Logic:Value() == 2 then
				if GetDistance(target, myHero) < AARange-23 and (GotItemReady(Hidra) or GotItemReady(Tiamat)) and Pantheon.Combo.items:Value() then
					CastOffensiveItems2(target)
				end
				if QReady() and ValidTarget(target, QRange) then
					if Escudo == 1 and EnemiesAround(myHero, 1700) == 1 then
						CastQ(target)
						DelayAction(function() InAA(target) 
						end, 0.01)
					elseif Escudo == 1 and EnemiesAround(myHero, 1700) > 2 then
						if mejor and not mejor.dead then
							CastQ(mejor)
							DelayAction(function() InAA(mejor) 
							end, 0.01)
						end
					elseif EnemiesAround(myHero, 1700) == 1 then
						CastQ(target)
						DelayAction(function() InAA(target) 
						end, 0.012)
					elseif Escudo == 0 and EnemiesAround(myHero, 1700) > 2 then
						if mejor and mejor.dead then
							CastQ(mejor)
							DelayAction(function() InAA(mejor) 
							end, 0.012)
						end
					end
				end
				if WReady() and ValidTarget(target, WRange) then
					if GetDistance(target) > WRange then
						for i,minion in pairs(minionManager.objects) do
							if GetTeam(minion) ~= myHero.team then
								if GetDistance(target, minion) < WRange then
									CastW(minion)
								end
							end
						end
					end
					if Escudo == 1 and EnemiesAround(myHero, 1700) == 1 then
						CastW(target)
					elseif Escudo == 1 and EnemiesAround(myHero, 1700) > 2 then
						if mejor and not mejor.dead then
							CastW(mejor)
							DelayAction(function() InAA(mejor) 
							end, 0.01)
						end
					elseif Escudo == 0 and EnemiesAround(myHero, 1700) == 1 then
						CastW(target)
						DelayAction(function() InAA(target) 
						end, 0.01)
					elseif Escudo == 0 and EnemiesAround(myHero, 1700) > 2 then
						if mejor and mejor.dead then
							CastW(mejor)
							DelayAction(function() InAA(mejor) 
							end, 0.01)
						end
					end
				end
				if EReady() and ValidTarget(target, ERange) then
						if Escudo == 1 and EnemiesAround(myHero, 1700) == 1 then
							CastE(target)
						elseif Escudo == 1 and EnemiesAround(target, 1700) > 2 then
							if mejor and not mejor.dead then
								CastE(mejor)
								DelayAction(function() InAA(mejor) 
								end, 0.01)
							end
						elseif Escudo == 0 and EnemiesAround(myHero, 1700) == 1 then
							CastE(target)
							DelayAction(function() InAA(target) 
							end, 0.01)
						elseif Escudo == 0 and EnemiesAround(myHero, 1700) > 2 then
							if mejor and mejor.dead then
								CastE(mejor)
								DelayAction(function() InAA(mejor) 
								end, 0.01)
							end
						end
				end
				if RReady() and ValidTarget(mejor, RRange) then
					if GetDistance(mejor) <= 2000 and GetDistance(mejor) >= 1500 then
						CastR(mejor)
					elseif GetDistance(mejor) >= 2001 and (GetCurrentHP(mejor)-Dmg[3](mejor, myHero)) <= 0 then
						CastR(mejor)
					end
				end
			elseif Pantheon.Combo.Logic:Value() == 3 then
				-- a function was here
					if GetDistance(target) > WRange then
						for i,minion in pairs(minionManager.objects) do
							if GetTeam(minion) ~= myHero.team then
								if GetDistance(target, minion) < WRange then
									CastW(minion)
								end
							end
						end
					end
				-- a function was here aswell kappa 
							if Escudo == 1 and EnemiesAround(myHero, 1700) == 1 then
								CastW(target)
								DelayAction(function() InAA(target) 
								end, 0.01)
							elseif Escudo == 1 and EnemiesAround(myHero, 1700) > 2 then
								if mejor and not mejor.dead then
									CastW(mejor)
									DelayAction(function() InAA(mejor) 
									end, 0.01)
								end
							elseif Escudo == 0 and EnemiesAround(myHero, 1700) == 1 then
								CastW(target)
								DelayAction(function() InAA(mejor) 
								end, 0.01)
							elseif Escudo == 0 and EnemiesAround(myHero, 1700) > 2 then
								if mejor and mejor.dead then
									CastW(mejor)
									DelayAction(function() InAA(mejor) 
									end, 0.01)
								end
							end
						if QReady() and GetDistance(target) < QRange then
							if Escudo == 1 and EnemiesAround(myHero, 1700) == 1 then
									CastQ(target)
									DelayAction(function() InAA(target) 
									end, 0.01)
								elseif Escudo == 1 and EnemiesAround(myHero, 1700) > 2 then
									if mejor and not mejor.dead then
										CastQ(mejor)
										DelayAction(function() InAA(mejor) 
										end, 0.01)
									end
								elseif Escudo == 0 and EnemiesAround(myHero, 1700) == 1 then
									CastQ(target)
									DelayAction(function() InAA(target) 
									end, 0.01)
								elseif Escudo == 0 and EnemiesAround(myHero, 1700) > 2 then
									if mejor and mejor.dead then
										CastQ(mejor)
										DelayAction(function() InAA(mejor) 
										end, 0.01)
									end
								end							

						if not WReady() and EReady() then
							DelayAction(function()
								if GetDistance(target) < AARange-23 and (GotItemReady(Hidra) or GotItemReady(Tiamat)) and Pantheon.Combo.items:Value() then
									CastOffensiveItems2(target)
								elseif GetDistance(target) > AARange then
									CastOffensiveItems2(target)
								end
							end, 0.01)

								if Escudo == 1 and EnemiesAround(myHero, 1700) == 1 then
								CastE(target)
								elseif Escudo == 1 and EnemiesAround(myHero, 1700) > 2 then
									if mejor and not mejor.dead then
										CastE(mejor)
										DelayAction(function() InAA(mejor) 
										end, 0.01)
									end
								elseif Escudo == 0 and EnemiesAround(myHero, 1700) == 1 then
									CastE(target)
									DelayAction(function() InAA(target) 
									end, 0.01)
								elseif Escudo == 0 and EnemiesAround(myHero, 1700) > 2 then
									if mejor and mejor.dead then
										CastE(mejor)
										DelayAction(function() InAA(mejor) 
										end, 0.01)
									end
								end

						elseif not WReady() and not EReady() and QReady() then
							DelayAction(function()
								if GetDistance(target) < AARange-23 and (GotItemReady(Hidra) or GotItemReady(Tiamat)) and Pantheon.Combo.items:Value() then
									CastOffensiveItems2(target)
								elseif GetDistance(target) > AARange then
									CastOffensiveItems2(target)
								end
							end, 0.01)
							DelayAction(function()
								if QReady() and ValidTarget(target, QRange) then
									if Escudo == 1 and EnemiesAround(myHero, 1700) == 1 then
										CastQ(target)
										DelayAction(function() InAA(target) 
										end, 0.01)
									elseif Escudo == 1 and EnemiesAround(myHero, 1700) > 2 then
										if mejor and not mejor.dead then
											CastQ(mejor)
											DelayAction(function() InAA(mejor) 
											end, 0.01)
										end
									elseif Escudo == 0 and EnemiesAround(myHero, 1700) == 1 then
										CastQ(target)
										DelayAction(function() InAA(target) 
										end, 0.01)
									elseif Escudo == 0 and EnemiesAround(myHero, 1700) > 2 then
										if mejor and mejor.dead then
											CastQ(mejor)
											DelayAction(function() InAA(mejor) 
											end, 0.01)
										end
									end
								end
							end, math.random(0.01,0.03))
						elseif not EReady() and QReady() and WReady() then
							if ValidTarget(target, 600+(GetHitBox(target)*0.5)-(GetHitBox(myHero)*0.5)) then

									if Escudo == 1 and EnemiesAround(myHero, 1700) == 1 then
									CastE(target)
									elseif Escudo == 1 and EnemiesAround(myHero, 1700) > 2 then
										if mejor and not mejor.dead then
											CastE(mejor)
											DelayAction(function() InAA(mejor) 
											end, 0.01)
										end
									elseif Escudo == 0 and EnemiesAround(myHero, 1700) == 1 then
										CastE(target)
										DelayAction(function() InAA(target) 
										end, 0.01)
									elseif Escudo == 0 and EnemiesAround(myHero, 1700) > 2 then
										if mejor and mejor.dead then
											CastE(mejor)
											DelayAction(function() InAA(mejor) 
											end, 0.01)
										end
									end

								DelayAction(function()
									if Escudo == 1 and EnemiesAround(myHero, 1700) == 1 then
										CastQ(target)
										DelayAction(function() InAA(target) 
										end, 0.01)
									elseif Escudo == 1 and EnemiesAround(myHero, 1700) > 2 then
										if mejor and not mejor.dead then
											CastQ(mejor)
											DelayAction(function() InAA(mejor) 
											end, 0.01)
										end
									elseif Escudo == 0 and EnemiesAround(myHero, 1700) == 1 then
										CastQ(target)
										DelayAction(function() InAA(target) 
										end, 0.01)
									elseif Escudo == 0 and EnemiesAround(myHero, 1700) > 2 then
										if mejor and mejor.dead then
											CastQ(mejor)
											DelayAction(function() InAA(mejor) 
											end, 0.01)
										end
									end
								end, math.random(0.001, 0.004))
							end
						elseif not QReady() and not WReady() and not EReady() and RReady() then
							if GetDistance(target) <= 2000 and GetDistance(target) >= 1500 then
								CastR(target)
							elseif GetDistance(target) >= 2001 then
								CastR(target)
							end
						elseif NothingReady() then
								InAA()
								CastOffensiveItems2(target)
						elseif EReady() then
							if Escudo == 1 and EnemiesAround(myHero, 1700) == 1 then
								CastE(target)
								elseif Escudo == 1 and EnemiesAround(myHero, 1700) > 2 then
									if mejor and not mejor.dead then
										CastE(mejor)
										DelayAction(function() InAA(mejor) 
										end, 0.01)
									end
								elseif Escudo == 0 and EnemiesAround(myHero, 1700) == 1 then
									CastE(target)
									DelayAction(function() InAA(target) 
									end, 0.01)
								elseif Escudo == 0 and EnemiesAround(myHero, 1700) > 2 then
									if mejor and mejor.dead then
										CastE(mejor)
										DelayAction(function() InAA(mejor) 
										end, 0.01)
									end
								end
							end
						end
					end
				end


OnTick(function(myHero)
if KeyIsDown(Pantheon.Combo.Combo:Key()) then
	Combo()
end

if KeyIsDown(Pantheon.Combo.Combo:Key()) then
	MayorCombo()
end
HealMeHealAlly()
AutoSkillLevelUp()
KillSteal()
Harass(GetCurrentTarget())
end)

OnDraw(function(myHero)
UltStealWarning()
SkinChanger()
Under15()
SkillDrawings()
end)
