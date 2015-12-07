/*
	PS2 Boosters r2342-{{ user_id }}
*/

hook.Add( "PS2_ModulesLoaded", "DLC_Texthat", function( )
	local MODULE = Pointshop2.GetModule( "Pointshop 2 DLC" )
	table.insert( MODULE.Blueprints, {
		label = "Text Hat",
		base = "base_texthat",
		icon = "pointshop2/fedora.png",
		creator = "DTextHatCreator"
	} )
end )

hook.Add( "PS2_PopulateCredits", "AddTexthatCredit", function( panel )
	panel:AddCreditSection( "Pointshop 2 Texthat", [[
Texthat by Kamshak. Original Idea and sponsorship by Azzy.
	]] )
end )