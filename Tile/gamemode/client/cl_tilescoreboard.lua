include("tilescoreboard/scoreboard.lua")

scoreboard = vgui.Create("tileScoreboard")

function GM:ScoreboardShow()
	scoreboard:Update()
	scoreboard:Show()
end

function GM:ScoreboardHide()
	scoreboard:Hide()
end

timer.Create("TileUpdateScoreboard", 1, 0, function()

	scoreboard:Update()
	
end)