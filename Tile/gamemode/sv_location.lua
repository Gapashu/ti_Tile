--[[Lobby:
	Max X: -240
	Min X: -3008 
	Max Y: 1010
	Min Y: -1010
	Max Z: 1240
	Min Z: 396
	]]--
--[[Spawn:
	Max X: 207
	Min X: -240
	Max Y: 703
	Min Y: -703
	Max Z: 390
	Min Z: 44
	]]--
tileLocations = {}
tileLocations.spawn = {}
tileLocations.spawn.max = Vector(207,703,390)
tileLocations.spawn.min = Vector(-240,-703,44)

tileLocations.lobby = {}
tileLocations.lobby.max = Vector(-240,1010,1240)
tileLocations.lobby.min = Vector(-3008,-1010,396)

tileLocations.players = {}

util.AddNetworkString("PlayerLocations")

function updatePlayerLocations()
	for _,ply in pairs(ents.FindInBox(tileLocations.spawn.min,tileLocations.spawn.max)) do
		if ply:IsPlayer() then
			tileLocations.players[ply] = "Spawn"
		end
	end
	for _,ply in pairs(ents.FindInBox(tileLocations.lobby.min,tileLocations.lobby.max)) do
		if ply:IsPlayer() then
			tileLocations.players[ply] = "Lobby"
		end
	end
	for ply,location in pairs(tileLocations.players) do
		if !ply:IsValid() then tileLocations.players[ply] = nil end
		table.RemoveByValue(tileLocations.players, nil)
	end

	net.Start("PlayerLocations")
	net.WriteTable(tileLocations.players)
	net.Broadcast()
end
updatePlayerLocations()

timer.Create("UpdatePlayerLocations", 0.25, 0, function()
	updatePlayerLocations()
end)

hook.Add("PlayerSpawn","UpdatePlayerLocations",function(ply)
	updatePlayerLocations()
end)