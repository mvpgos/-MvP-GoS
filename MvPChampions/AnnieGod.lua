local ver = "3.04"

function AutoUpdate(data)
    if tonumber(data) > tonumber(ver) then
        PrintChat("New AnnieGod Script Version Found " .. data)
        PrintChat("Downloading update, please wait...")
        DownloadFileAsync("https://raw.githubusercontent.com/estruptum/GoS/master/AnnieGod.lua", SCRIPT_PATH .. "AnnieGod.lua", function() PrintChat("Update Complete, please 2x F6!") return end)
    else
        PrintChat("No updates found! Feel free to destroy with AnnieGod")
    end
end

GetWebResultAsync("https://raw.githubusercontent.com/estruptum/GoS/master/AnnieGod.version", AutoUpdate)
----------------

LoadGOSScript(Base64Decode("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"))

GoSTracker("AnnieGod",1)
class "GAnnie"

if FileExist(COMMON_PATH.."MixLib.lua") then
 require('MixLib')
 LoadMixLib()
else
 PrintChat("MixLib not found. Please wait for download.")
 DownloadFileAsync("https://raw.githubusercontent.com/VTNEETS/NEET-Scripts/master/MixLib.lua", COMMON_PATH.."MixLib.lua", function() PrintChat("Update Complete, please 2x F6!") return end)
end

function GAnnie:__init()
    self:LoadValues()
    self:CreateMenu()
    Callback.Add("Tick", function(myHero) self:Tick(myHero) end)
    Callback.Add("Draw", function() self:Drawings(myHero) end)
    Callback.Add("ProcessSpell", function(unit, spell) self:CheckSpell(unit, spell) self:Interrupt(unit, spell) end)
    Callback.Add("ProcessSpellComplete", function(unit, spell) self:UseE(unit, spell) end)
    Callback.Add("UpdateBuff", function(unit, buff) self:UpdateBuff(unit, buff) end)
    Callback.Add("RemoveBuff", function(unit, buff) self:RemoveBuff(unit, buff) end)
end

function GAnnie:LoadValues()
    self.Ignite = Mix:GetOtherSlot("Ignite")
    self.Flash = Mix:GetOtherSlot("Flash")
    self.data = function(spell) return myHero:GetSpellData(spell) end
    self.Q = { Range = self.data(_Q).range, Speed = 1500, Delay = 0.25, Damage = function(unit) return myHero:CalcMagicDamage(unit, 45 + 35*self.data(_Q).level + 0.8*myHero.ap) end }
    self.W = { Range = self.data(_W).range, Speed = math.huge, Delay = 0.25, Width = 80, Damage = function(unit) return myHero:CalcMagicDamage(unit, 25 + 45*self.data(_W).level + 0.85*myHero.ap) end }
    self.R = { Range = self.data(_R).range, Speed = math.huge, Delay = 0.25, Width = 250, Damage = function(unit) return myHero:CalcMagicDamage(unit, 50 + 125*self.data(_R).level + 0.8*myHero.ap) end }
    QT = TargetSelector(self.Q.maxRange, 8, DAMAGE_MAGIC)
    WT = TargetSelector(self.W.Range, 8, DAMAGE_MAGIC)
    self.W.Prediction = Spells(_W, self.W.Delay, self.W.Speed, self.W.Width, self.W.Range, false, 0, true, "cone", "Annie W", 0.25, {AnGle = 50})
    self.R.Prediction = Spells(_R, self.R.Delay, self.R.Speed, self.R.Width, self.R.Range, false, 0, true, "circular", "Annie R", 0.4)
    self.passive = 0
    self.stun = false
end

