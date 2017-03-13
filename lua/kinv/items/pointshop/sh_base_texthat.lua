ITEM.baseClass	= "base_hat"
ITEM.PrintName	= "Texthat"
ITEM.Description = "The texthat"

ITEM.static.validSlots = {
	"Hat",
}

ITEM.static.NoPreview = true

function ITEM:initialize( id )
	KInventory.Items.base_pointshop_item.initialize( self, id )

	self.saveFields = self.saveFields or {}
	table.insert( self.saveFields, "text" )
end

if CLIENT then
	// Send text message to server
	function ITEM:UserSetText( text )
		self:ServerRPC( "UserSetText", text )
	end

	// Server tells all clients to update text
	function ITEM:SetText( text )
		self.text = text
	end

	function ITEM:Think( )
		self.text = self.text or "Change Me"
		if IsValid( self:GetOwner( ) ) and self:GetOwner().FindPACPart then
			self.textPart = self:GetOwner():FindPACPart( self.baseOutfit, "Hello" )
		end
		ITEM.super.Think(self)
	end
	Pointshop2.AddItemHook("Think", ITEM)

	function ITEM:PostDrawOpaqueRenderables( )
		if IsValid(self.textPart) then
			self.textPart:SetText( self.text )
			if self.rainbow then
				self.textPart:SetColor(HSVToColor(RealTime() *20 % 360, 1, 1))
			end
		end
	end
	Pointshop2.AddItemHook("PostDrawOpaqueRenderables", ITEM)
else
	function ITEM:UserSetText( text )
		self.text = string.sub( text, 1, 16 )
		self:save()
		self:ClientRPC("SetText", self.text)
	end
	ITEM.AllowRPC( "UserSetText" )
end


function ITEM.static.generateFromPersistence( itemTable, persistenceItem )
	Pointshop2.Items.base_pointshop_item.generateFromPersistence( itemTable, persistenceItem.ItemPersistence )

	itemTable.color = persistenceItem.color
	itemTable.outlineColor = persistenceItem.outlineColor
	itemTable.rainbow = persistenceItem.rainbow
	itemTable.size = persistenceItem.size

	itemTable.baseOutfit = {
		[1] = {
			["children"] = {
				[1] = {
					["children"] = {
					},
					["self"] = {
						["Outline"] = 1,
						["UniqueID"] = "3494032761",
						["Name"] = "Hello",
						["EditorExpand"] = true,
						["Position"] = Vector(14.734375, -0.2509765625, -0.0009765625),
						["ClassName"] = "text",
						["Size"] = itemTable.size,
						["Font"] = "DermaLarge",
						["Color"] = itemTable.color,
						["OutlineColor"] = itemTable.outlineColor,
						["Angles"] = Angle(90, -82.253997802734, 5.1226412324468e-005),
						["Text"] = "Example Text",
					},
				},
			},
			["self"] = {
				["EditorExpand"] = true,
				["UniqueID"] = "3385648173",
				["ClassName"] = "group",
				["Name"] = "my outfit",
				["Description"] = "add parts to me!",
			},
		},
	}

	function itemTable.getOutfitForModel( )
		return itemTable.baseOutfit, 3385648173
	end
end

function ITEM:NoPreview( )
	return true
end

function ITEM.static:GetPointshopIconControl( )
	return "DTexthatItemIcon"
end

function ITEM:getIcon( )
	self.icon = vgui.Create( "DTexthatInventoryIcon" )
	self.icon:SetItem( self )
	return self.icon
end

function ITEM.static.GetPointshopDescriptionControl( )
	return "DTexthatItemDescription"
end

function ITEM.static.getPersistence( )
	return Pointshop2.TexthatPersistence
end

function ITEM:NoPreview( )
	return true
end
