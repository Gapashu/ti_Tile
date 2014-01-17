include("playerrow.lua")
include("infocard.lua")

local PANEL = {}

local scrw = ScrW()
local scrh = ScrH()

surface.CreateFont( "LocationLabelFont", {
	font = "Calibri",
	size = 40,
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

AccessorFunc(PANEL,"location","Location")

function PANEL:Init()
	self.LocationLabel = vgui.Create("DLabel",self)

	self.PlayerRack = vgui.Create("Panel",self)

	self.Players = {}

	self:Update()
end

function PANEL:PerformLayout()
	self.LocationLabel:SetFont("LocationLabelFont")
	self.LocationLabel:SetText(self.location or "Nil")
	self.LocationLabel:SizeToContents()

	self.PlayerRack:SetPos(0,self.LocationLabel:GetTall())
	self.PlayerRack:StretchToParent(nil,nil,0,0)

	self:SetSize(scrw*0.30,scrh*0.70)

	local SortedPlayerRows = {}
	local stack = 0

	for ply, panel in pairs(self.Players) do
		table.insert(SortedPlayerRows, panel)
	end

	for id, panel in ipairs(SortedPlayerRows) do

		panel:SetPos(0,stack)

		stack = stack + panel:GetTall() + 1
	end

end

function PANEL:Paint(w,h)
end

function PANEL:AddPlayerRow(ply)
	self.Players[ply] = vgui.Create("Tile_PlayerRow",self.PlayerRack)
	self.Players[ply]:SetPlayer(ply)
	self.Players[ply].infocard = vgui.Create("Tile_Infocard", self:GetParent())
	self.Players[ply].infocard:SetPlayer(ply)
end

function PANEL:RemovePlayerRow(ply)
	self.Players[ply]:Remove()
	self.Players[ply] = nil
end

function PANEL:Update()

	for ply, panel in pairs(self.Players) do
		if !ply:IsValid() or (GetLocation(ply) != self:GetLocation()) then
			self:RemovePlayerRow(ply)
		end
	end

	for id, ply in pairs(player.GetAll()) do
		if GetLocation(ply) == self:GetLocation() then
			if !self.Players[ply] then
				self:AddPlayerRow(ply)
			end
		end
	end

	self:InvalidateLayout()
end

vgui.Register("Tile_LocationBox", PANEL, "Panel")