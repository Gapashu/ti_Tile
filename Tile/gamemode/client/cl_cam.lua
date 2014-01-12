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
traceRes = pl:GetEyeTrace()

G = G + 0.001
x = math.cos(G)*190
y = math.sin(G)*50

cam.Start3D2D(Vector(-480,0,522),Angle(0,-90,90),0.4)

draw.RoundedBox( 6, x, y,100, 100, Color( 255, 255, 255, 150 ) )
draw.RoundedBox( 6, -x*2, -y*2,100, 100, Color( 255, 255, 255, 150 ) )
draw.RoundedBox( 6, x*2, y*2,100, 100, Color( 0, 160, 255, 150 ) )
draw.RoundedBox( 6, -x, -y,100, 100, Color( 0, 160, 255, 150 ) )

surface.SetTextColor( 250, 100, 0, 255 )
surface.SetTextPos( -300, 00 ) 
surface.SetFont("BoxWall")
surface.DrawText( "Welcome to Tiles!" )



cam.End3D2D()
end








