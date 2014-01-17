include("shared.lua")
AddCSLuaFile("cl_init.lua")
print("sv_door")

ADoors = {}
BDoors = {}
GDoors = {}
DDoors = {}


function LoadInit()


for k,v in pairs(ents.GetAll()) do
if( v:GetClass() == "prop_door_rotating") then
v:Fire("lock","",0)

end
end

for k,v in pairs(ents.FindByName("ADoorL*")) do
table.insert(ADoors,v)
PrintTable(ADoors)
end

for k,v in pairs(ents.FindByName("ADoorM*")) do
table.insert(BDoors,v)
PrintTable(BDoors)
end




end

hook.Add("InitPostEntity","Lockthosemofodoors",LoadInit)




  
function reset(ply)

for k,v in pairs(ents.GetAll()) do

    if( v:GetClass() == "prop_door_rotating") then
        if(v:GetNWString("DOwner") == ply:SteamID() )then
            v:SetNWString("DOwner",nil)
            v:Fire("Close","",0)
            v:Fire("lock","",3)
            
            for k,v in pairs(ents.FindByName("ADoorsL*")) do
            table.insert(v,ADoors)
            end
            for k,v in pairs(ents.FindByName("ADoorsM*")) do
            table.insert(v,BDoors)
            end            


        end
    end
end

end
hook.Add( "PlayerDisconnected", "playerdisconnected", reset )


