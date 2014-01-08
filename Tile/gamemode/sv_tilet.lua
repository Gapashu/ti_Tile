include("shared.lua")
if CLIENT then return end
if SERVER then print("sv_tilet loaded") end
Foil = 60
Count = 0

function TTC()

for _,p in pairs( player.GetAll() ) do

Count = Count + tonumber( p:GetPData("xp") )

end

return Count

end

function CalcTilPrice(total,foil)

local Price = total/#player.GetAll()/foil


return math.Round(Price)
end

print(CalcTilPrice(TTC(),Foil))