function GAnnie:CreateMenu()
  self.cfg = MenuConfig("GAnnie", "God Annie Rework")
    self.cfg:Info("info", "Script Version: 0.01")

    --[[ Combo Menu ]]--
    self.cfg:Menu("cb", "Combo")
        self.cfg.cb:Boolean("Q", "Use Q", true)
        self.cfg.cb:Boolean("W", "Use W", true)
        self.cfg.cb:Boolean("E", "Use E", true)

    --[[ Harass Menu ]]--
    self.cfg:Menu("hr", "Harass")
        self.cfg.hr:Boolean("Q", "Use Q", true)
        self.cfg.hr:Boolean("R", "Use W", true)
        self.cfg.hr:Slider("Enable", "Enable if %MP >=", 15, 1, 100, 1)

    --[[ Lane Clear Menu ]]--
    self.cfg:Menu("lc", "Lane Clear")
        self.cfg.lc:DropDown("Q", "Setting Q Mode:", 1, {"LastHit", "Always Cast"})
        self.cfg.lc:Slider("W", "Use W if hit Minions >=", 3, 1, 10, 1)
        self.cfg.lc:Boolean("eb", "LaneClear but save stun", true)
        self.cfg.lc:Slider("Enable", "Enable if %MP >=", 15, 1, 100, 1)

    --[[ LastHit Clear Menu ]]--
    self.cfg:Menu("lh", "LastHit")
        self.cfg.lh:DropDown("Q", "Setting Q Mode:", 1, {"Always", "Cast but save stun"})
        self.cfg.lh:Slider("Enable", "Enable if %MP >=", 15, 1, 100, 1)

    --[[ Jungle Clear Menu ]]--
    self.cfg:Menu("jc", "Jungle Clear")
        self.cfg.jc:Boolean("Q", "Use Q", true)
        self.cfg.jc:Boolean("W", "Use W", true)

    --[[ KillSteal Menu ]]--
    self.cfg:Menu("ks", "Kill Steal")
        self.cfg.ks:Boolean("Q", "Use Q", true)
        self.cfg.ks:Boolean("W", "Use W", true)
        if self.Ignite ~= nil then self.cfg.ks:Boolean("ignite", "Use Ignite", true) end
        self.cfg.ks:Slider("Enable", "Enable if %MP >=", 15, 1, 100, 1)

    --[[ Ultimate Menu ]]--
    self.cfg:Menu("ult", "Ultimate Settings")
      self.cfg.ult:DropDown("u1", "Casting Mode", 1, {"If Killable", "If can stun x enemy"})
      self.cfg.ult:Slider("u2", "R if can stun:", 2, 1, 5, 1)
      if self.Flash ~= nil then
        self.cfg.ult:Menu("fult", "Flash and Ultimate")
        self.cfg.ult.fult:Boolean("eb1", "Enable?", false)
        self.cfg.ult.fult:DropDown("eb2", "Active Mode: ", 1, {"Use when Combo Active", "Auto Use"})
        self.cfg.ult.fult:Slider("x1", "If can stun x enemy", 3, 1, 5, 1)
        self.cfg.ult.fult:Slider("x2", "If ally around >=", 1, 0, 5, 1)
      end

    --[[ Drawings Menu ]]--
    self.cfg:Menu("dw", "Drawings Mode")
        self.cfg.dw:Boolean("Q", "Draw Q Range", true)
        self.cfg.dw:Boolean("W", "Draw W Range", true)
        self.cfg.dw:Boolean("R", "Draw R Range", true)
        self.cfg.dw:Boolean("lh", "Draw Q LastHit", true)
        self.cfg.dw:Boolean("HB", "Draw Dmg On HP Bar", true)
        self.cfg.dw:Slider("Qlt", "Range Quality", 40, 1, 100, 1)

    --[[ Misc Menu ]]--
    self.cfg:Menu("misc", "Misc Mode")  
      self.cfg.misc:Menu("E", "E Setting")
        self.cfg.misc.E:Boolean("eb1", "Auto E to update stacks", false)
        self.cfg.misc.E:Slider("eb2", "Auto E if %MP > ", 50, 1, 100, 1)
        self.cfg.misc.E:Boolean("eb3", "Auto E if need 1 stack to stun", true)
      self.cfg.misc:Menu("hc", "Spell HitChance")
        self.cfg.misc.hc:Slider("Q", "Q Hit-Chance", 25, 1, 100, 1)
        self.cfg.misc.hc:Slider("W", "W Hit-Chance", 30, 1, 100, 1)
        self.cfg.misc.hc:Slider("R", "R Hit-Chance", 40, 1, 100, 1)
      self.cfg.misc:Menu("Interrupt", "Interrupt With Q")

    DelayAction(function()
    local str = {[_Q] = "Q", [_W] = "W", [_E] = "E", [_R] = "R"}
     for i, spell in pairs(CHANELLING_SPELLS) do
      for _,k in pairs(GetEnemyHeroes()) do
       if spell["Name"] == k.charName then
        self.cfg.misc.Interrupt:Boolean(k.charName.."Inter", "On "..k.charName.." "..(type(spell.Spellslot) == 'number' and str[spell.Spellslot]), true)
       end
      end
     end
    end, 1)
