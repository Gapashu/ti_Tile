surface.CreateFont( "PlayerRowFont", {
	font = "Pixel Berry 08/84 Ltd.Edition",
	size = 20,
	weight = 300,
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

local tileSignal = Material("tile/ui/tilesignal.png","nocull")
local tileSignalGlow = Material("tile/ui/tilesignalglow.png","nocull")

local PANEL = {}

AccessorFunc(PANEL,"player","Player")
AccessorFunc(PANEL,"color","Color")

function PANEL:Init()
	self.NameLabel	= vgui.Create("DLabel",self)
	self:SetText("")
end

function PANEL:PerformLayout()
	self:StretchToParent(0,nil,0,nil)
	self:SetTall(32)
	self.NameLabel:SetDrawBackground(false)
	self.NameLabel:SetText(self.player:Nick())
	self.NameLabel:SetPos(self:GetWide()*0.02,0)
	self.NameLabel:SetSize(self:GetWide()*0.25,self:GetTall())
	self.NameLabel:CenterVertical(0.5)

end

function PANEL:Paint()
	local ping = self.player:Ping()
	ping = math.Clamp(ping,100,300)-100
	local pingrating = math.floor((ping/200)*255)
	surface.SetDrawColor(self:GetColor())
	surface.DrawRect(0,0,self:GetWide(),self:GetTall())

	surface.SetDrawColor(Color(0+pingrating,255-pingrating,0,self:GetAlpha()))
	surface.SetMaterial(tileSignalGlow)
	surface.DrawTexturedRect(self:GetWide()-32,0,32,32)
	surface.SetDrawColor(Color(255,255,255,self:GetAlpha()))
	surface.SetMaterial(tileSignal)
	surface.DrawTexturedRect(self:GetWide()-32,0,32,32)

end

function PANEL:ApplySchemeSettings()
	self.NameLabel:SetFont("PlayerRowFont")
end

vgui.Register("tilePlayerRow", PANEL, "Button")