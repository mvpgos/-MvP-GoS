local azul
local rojo
local botaBasica = 0
local botaRapidaQueFlipas = 0

OnTick(function(myHero)

	if not myHero.dead then
		--[[
		if GetDistance(Vector(396, 182.132507, 462), myHero) < 350 then
			azul = 1
		end ]]
		if GetTeam(myHero) == 100 then
			azul = 1
		elseif GetTeam(myHero) == 200 then
			rojo = 1
		end
		if azul == 1 then
			MoveToXYZ(14340, 171.977722, 14390)
		end
		--[[
		if GetDistance(Vector(14340, 171.977722, 14390), myHero) < 350 then
			rojo = 1
		end ]]
		if rojo == 1 then
			MoveToXYZ(396, 182.132507, 462)
		end
	end

	if botaBasica == 0 then
		if GetCurrentGold(myHero) <= 500 then
			BuyItem(1001)
			botaBasica = 1
		end
	end
	if botaRapidaQueFlipas == 0 then
		if GetCurrentGold(myHero) >= 1000 then
			BuyItem(3117)
			botaRapidaQueFlipas = 1
		end
	end

end)

OnDraw(function(myHero)
	DrawCircle(myHero.pos, 350, 1,32,GoS.Red)
end)

PrintChat(string.format("<font color=\"#85EDD7\"><b>Thanks for using Suicide.lua, have fun reaching your dead record. </b></font>"))
