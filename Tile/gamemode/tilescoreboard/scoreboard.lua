include("playerrow.lua")
include("aboutbutton.lua")

local PANEL = {}

function PANEL:Init()
	self:SetAlpha(0)

	self.TileButton = vgui.Create("tileAboutButton",self)

	self.PlayersFrame = vgui.Create("Panel",self)
	self.PlayersFrame.Paint = function(self)
		surface.SetDrawColor(Color(0,0,0,self:GetAlpha()))
		surface.DrawRect(0,0,self:GetWide(),self:GetTall())
	end

	self.PlayerRows = vgui.Create("DScrollPanel",self.PlayersFrame)

	self.GetRows = {}

	self:Update()
end

function PANEL:PerformLayout()
	self:SetSize(ScrW()*0.5,ScrH()*0.8)
	self:SetPos((ScrW() - self:GetWide())/2, (ScrH() - self:GetTall())/2 )

	self.TileButton:CenterHorizontal(0.5)

	self.PlayersFrame:SetWide(self:GetWide())
	self.PlayersFrame:StretchToParent(0,0,0,133)
	self.PlayersFrame:MoveBelow(self.TileButton,5)

	self.PlayerRows:StretchToParent(0,0,0,0)
	self.PlayerRows.Paint = function()
	end

	local SortedPlayerRows = {}
	local stack = 0

	for ply, panel in pairs(self.GetRows) do
		table.insert(SortedPlayerRows, self.GetRows[ply])
	end

	for id, panel in ipairs(SortedPlayerRows) do

		panel:SetSize(self.PlayersFrame:GetWide(),32)
		panel:SetPos(0,stack)

		stack = stack + SortedPlayerRows[id]:GetTall() + 3
	end
end

function PANEL:Show()
	self:SetVisible(true)
	self:MakePopup()
	self:AlphaTo(200,0.3,0)
end

function PANEL:Hide()
	self.TileButton:SetExpanded(false)
	self:AlphaTo(0,0.3,0,function()
		self:SetVisible(false)
	end)
end

function PANEL:Paint()
	local w = self:GetWide()
	local h = self:GetTall()

	surface.SetDrawColor(Color(0,0,0,self:GetAlpha()))
	surface.DrawRect(0,0,w,h)
end


function PANEL:AddPlayerRow(ply)
	self.GetRows[ply] = vgui.Create("tilePlayerRow",self.PlayerRows)
	self.GetRows[ply]:SetPlayer(ply)
	print(ply:Nick())
end

function PANEL:RemovePlayerRow(ply)
	self.GetRows[ply]:Remove()
	self.GetRows[ply] = nil
end

function PANEL:Update()
	for ply, panel in pairs(self.GetRows) do
		if !ply:IsValid() then
			self:RemovePlayerRow(ply)
		end
	end

	for id, ply in pairs(player.GetAll()) do
		if !self.GetRows[ply] then
			self:AddPlayerRow(ply)
		end
	end

	self:InvalidateLayout() --This invalidates the layout so the panel runs perform layout again.
end

vgui.Register("tileScoreboard",PANEL,"Panel")