end

function GAnnie:CastR(target)
   if not ValidTarget(target, self.R.Range) then return end
    self.R.Prediction:GetHitChance(self.cfg.misc.hc.R:Value()/100)
    self.R.Prediction:Cast1(target)
end

function GAnnie:CastQ(target)
   if not ValidTarget(target, self.Q.Range) then return end
     CastTargetSpell(target, _Q)
end

function GAnnie:CastW(target)
   if not ValidTarget(target, self.W.Range) then return end
    self.W.Prediction:GetHitChance(self.cfg.misc.hc.W:Value()/100)
    self.W.Prediction:Cast1(target)
end

function GAnnie:FlashR()
    if EnemiesAround(myHero.pos, self.R.Range) == 0 and EnemiesAround(myHero.pos, self.R.Range + 420) > 0 and AlliesAround(myHero.pos, self.R.Range) >= self.cfg.ult.fult.x2:Value() then
      local pos, hit = self:GetRCastPos(self.R.Width, self.R.Range + 420)
      if hit >= self.cfg.ult.fult.x1:Value() then
        CastSkillShot(self.Flash, pos)
        if GetDistance(pos) <= self.R.Range then CastSkillShot(_R, pos) end
      end
    end
end

function GAnnie:CheckR()
    if self.cfg.ult.u1:Value() == 1 then
      local target = self:GetRTarget()
      if target and (IsReady(_Q) == false or (IsReady(_Q) and ValidTarget(target, self.Q.Range) and target.health > self.Q.Damage(target))) and (IsReady(_W) == false or (IsReady(_W) and ValidTarget(target, self.W.Range) and target.health > self.W.Damage(target))) then self:CastR(target) end
    elseif self.cfg.ult.u1:Value() == 2 then
      local pos, hit = self.GetRCastPos(self.R.Width, self.R.Range)
      if hit >= self.cfg.ult.u2:Value() then CastSkillShot(_R, pos) end
    end
end

function GAnnie:Tick(myHero)
   if myHero.dead then return end
    if IsReady(_Q) then QTarget = QT:GetTarget() end
    if IsReady(_W) then WTarget = WT:GetTarget() end
    if Mix:Mode() == "Combo" then
      if IsReady(_Q) and self.cfg.cb.Q:Value() and QTarget then self:CastQ(QTarget) end
      if IsReady(_W) and self.cfg.cb.W:Value() and WTarget then self:CastW(WTarget) end
    end

    if IsReady(_R) then
      self:CheckR()
      if self.cfg.ult.fult.eb1:Value() and ((self.cfg.ult.fult.eb2:Value() == 1 and Mix:Mode() == "Combo") or self.cfg.ult.fult.eb2:Value() == 1) then self:FlashR() end
    end

    if IsReady(_E) and self.cfg.misc.E.eb1:Value() and EnemiesAround(myHero.pos, 1500) == 0 and not self.stun then CastSpell(_E) end

    if Mix:Mode() == "Harass" and self.cfg.hr.Enable:Value() <= GetPercentMP(myHero) then
      if IsReady(_Q) and self.cfg.cb.Q:Value() and QTarget then self:CastQ(QTarget) end
      if IsReady(_W) and self.cfg.cb.W:Value() and WTarget then self:CastW(WTarget) end
    end

    if Mix:Mode() == "LaneClear" then
      if self.cfg.lc.Enable:Value() <= GetPercentMP(myHero) then self:LaneClear() end
	  self:JungleClear()
    end

    if Mix:Mode() == "LastHit" then
      if self.cfg.lh.Enable:Value() <= GetPercentMP(myHero) and (self.cfg.lh.Q:Value() == 1 or (self.cfg.lh.Q:Value() == 2 and self.stun == false)) and IsReady(_Q) then self:LastHit() end
    end

    if self.cfg.ks.Enable:Value() <= GetPercentMP(myHero) then self:KillSteal() end
end

