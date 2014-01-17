AddCSLuaFile( "cl_init.lua" ) 
AddCSLuaFile( "shared.lua" )

include("shared.lua") 
include("sv_door.lua")


local meta = FindMetaTable("Player")
if CLIENT then return end

if SERVER then

end


A_PRICE = 10
B_PRICE = 10

ADoors = {}
BDoors = {}

PrintTable(ADoors)

function ENT:Initialize()

self:SetModel( "models/Humans/Group02/Female_04.mdl" ) 
self:SetHullType( HULL_HUMAN ) 
self:SetHullSizeNormal( )
self:SetNPCState( NPC_STATE_SCRIPT )
self:SetSolid(  SOLID_BBOX ) 
self:CapabilitiesAdd( CAP_TURN_HEAD and CAP_ANIMATEDFACE ) 
self:SetUseType( SIMPLE_USE )
self:DropToFloor()
 self:SetMaxYawSpeed( 900 ) 

end
          

function ENT:Think()

for _,ent in pairs(ents.FindInSphere(self:GetPos(),300)) do
if ent:GetClass() == "player" then
Yaw = (ent:GetPos() - self:GetPos()):Angle().yaw
a = math.ApproachAngle(self:GetAngles().yaw,Yaw,10)
self:SetAngles(Angle(0,a,0))

end
end



end
 
function ENT:OnTakeDamage()

end


function ENT:AcceptInput( Name, Activator, Caller )

if Name == "Use" and Caller:IsPlayer() then

self:EmitSound("vo/npc/female01/hi02.wav",100,100)
Caller:SendLua("chat.AddText(Color(255,0,0),'[Phelynx]',Color(0,160,200),'Would you like to buy an apartment or load you room?' )")
Caller:SendLua("chat.AddText(Color(255,140,0),'I have ','"..#ADoors.."',' Alpha rooms left!' )")
Caller:SendLua("chat.AddText(Color(255,140,0),'I have ','"..#BDoors.."',' Beta rooms left!' )")


Caller:SendLua("Rents()")
end

end


hook.Add("PlayerInitialSpawn","Points",function(ply)

if(ply:GetPData("tilet"))== nil then
ply:SetPData("tilet",20)
ply:SetPData("OwnAlphaApartment",false)
ply:SetPData("OwnBetaAPartment",false)
ply:SetNWInt("Apartmentloaded",0)
end



end)

function GiveApartment(ply,type)

if(!ply) then return end
if(!type) then return end

if(type == "Alpha" ) then
Door = table.Random(ADoors)
Door:SetNWString("DOwner",ply:SteamID())
table.remove(ADoors,table.KeyFromValue(ADoors,Door))
end


if(type == "Beta" ) then
Door = table.Random(BDoors)
Door:SetNWString("DOwner",ply:SteamID())
table.remove(BDoors,table.KeyFromValue(BDoors,Door))
end

end



function BuyAlpha(ply,cmd,arg)

if(  ply:GetPData("OwnBetaApartment")  == true ) then print("ownsbta") return end
if(  ply:GetPData("OwnAlphaApartment") == true ) then print("ownsalpha") return end
if(  ply:GetNWInt("Apartmentloaded")   == 1    ) then print("apartmentwasloaded") return end
if( tonumber(ply:GetPData("tilet")) < A_PRICE-1 ) then print("cantafford") return end

ply:SetPData("OwnAlphaApartment",true)
ply:Give("keys")
GiveApartment(ply,"Alpha")
ply:SendLua("chat.AddText(Color(0,160,255),'Thanks for buying an Alpha Apartment :)')")


end
concommand.Add("BuyAlphaApartment",BuyAlpha)

function BuyBeta(ply,cmd,arg)

if(  ply:GetPData("OwnBetaApartment")  == true ) then print("ownsbta") return end
if(  ply:GetPData("OwnAlphaApartment") == true ) then print("ownsalpha") return end
if(  ply:GetNWInt("Apartmentloaded")   == 1    ) then print("apartmentwasloaded") return end
if( tonumber(ply:GetPData("tilet")) < A_PRICE-1 ) then print("cantafford") return end


ply:SetPData("OwnBetaApartment",true)
ply:Give("keys")
GiveApartment(ply,"Beta")
ply:SendLua("chat.AddText(Color(0,160,255),'Thanks for buying a Beta Apartment :)')")

end
concommand.Add("BuyBetaApartment",BuyBeta)






--[[---------------------
--Dont Touch below here--
--]]---------------------


if( !sql.TableExists("apar") )then

sql.Query("CREATE TABLE apar (id varchar(255),mdl varchar(255),ang varchar(255),pos varchar(255) )")  -- Create sql table 

end

function SaveApartment( ply, cmd, arg )

sql.Query("DELETE FROM apar WHERE id = '"..ply:UniqueID().."'")

for k,v in pairs( ents.GetAll() ) do

if(v:GetNWString("DOwner") == ply:SteamID()) then Door =v:EntIndex() end

print(Door)
if( v:GetNWString("Owner") == "U_"..ply:UniqueID().."_U" ) then
pos,ang = WorldToLocal(v:GetPos(),v:GetAngles(),Entity(Door):GetPos(),Entity(Door):GetAngles())

sql.Query("INSERT INTO apar VALUES('"..ply:UniqueID().."','"..v:GetModel().."','"..tostring(ang).."','"..tostring(pos).."') ")

end

end

end
concommand.Add("saveapartS",SaveApartment)


function LoadApartment( ply, cmd, arg )

for k,v in pairs( ents.GetAll() ) do

    if(v:GetNWString("DOwner") == ply:SteamID()) then DoorL = v:EntIndex() end
end

    if(!sql.Query("SELECT * FROM apar WHERE id = '"..ply:UniqueID().."' ")) then return end
        for k,v in pairs(sql.Query("SELECT * FROM apar WHERE id = '"..ply:UniqueID().."' ") ) do
            if(v) then
                local po, an = LocalToWorld(util.StringToType(v["pos"],"Vector"),util.StringToType(v["ang"],"Angle"),Entity(DoorL):GetPos(),Entity(DoorL):GetAngles())

                local prop = ents.Create("prop_physics")
                prop:SetModel(v["mdl"])
                prop:SetPos(po )    
                prop:SetAngles(an)
                prop:SetMoveType(MOVETYPE_NONE)
                prop:Spawn()
                prop:SetMoveType(MOVETYPE_NONE)
        end
    end
end
