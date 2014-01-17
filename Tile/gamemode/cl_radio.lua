if SERVER then return end
sound.PlayURL ( "https://dl-web.dropbox.com/get/Public/01%20Power%20Move%20(Original%20Mix).mp3", "", function( station ) 
if ( IsValid( station ) ) then

station:Play()


net.Receive("Volume",function()
Num = net.ReadFloat()

station:SetVolume(Num)

print(Num)

end)

concommand.Add("radvol",vol)

function stp()
station:Stop()
end
concommand.Add("stopradio",stp)



else 
LocalPlayer():ChatPrint( "Invalid URL!" )

end
end )

--http://yp.shoutcast.com/sbin/tunein-station.pls?id=57352&play_status=1
--651101
--201151
--145461
--170875 -- good one
-- 34799
--227567
-- 172098 jazz
--651101
--models/props_lab/citizenradio.mdl        
--366480
--85451











