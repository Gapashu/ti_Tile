if CLIENT then return end

if SERVER then print("sv_pool loaded") end

PoolSpawn = {}
PoolCount = {}
PoolSpawn[1] = Vector(-8031,265,-380)
PoolSpawn[2] = Vector(-8049,100,-385)
PoolSpawn[3] = Vector(-8037,796,-386)
PoolSpawn[4] = Vector(-7434,1029,-385)




function ChatCommand(ply, txt, pub)

txt = string.lower(txt)

if(string.sub(txt,0,5) =="!pool") then

txt = string.Explode(" ", txt )

if(txt[2] == "join" )then
if(10 - #PoolCount > 0 ) then
table.insert(PoolCount,ply:Nick() )

ply:SendLua("chat.AddText(Color(0,160,255),'Welcome to the pool! There is "..tostring(10 - #PoolCount).." pool slots left!'  )")
ply:SetPos(table.Random(PoolSpawn))
else
ply:SendLua("chat.AddText(Color(255,0,0),' No more pool slots left, sorry :C ')")
end
end

if(txt[2] == "leave" )then
ply:SendLua("chat.AddText(Color(0,160,255),'You will now be sent back to the lobby.')")
table.remove(PoolCount,table.KeyFromValue(PoolCount,ply:Nick()))
ply:Spawn()
end

end
end

hook.Add("PlayerSay","Command",ChatCommand)
