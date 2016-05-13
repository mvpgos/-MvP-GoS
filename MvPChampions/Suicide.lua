local version = "0.01"
function AutoUpdate(data)
    if tonumber(data) > tonumber(version) then
        PrintChat("New Twisted Fate Version Found " .. data)
        PrintChat("Downloading update, please wait...")
        DownloadFileAsync("https://raw.githubusercontent.com/mvpgos/-MvP-GoS/master/MvPChampions/Suicide.lua", SCRIPT_PATH .. "SuicideBot.lua", function() PrintChat(string.format("<font color=\"#FC5743\"><b>Script Downloaded succesfully. please 2x f6</b></font>")) return end)
    end
end

GetWebResultAsync("https://raw.githubusercontent.com/mvpgos/-MvP-GoS/master/MvPChampions/Suicide.version", AutoUpdate) 
local azul
local rojo
local botaBasica = 0
local botaRapidaQueFlipas = 0

menu = MenuConfig("ThatBot", "|MvP|SuicideBot")
menu:Menu("S", "Info and more")
menu.S:Info("Ver", "Current Version: "..version.."")
menu.S:Info("s", "Have Fun using this bot")

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

PrintChat(string.format("<font color=\"#85EDD7\"><b>Thanks for using |MvP|SuicideBot, have fun reaching your dead record. </b></font>"))
