indexing
	description: "Objects that allowed the Scrolling Managment of a Scrolled WIndow"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EC_SCROLLED_W_IMP

inherit
	--SCROLLED_W_IMP
	--	export
	--		{WORKAREA_MOVE_DATA_COM, TRANSPORTER} horizontal_update	
	--		{WORKAREA_MOVE_DATA_COM, TRANSPORTER} vertical_update
	--		{WORKAREA_MOVE_DATA_COM, TRANSPORTER} maximum_x	
	--		{WORKAREA_MOVE_DATA_COM, TRANSPORTER} minimum_x
	--		{WORKAREA_MOVE_DATA_COM, TRANSPORTER} maximum_y	
	--		{WORKAREA_MOVE_DATA_COM, TRANSPORTER} minimum_y
	--	end

creation
	--make_ec


feature
		--Redefinition

	--make_ec (a_scrolled_window: EC_SCROLLED_W; man: BOOLEAN; oui_parent: COMPOSITE) is
	--	do
	--		!! private_attributes
	--		parent ?= oui_parent.implementation
	--		managed := man
	--		set_default
	--		private_attributes.set_width (100)
	--		private_attributes.set_height (100)
	--	end


end -- class EC_SCROLLED_W_IMP
