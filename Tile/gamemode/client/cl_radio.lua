
if SERVER then return end
--sound.PlayURL ( "http://yp.shoutcast.com/sbin/tunein-station.pls?id=831&play_status=1", "", function( station ) 
--if ( IsValid( station ) ) then

--station:Play()


--net.Receive("Volume",function()
--Num = net.ReadFloat()

--station:SetVolume(Num)

--print(Num)

--end)

--concommand.Add("radvol",vol)

--function stp()
--station:Stop()
--end
--concommand.Add("stopradio",stp)



--else 
--LocalPlayer():ChatPrint( "Invalid URL!" )

--end
--end )

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
--53937
--8318



------------------------------------------------------------
--Define Radio as a global variable my  functions can call--
------------------------------------------------------------    
Radio = nil  -- omg global var

-----------------------------------------------------------
--This function is is my hacky way to globalize the radio--
-----------------------------------------------------------

function Rad(Radi)        -- Radi is the argument of playURL, the wiki examples is 'station' 
--setmetatable(Radio,Radi)  -- rather than making Radio the master of Radi ( the local var), we make it its own variable! 
Radio = Radi     -- the index makes it index itself
end


sound.PlayURL( "http://yp.shoutcast.com/sbin/tunein-station.pls?id=53937&play_status=1" , "", Rad)


    
function StopMusic()
Radio:Stop()
end


function PlayMusic()
Radio:Play()
end


function SetVolume(number)
Radio:SetVolume(number)
end








