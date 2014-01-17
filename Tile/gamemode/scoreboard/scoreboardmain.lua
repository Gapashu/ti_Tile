include("locationboxes.lua")

local PANEL = {}

local scrw = ScrW()
local scrh = ScrH()

surface.CreateFont( "AboutFont", {
	font = "Calibri Italic",
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

function PANEL:Init()
	DOF_Kill()

	self:SetAlpha(0)

	self.TileBanner = vgui.Create("DImage",self)

	self.TileQuotes = vgui.Create("DLabel",self)
	self.TileQuotes:SetText("Loading...")
	
	self.LocationBoxes = {}

	self.LocationBoxes.spawn = vgui.Create("Tile_LocationBox",self)
	self.LocationBoxes.spawn:SetPos(10,128+100)

	self.LocationBoxes.lobby = vgui.Create("Tile_LocationBox",self)
	self.LocationBoxes.lobby:SetPos(10,128+100)

	net.Receive( "ScoreboardUpdateAbout", function()
		self.TileQuotes:SetText(net.ReadString())
	end )

	timer.Create("UpdatePlayers", 0.5, 0, function()
		self:UpdatePlayers()
	end)
end

function PANEL:PerformLayout()
	self:SetSize(scrw,scrh)

	self.TileBanner:SetImage("tile/ui/tilebannernoback.png")
	self.TileBanner:SetPos(0,0)
	self.TileBanner:SetSize(288,128)

	self.TileQuotes:SetWrap(true)
	self.TileQuotes:SetSize(500,128)
	self.TileQuotes:SetFont("AboutFont")
	self.TileQuotes:MoveRightOf(self.TileBanner,0)

	self.LocationBoxes.spawn:SetLocation("Spawn")

	self.LocationBoxes.lobby:SetLocation("Lobby")
	self.LocationBoxes.lobby:MoveRightOf(self.LocationBoxes.spawn,10)
end

function PANEL:Paint(w,h)
	surface.SetDrawColor(Color(0,0,0,210))
	surface.DrawRect(0,0,self:GetWide(),self:GetTall())
end

function PANEL:DeselectAllPlayers()
	scoreboardselectedplayer = nil
	if scoreboardselectedpanel then
		scoreboardselectedpanel:Hide()
	end
end

function PANEL:UpdatePlayers()
	for _,panel in pairs(self.LocationBoxes) do
		panel:Update()
	end
end

vgui.Register("Tile_Scoreboard", PANEL, "Panel")