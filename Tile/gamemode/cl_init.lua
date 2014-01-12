include("shared.lua")
local shfiles,shfolder = file.Find("gamemodes/Tile/gamemode/shared/*","GAME")
for _, file in pairs(shfiles) do
	include("shared/"..file)
end

local clfiles,clfolder = file.Find("gamemodes/Tile/gamemode/client/*","GAME")
for _, file in pairs(clfiles) do
	include("client/"..file)
end