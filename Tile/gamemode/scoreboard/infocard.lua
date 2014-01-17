local PANEL = {}

local scrw = ScrW()
local scrh = ScrH()

local rank = ""

surface.CreateFont( "InfoCardNameLabel", {
	font = "Calibri Italic",
	size = 30,
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

surface.CreateFont( "InfoCardInfoLabel", {
	font = "Calibri Light",
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

AccessorFunc(PANEL,"expanded","Expanded")
AccessorFunc(PANEL,"player","Player")

function PANEL:Init()
	self.Avatar = vgui.Create("AvatarImage",self)
	self.Avatar.Button = vgui.Create("DButton",self.Avatar)
	self.Avatar.Button:SetDrawBackground(false)
	self.Avatar.Button:SetText("")
	self.Avatar.Button.DoClick = function()
		self:GetPlayer():ShowProfile()
	end

	self.NameLabel = vgui.Create("DLabel",self)

	self.SteamIDLabel = vgui.Create("DButton",self)
	self.SteamIDLabel:SetDrawBackground()
	self.SteamIDLabel:SetTextColor(Color(150,150,150))
	self.SteamIDLabel.OnMousePressed = function()
		SetClipboardText( self.player:SteamID() )
		self.SteamIDLabel:SetTextColor(Color(250,250,250))
	end
	self.SteamIDLabel.OnMouseReleased= function()
		SetClipboardText( self.player:SteamID() )
		self.SteamIDLabel:SetTextColor(Color(150,150,150))
	end

	self.RankLabel = vgui.Create("DLabel",self)
	self.RankLabel:SetTextColor(Color(150,150,150))
end

function PANEL:PerformLayout()
	if self:GetPlayer():IsAdmin() then
		rank = "Admin"
	elseif self:GetPlayer():IsSuperAdmin() then
		rank = "SuperAdmin"
	else
		rank = "User"
	end

	self:SetSize(500,200)
	self:SetPos(scrw+5,0)

	self.Avatar:SetSize(96,96)
	self.Avatar:SetPos(10,10)
	self.Avatar:SetPlayer(self:GetPlayer())
	self.Avatar.Button:SetSize(96,96)

	self.NameLabel:SetFont("InfoCardNameLabel")
	self.NameLabel:SizeToContents()
	self.NameLabel:SetPos(15+self.Avatar:GetWide(),8)
	self.NameLabel:SetText(self:GetPlayer():Nick() or "nil")

	self.SteamIDLabel:SetFont("InfoCardInfoLabel")
	self.SteamIDLabel:SizeToContents()
	self.SteamIDLabel:SetPos(15+self.Avatar:GetWide(),self.NameLabel:GetTall())
	self.SteamIDLabel:SetText(self:GetPlayer():SteamID() or "nil")

	self.RankLabel:SetFont("InfoCardInfoLabel")
	self.RankLabel:SizeToContents()
	self.RankLabel:SetPos(15+self.Avatar:GetWide(),self.NameLabel:GetTall() + self.SteamIDLabel:GetTall() - 6)
	self.RankLabel:SetText(rank)

end

function PANEL:Paint(w,h)
	surface.SetDrawColor(Color(40,40,40))
	surface.DrawRect(0,0,self:GetWide(),self:GetTall())
	surface.SetDrawColor(Color(60,60,60))
	surface.DrawRect(0,0,self:GetWide(),self:GetTall()-3)
end

function PANEL:Show()
	self:MoveTo(scrw-self:GetWide()-5,0,1)
	self:SetExpanded(true)
end

function PANEL:Hide()
	self:MoveTo(scrw+5,0,1)
	self:SetExpanded(false)
end


vgui.Register("Tile_Infocard", PANEL, "Panel")