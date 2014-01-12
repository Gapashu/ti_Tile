include("player_class/player_tile.lua")

include("shared.lua")
AddCSLuaFile("shared.lua")
local sharedfiles,sharedfolder = file.Find("gamemodes/Tile/gamemode/shared/*","GAME")
for _, file in pairs(sharedfiles) do
	include("shared/"..file)
	AddCSLuaFile("shared/"..file)
end
for _,folder in pairs(sharedfolder) do
	local subfolderfiles,subfolderfolders = file.Find("gamemodes/Tile/gamemode/shared/"..folder.."/*","GAME")
	for _,file in pairs(subfolderfiles) do
		include("shared/"..folder.."/"..file)
		AddCSLuaFile("shared/"..folder.."/"..file)
	end
end

AddCSLuaFile("cl_init.lua")
local clientfiles,clientfolder = file.Find("gamemodes/Tile/gamemode/client/*","GAME")
for _, file in pairs(clientfiles) do
	AddCSLuaFile("client/"..file)
end
for _,folder in pairs(clientfolder) do
	local subfolderfiles,subfolderfolders = file.Find("gamemodes/Tile/gamemode/client/"..folder.."/*","GAME")
	for _,file in pairs(subfolderfiles) do
		AddCSLuaFile("client/"..folder.."/"..file)
	end
end

local serverfiles,serverfolder = file.Find("gamemodes/Tile/gamemode/server/*","GAME")
for _, file in pairs(serverfiles) do
	include("server/"..file)
end
for _,folder in pairs(serverfolder) do
	local subfolderfiles,subfolderfolders = file.Find("gamemodes/Tile/gamemode/server/"..folder.."/*","GAME")
	for _,file in pairs(subfolderfiles) do
		include("server/"..folder.."/"..file)
	end
end

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