function GAnnie:KillSteal()
    for i, enemy in pairs(GetEnemyHeroes()) do	
     if self.Ignite and IsReady(self.Ignite) and 20*GetLevel(myHero)+50 > (enemy.health + enemy.shieldAD) + enemy.hpRegen*2.5 and ValidTarget(enemy, 600) then
       if self.cfg.ks.ignite:Value() then CastTargetSpell(enemy, self.Ignite) end
     end

     if IsReady(_W) and self.cfg.ks.W:Value() and (enemy.health + enemy.shieldAD + enemy.shieldAP) < self.W.Damage(enemy) then 
      self:CastW(enemy)

     elseif IsReady(_Q) and self.cfg.ks.Q:Value() and (enemy.health + enemy.shieldAD + enemy.shieldAP) < self.Q.Damage(enemy) then 
      self:CastQ(enemy)
     end
    end
end

function GAnnie:LastHit()
    for M=1, minionManager.maxObjects do
    local minion = minionManager.objects[M]
      if minion.team == MINION_ENEMY and ValidTarget(minion, self.Q.Range) and minion.name:lower():find("minion_") then
        if Mix:HealthPredict(minion, 1000*(self.Q.Delay + GetDistance(minion)/self.Q.Speed), "OW") > 0 and self.Q.Damage(minion) > Mix:HealthPredict(minion, 1000*(self.Q.Delay + GetDistance(minion)/self.Q.Speed), "OW") then
          CastTargetSpell(minion, _Q)
		end
      end
    end
end

function GAnnie:LaneClear()
    for m, minion in pairs(minionManager.objects) do
      if ((self.cfg.lc.eb:Value() and self.stun == false) or self.cfg.lc.eb:Value() == false) and minion.team == MINION_ENEMY and ValidTarget(minion, self.Q.Range) and minion.name:lower():find("minion_") then
        if IsReady(_Q) and self.cfg.lc.Q:Value() == 1 then self:LastHit()
        elseif IsReady(_Q) and self.cfg.lc.Q:Value() == 2 then CastTargetSpell(minion, _Q) end
        if IsReady(_W) then
          local pos, hit = self:GetWCastPos(self.W.Width, self.W.Range)
          if hit >= self.cfg.lc.W:Value() then CastSkillShot(_W, pos) end
        end
      end
    end
end

function GAnnie:JungleClear()
    local mob = Mix:GetMob(self.Q.Range)
    if mob then
      if IsReady(_W) and self.cfg.jc.W:Value() and ValidTarget(mob, self.W.Range) then
        CastSkillShot(_W, GetConicAOEPrediction(mob, { delay = self.W.Delay, speed = self.W.Speed, width = self.W.Width, range = self.W.Range, angle = 50 }).castPos)
      end
      if IsReady(_Q) and ValidTarget(mob, self.Q.Range) then
        CastTargetSpell(mob, _Q)
      end
    end
end

function GAnnie:UseE(unit, spell)
    if self.cfg.cb.E:Value() and unit.dead == false and unit.team ~= myHero.team and unit.type == myHero.type then
      if spell.name:lower():find("attack") and spell.target.networkID == myHero.networkID and IsReady(_E) then
        CastSpell(_E)
      end
     end
end

function GAnnie:CheckSpell(unit, spell)
    if unit.dead == false and unit.networkID == myHero.networkID then
      if spell.name:lower() == "disintegrate" and self.passive == 3 and spell.target.type == myHero.type and IsReady(_E) then
        CastSpell(_E)
      end
    end  
end

function GAnnie:Drawings(myHero)
    if myHero.dead then return end
    if self.cfg.dw.HB:Value() then self:DmgHPBar() end
    self:DrawRange()
end

function GAnnie:DrawRange()
    local Pos = myHero.pos
    if IsReady(_Q) and self.cfg.dw.Q:Value() then DrawCircle3D(Pos.x, Pos.y, Pos.z, self.Q.Range, 1, 0x8000F5FF, self.cfg.dw.Qlt:Value()) end
    if IsReady(_W) and self.cfg.dw.W:Value() then DrawCircle3D(Pos.x, Pos.y, Pos.z, self.W.Range, 1, 0x80BA55D3, self.cfg.dw.Qlt:Value()) end
    if IsReady(_R) and self.cfg.dw.R:Value() then DrawCircle3D(Pos.x, Pos.y, Pos.z, self.R.Range, 1, 0x8000FFCC, self.cfg.dw.Qlt:Value()) end
    if self.cfg.dw.lh:Value() and IsReady(_Q) then
      for m, minion in pairs(minionManager.objects) do
        if minion.team == MINION_ENEMY and ValidTarget(minion, 1200) and minion.name:lower():find("minion_") then Mix:DrawCircleLastHit(minion, self.Q.Damage(minion), 1000*(self.Q.Delay + GetDistance(minion)/self.Q.Speed), ARGB(200,255,255,0), "OW") end
      end
    end
