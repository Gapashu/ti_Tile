scoreboardselectedplayer = nil
scoreboardselectedpanel = nil

local PANEL = {}

local scrw = ScrW()
local scrh = ScrH()

surface.CreateFont( "PlayerNameFont", {
	font = "Calibri Light Italic",
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

surface.CreateFont( "PlayerSelectFont", {
	font = "Calibri",
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

AccessorFunc(PANEL,"player","Player")
AccessorFunc(PANEL,"infocard","InfoCard")
AccessorFunc(PANEL,"selected","Selected")

function PANEL:Init()
	self:SetText("")

	self.PlayerSelect = vgui.Create("DLabel",self)
	self.PlayerSelect:SetAlpha(0)

	self.PlayerName = vgui.Create("DLabel",self)
end

function PANEL:PerformLayout()
	self.PlayerSelect:SetFont("PlayerSelectFont")
	self.PlayerSelect:SetText(">")
	self.PlayerSelect:SizeToContents()

	self.PlayerName:SetFont("PlayerNameFont")
	self.PlayerName:SetText(string.lower(self.player:Nick()))
	self.PlayerName:MoveRightOf(self.PlayerSelect,0)
	self.PlayerName:SizeToContents()

	self:SetSize(scrw*0.30,self.PlayerName:GetTall())
end

function PANEL:Paint(w,h)
end

function PANEL:OnCursorEntered()
	self.PlayerSelect:AlphaTo(255,1,0,function()
	end)
end

function PANEL:OnCursorExited()
	if self.selected then return end
	self.PlayerSelect:AlphaTo(0,1,0)
end

function PANEL:OnMousePressed()
	self.PlayerSelect:SetAlpha(255)
	if scoreboardselectedplayer != self:GetPlayer() then
		if scoreboardselectedpanel then
			scoreboardselectedpanel:Hide()
		end
	end

	scoreboardselectedplayer = self:GetPlayer()
	scoreboardselectedpanel = self.infocard
	self.infocard:Show()
end

function PANEL:Think()
	if scoreboardselectedplayer == self:GetPlayer() then
		self.PlayerSelect:SetAlpha(255)
		self:SetSelected(true)
	else
		if !self:IsHovered() then
			self.PlayerSelect:SetAlpha(0)
			self:SetSelected(false)
		end
	end
end

vgui.Register("Tile_PlayerRow", PANEL, "Button")