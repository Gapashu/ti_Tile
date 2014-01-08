include("shared.lua")
AddCSLuaFile("cl_init.lua")
print("sv_door")

ADoors = {}
PrintTable(ADoors)

function LoadInit()


for k,v in pairs(ents.GetAll()) do
if( v:GetClass() == "prop_door_rotating") then

v:Fire("lock","",0)

table.insert(ADoors,v)

end
end
end
hook.Add("InitPostEntity","Lockthosemofodoors",LoadInit)






hook.Add("PlayerUse","fvhzdub",function(ply,ent)

if(ent:GetNWString("DOwner")==ply:SteamID()) then
--ent:Fire("unlock","",0) 
end

end)


  
function reset(ply)

for k,v in pairs(ents.GetAll()) do
if( v:GetClass() == "prop_door_rotating") then

if(v:GetNWString("DOwner") == ply:SteamID() )then

v:SetNWString("DOwner",nil)
v:Fire("lock","",0)
table.insert(ADoors,v)




end
end
end
end
hook.Add( "PlayerDisconnected", "playerdisconnected", reset )