end

function GAnnie:DmgHPBar()
    for i, enemy in pairs(GetEnemyHeroes()) do
     if ValidTarget(enemy, 2000) then
      if IsReady(_R) then DrawDmgOverHpBar(enemy, enemy.health, 0, math.min(self.R.Damage(enemy), enemy.health), ARGB(255, 255, 255, 255)) end
      if IsReady(_Q) then DrawDmgOverHpBar(enemy, enemy.health, 0, math.min(self.Q.Damage(enemy), enemy.health), ARGB(255, 255, 228, 255)) end
      if IsReady(_W) then DrawDmgOverHpBar(enemy, enemy.health, 0, math.min(self.W.Damage(enemy), enemy.health), ARGB(225, 255, 255, 255)) end
     end
    end
end

function GAnnie:Interrupt(unit, spell)
    if unit.type == myHero.type and unit.team ~= myHero.team and unit.dead == false and self.stun then
      if CHANELLING_SPELLS[spell.name] then
        if ValidTarget(unit, self.Q.Range) and unit.charName == CHANELLING_SPELLS[spell.name].Name and self.cfg.misc.Interrupt[unit.charName.."Inter"]:Value() then 
          if IsReady(_Q) then CastTargetSpell(unit, _Q)
		  elseif IsReady(_W) then
		    self.W.Prediction:GetHitChance(self.cfg.misc.hc.W:Value()/100)
		    self.W.Prediction:Cast1(unit)
		  end
        end
      end
    end
end

function GAnnie:GetWCastPos(width, range)
    local Pos, Hit = nil, 0
    for i, minion in pairs(minionManager.objects) do
     if ValidTarget(minion, range, MINION_ENEMY) and minion.team == MINION_ENEMY then
      if Pos == nil then
       Pos = Vector(minion)
      elseif CountObjectsOnLineSegment(Vector(myHero), Pos, width, minionManager.objects, MINION_ENEMY) < CountObjectsOnLineSegment(Vector(myHero), Vector(minion), width, minionManager.objects, MINION_ENEMY) then
       Pos = Vector(minion)
      end
     end
    end
    Hit = CountObjectsOnLineSegment(Vector(myHero), Vector(Pos), width, minionManager.objects, MINION_ENEMY)
    return Pos, Hit
end

function GAnnie:GetRCastPos(width, range)
    local Pos, Hit = nil, 0
    for i, enemy in pairs(GetEnemyHeroes()) do
     if ValidTarget(enemy, range) then
      if Pos == nil then
       Pos = Vector(enemy)
      elseif EnemiesAround(Pos, width) < EnemiesAround(Vector(enemy), width) then
       Pos = Vector(enemy)
      end
     end
    end
    Hit = EnemiesAround(Pos, width)
    return Pos, Hit
end

function GAnnie:GetRTarget()
   local RTarget = nil
    for i, enemy in pairs(GetEnemyHeroes()) do
      if ValidTarget(enemy, self.R.Range) and enemy.health + enemy.shieldAD + enemy.shieldAP < self.Q.Damage(enemy) then
        if RTarget == nil then
          RTarget = enemy
        elseif enemy.health - self.Q.Damage(enemy) < RTarget.health - self.Q.Damage(RTarget) then
          RTarget = enemy
        end
      end
    end
        return RTarget
end

function GAnnie:UpdateBuff(unit, buff)
    if unit == myHero and unit.dead == false then
      if buff.Name == "pyromania" then
        self.passive = buff.Count
      end
      if buff.Name == "pyromania_particle" then
        self.stun = true
      end
    end
end

function GAnnie:RemoveBuff(unit, buff)
    if unit == myHero and unit.dead == false then
      if buff.Name == "pyromania" then
        self.passive = 0
      end
      if buff.Name == "pyromania_particle" then
        self.stun = false
      end
    end
end

if myHero.charName == "Annie" then GAnnie() else PrintChat("Not loaded, Playing "..myHero.charName " now") return end
