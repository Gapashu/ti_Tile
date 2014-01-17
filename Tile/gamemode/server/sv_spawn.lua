include("player_class/player_tile.lua")

--------------------------------
-- Set Player Class on Spawn! --
--------------------------------
function GM:PlayerInitialSpawn( ply ) 
   
    player_manager.SetPlayerClass( ply, "player_tile" )

end


------------------------------------ 
-- Set Player run class n shit    --
------------------------------------
function GM:PlayerSpawn( ply )

        player_manager.OnPlayerSpawn( ply )
        player_manager.RunClass( ply, "Spawn" )
        hook.Call( "PlayerSetModel", GAMEMODE, ply )
  
end

-------------------------------------------------
-- Set the Player Model; viewmodel + worldmodel--
-------------------------------------------------
function GM:PlayerSetModel( ply )

        local cl_playermodel = ply:GetInfo( "cl_playermodel" )
        local modelname = player_manager.TranslatePlayerModel( cl_playermodel )
        util.PrecacheModel( modelname )
        ply:SetModel( modelname )
        
end

