include("shared.lua")
include("sv_spawn.lua")
include("sv_lobmusic.lua")
include("sv_tilet.lua")
include("sv_pool.lua")

include("player_class/player_tile.lua")

AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("cl_kiosk.lua")
AddCSLuaFile("cl_cam.lua")
AddCSLuaFile("cl_radio.lua")

if (SERVER) then

print(" _|_|_|_|_|  _|  _|               _|                                  _|                  _|  _|  ")
print("     _|          _|    _|_|       _|          _|_|      _|_|_|    _|_|_|    _|_|      _|_|_|  _|  ")
print("     _|      _|  _|  _|_|_|_|     _|        _|    _|  _|    _|  _|    _|  _|_|_|_|  _|    _|  _|  ")
print("     _|      _|  _|  _|           _|        _|    _|  _|    _|  _|    _|  _|        _|    _|      ")
print("     _|      _|  _|    _|_|_|     _|_|_|_|    _|_|      _|_|_|    _|_|_|    _|_|_|    _|_|_|  _|  ")
                                                                                                  
end



DEFINE_BASECLASS( "gamemode_sandbox" )


function GM:InitPostEntity()
	
	Phel = ents.Create("Phelynx")
	Phel:SetPos(Vector(-2733,-171,368))
	Phel:Spawn()


end

	