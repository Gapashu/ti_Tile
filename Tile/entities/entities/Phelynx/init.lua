AddCSLuaFile( "cl_init.lua" ) 
AddCSLuaFile( "shared.lua" )

include("shared.lua") 
include("sv_door.lua")


local meta = FindMetaTable("Player")
if CLIENT then return end

if SERVER then
util.AddNetworkString("Shop")
util.AddNetworkString("HModel")
util.AddNetworkString("Table")
end


A_PRICE = 10


ADoors = {}
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
 	self:SetMaxYawSpeed( 90 ) 
	print(self)
	net.Start("Shop")
	net.WriteEntity(self)
	net.Broadcast()
	
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
		Caller:SendLua("chat.AddText(Color(255,140,0),'I have ','"..#ADoors.."',' rooms left!' )")
		PrintTable(ADoors)
		Caller:SendLua("Rents()")
	end
	
end
--[[ POINT SYSTEM]]--

function meta:GiveXP()
	timer.Create("xp",10*60,0,function()
		self:SetPData("xp",self:GetPData("xp")+5)


		umsg.Start("Point",self)
		umsg.Float(self:GetPData("xp"))
		umsg.End()

	end)
end


hook.Add("PlayerInitialSpawn","Points",function(ply)

	if(ply:GetPData("xp"))== nil then
		ply:SetPData("xp",0)
		ply:GiveXP()
	else
		ply:GiveXP()
	end
end)

function Buy(ply,cmd,arg)

if(#ADoors == 0 )then return end 

if(ply:GetPData("OA") ==1 ) then 
ply:SendLua("chat.AddText(Color(255,0,0),'You own an apartment already.' )")
return end


if(ply:GetNWInt("AL") == 1) then 
ply:SendLua("chat.AddText(Color(255,0,0),'You Apartment is already loaded.' )")
return end



if(tonumber(ply:GetPData("xp")) > A_PRICE - 1) then

local door = table.Random(ADoors)
door:SetNWString("DOwner",ply:SteamID())
table.remove(ADoors,table.KeyFromValue(ADoors,door) )
ply:SendLua("chat.AddText(Color(0,255,0),'Thanks for buying an apartment,I have',' "..tostring(#ADoors).. " Rooms Left' )")
ply:SetPData("OA",1)
ply:SetNWInt("AL",1)

ply:Give("keys")
end



end
concommand.Add("buyapartment",Buy)


function LoadR(ply,cmd,arg)

ply:Give("keys")

if(#ADoors == 0 )then 
print("no rooms")
return 
end

if(ply:GetNWInt("AL") == 1 ) then

print("room loaded previosuly")
return 
end

if(tonumber(ply:GetPData("OA")) == 1 )then
print("Loadinh")
local door = table.Random(ADoors)
door:SetNWString("DOwner",ply:SteamID())
table.remove(ADoors,table.KeyFromValue(ADoors,door) )
ply:SendLua("chat.AddText(Color(0,255,0),'I loaded your room.')")
ply:SetNWInt("AL",1)
LoadApartment(ply)
end

print("loadran")
end
concommand.Add("loadapartment",LoadR)









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
--concommand.Add("lodaparts",LoadApartment)

