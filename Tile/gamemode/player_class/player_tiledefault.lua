AddCSLuaFile()
DEFINE_BASECLASS( "player_default" )

local PLAYER = {} 


PLAYER.WalkSpeed 			= 200
PLAYER.RunSpeed				= 300

function PLAYER:Spawn()
	BaseClass.Spawn( self )
end



player_manager.RegisterClass( "player_res", PLAYER, "player_default" )