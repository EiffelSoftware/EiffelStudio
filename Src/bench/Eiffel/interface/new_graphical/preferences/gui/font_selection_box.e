indexing
	description	: "Font Selection Box."
	author		: "Pascal Freund and Christophe Bonnard"
	date		: "$Date$"
	revision	: "$Revision$"

class
	FONT_SELECTION_BOX

inherit
	DIALOG_SELECTION_BOX
		redefine
			resource, 
			display
		end

create
	make

feature -- Commands

	update_changes is
			-- Commit the Result of Font Tool.
		do
			update_resource
			caller.update
		end

	create_tool is
			-- Create Font Tool.
		do
--			create font_tool
--			font_tool.set_modal
--			font_tool.select_font (resource.actual_value)
		end

feature -- Display
	
	display (new_resource: like resource) is
			-- Display Current with title 'txt' and content 'new_value'.
		do
			Precursor (new_resource)
		end

feature {NONE} -- Implementation

	build_change_item_widget is
			-- Create and setup `change_item_widget'.
		local
			h2: EV_HORIZONTAL_BOX
		do
			create h2
			create example
			h2.extend (example)
			example.set_minimum_width (120)
			create change_b.make_with_text_and_action ("Change ...",~change)
		--| FIXME XR: Vision2 doesn't support font dialogs at the moment.
			change_b.set_tooltip ("Not available in this version")
			change_b.disable_sensitive
		--| end FIXME
			h2.extend (change_b)
			h2.disable_item_expand (change_b)
			h2.disable_item_expand (example)

			change_item_widget := h2
		end

feature -- Implementation

--	font_tool: EV_FONT_DIALOG
			-- Color Palette from which we can select a color.

	resource: FONT_RESOURCE
			-- Resource.

	example: EV_LABEL
			-- Example written with the font.

end -- class FONT_SELECTION_BOX
