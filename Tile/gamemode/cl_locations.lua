playerlocations = {}

net.Receive("PlayerLocations", function(len)
	playerlocations = net.ReadTable()
end)

local Ply = LocalPlayer()

function GetLocation(ply)
	if ply:IsPlayer() == false then return end
	local location = playerlocations[ply] or "Spawn"
	return location
end