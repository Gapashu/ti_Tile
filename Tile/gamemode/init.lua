include("shared.lua")
AddCSLuaFile("shared.lua")

include("sv_lobmusic.lua")
include("sv_location.lua")
include("sv_pool.lua")
include("sv_spawn.lua")
include("sv_tilet.lua")

AddCSLuaFile("cl_init.lua")

AddCSLuaFile("cl_cam.lua")
AddCSLuaFile("cl_kiosk.lua")
AddCSLuaFile("cl_locations.lua")
AddCSLuaFile("cl_radio.lua")

--Tile ScoreboardFiles--
AddCSLuaFile("cl_tilescoreboard.lua")
AddCSLuaFile("scoreboard/infocard.lua")
AddCSLuaFile("scoreboard/scoreboardmain.lua")
AddCSLuaFile("scoreboard/playerrow.lua")
AddCSLuaFile("scoreboard/locationboxes.lua")

resource.AddFile("materials/tile/ui/doorsymbol.png")
resource.AddFile("materials/tile/ui/tilebannernoback.png")
resource.AddFile("materials/tile/ui/icon_24.png")

if (SERVER) then

print(" _|_|_|_|_|  _|  _|               _|                                  _|                  _|  _|  ")
print("     _|          _|    _|_|       _|          _|_|      _|_|_|    _|_|_|    _|_|      _|_|_|  _|  ")
print("     _|      _|  _|  _|_|_|_|     _|        _|    _|  _|    _|  _|    _|  _|_|_|_|  _|    _|  _|  ")
print("     _|      _|  _|  _|           _|        _|    _|  _|    _|  _|    _|  _|        _|    _|      ")
print("     _|      _|  _|    _|_|_|     _|_|_|_|    _|_|      _|_|_|    _|_|_|    _|_|_|    _|_|_|  _|  ")
                                                                                                  
end



DEFINE_BASECLASS( "gamemode_base" )


function GM:InitPostEntity()
	Phel = ents.Create("Phelynx")
	Phel:SetPos(Vector(-2733,-171,368))
	Phel:Spawn()
end

util.AddNetworkString("ScoreboardUpdateAbout")
timer.Create("ScoreboardChangeAbout", 10, 0, function()
	net.Start("ScoreboardUpdateAbout")
	local rawabout = file.Read("about.txt","GAME")
	local abouts = {}
	abouts = string.Explode("||",rawabout)
	net.WriteString(table.Random(abouts))
	net.Broadcast()
end)