include("cl_locations.lua")
include("scoreboard/scoreboardmain.lua")

scoreboard = vgui.Create("Tile_Scoreboard")

local effectdata = EffectData()
effectdata:SetScale( 0 )

function GM:ScoreboardShow()
	RunConsoleCommand("pp_dof_initlength","20")
	scoreboard:UpdatePlayers()
	timer.Create("dof", 0.05, 3, function()
		util.Effect("dof_node",effectdata)
	end)
	scoreboard:AlphaTo(255,0.15,0)
	scoreboard:SetVisible(true)
	scoreboard:MakePopup()
end

function GM:ScoreboardHide()
	scoreboard:AlphaTo(0,0.3,0,function()
		scoreboard:DeselectAllPlayers()
		scoreboard:SetVisible(false)
	end)
	timer.Create("dof", 0.05, 3, function()
		DOF_Kill()
	end)
end
PrintTable(ents.FindByClass("prop_door_rotating"))
hook.Add("HUDPaint","PaintDoorLocation", function()
	local DoorPos = Vector(0,0,0)
	local pos = {}
	local dooricon = Material("materials/tile/ui/doorsymbol.png","nocull")
	for k, v in pairs(ents.FindByClass("prop_door_rotating")) do
		DoorPos = v:GetPos()
		pos = DoorPos:ToScreen()

		if v:GetNWString("DOwner") == LocalPlayer():SteamID() then
			surface.SetDrawColor( 255, 255, 255, math.Clamp(LocalPlayer():GetPos():Distance(DoorPos)-255,0,255) )
			surface.SetMaterial(dooricon)
			surface.DrawTexturedRect(pos.x-64,pos.y-64,64,64)
		end
	end
end)