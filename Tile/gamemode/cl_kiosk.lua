if SERVER then return end

surface.CreateFont( "KioskClean", {
font = "Arial",
size = 90,
weight = 50,
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


hook.Add("PostDrawOpaqueRenderables","Kioskdraw",function()
cam.Start3D2D(Vector(-2687,-213,420),Angle(0,90,90),0.1  )

surface.SetTextColor( 0, 160, 255, 255 )
surface.SetTextPos( 0, 200 ) 
surface.SetFont("KioskClean")
surface.DrawText( "Phelynx's Apartments" )

cam.End3D2D()


end)
