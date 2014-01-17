if SERVER then return end


G = 0

surface.CreateFont( "BoxWall", {
font = "Arial",
size = 100,
weight = 0,
blursize = 0,
scanlines = 0,
antialias = true,
underline = false,
italic = false,
strikeout = false,
symbol = false,
rotary = false,
shadow = false,
additive = false,
outline = false,
} )



function GM:PostDrawOpaqueRenderables()


pl = LocalPlayer()
if(GetEyeTrace)then
traceRes = pl:GetEyeTrace()
end
G = G + 0.001
x = math.cos(G)*190
y = math.sin(G)*50

cam.Start3D2D(Vector(-480,0,522),Angle(0,-90,90),0.4)

draw.RoundedBox( 6, x, y,100, 100, Color( 255, 255, 255, 150 ) )
draw.RoundedBox( 6, -x*2, -y*2,100, 100, Color( 255, 255, 255, 150 ) )
draw.RoundedBox( 6, x*2, y*2,100, 100, Color( 0, 160, 255, 150 ) )
draw.RoundedBox( 6, -x, -y,100, 100, Color( 0, 160, 255, 150 ) )

local tex = Material("materials/tile/ui/icon_24.png")
surface.SetMaterial(tex)
surface.DrawTexturedRect(0, 0, 100,100)


cam.End3D2D()
end








