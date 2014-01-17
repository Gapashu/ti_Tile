local PANEL = {}

function PANEL:Init()
	self:SetSize(288,128)

	self.DevLabel = vgui.Create("RichText",self)
	self.DevLabel:SetText(file.Read("about.txt","GAME"))
	self.DevLabel:SetPos(0,148)
end

function PANEL:PerformLayout()
	self.DevLabel:StretchToParent(0,nil,20,0)
end

function PANEL:SetExpanded(value)
	self.Expanded = value

	if value == true then
		self:SizeTo(288,400,2,0,1)
	else
		self:SizeTo(288,128,2,0,1)
	end
end

function PANEL:GetExpanded()
	return self.Expanded
end

function PANEL:Paint()
	surface.SetDrawColor(Color(0,0,0,255))
	surface.DrawRect(0,148,self.DevLabel:GetWide(),self.DevLabel:GetTall())
	surface.DrawRect(0,148,self.DevLabel:GetWide(),self.DevLabel:GetTall())

	local tileBanner = Material("tile/ui/tilebannernoback.png","nocull")
	surface.SetDrawColor(Color(255,255,255,self:GetAlpha()))
	if self:IsHovered() then
		surface.SetDrawColor(Color(100,100,100,self:GetAlpha()))
	end
	surface.SetMaterial(tileBanner)
	surface.DrawTexturedRect(0,0,288,128)

	if !self:GetExpanded() then return end

end

function PANEL:ToggleExpanded()
	if !self:GetExpanded() then
		self:SetExpanded(true)
	else
		self:SetExpanded(false)
	end
end

function PANEL:OnMousePressed()
	chat.PlaySound()
	self:ToggleExpanded()
	if self:GetExpanded() then
		self:SizeTo(288,300,2,0,1)
	else
		self:SizeTo(288,128,2,0,1)
	end
end
vgui.Register("tileAboutButton",PANEL,"Panel")