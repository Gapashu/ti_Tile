include("shared.lua")

if SERVER then
util.AddNetworkString("Volume")
print("sv_lob")
end

function ChatC(ply, txt, pub)

txt = string.lower(txt)

if(string.sub(txt,0,8) =="!lob vol") then

txt = string.Explode(" ", txt )
Num = (txt[3]*10) /100
net.Start("Volume")
net.WriteFloat(tonumber ( Num  ) )
net.Broadcast()



for k,v in pairs(player.GetAll()) do

v:SendLua("chat.AddText(Color(255,0,0),'"..ply:Nick().."',Color(0,160,255),' Has changed the lobby volume to ',Color(0,250,0),'"..(Num*100).."','%!'    )"  )
end

return false
end


end

hook.Add("PlayerSay","1Command1",ChatC)