--| FIXME not reviewed
indexing
	description: "Font Selection Box."
	author: "Pascal Freund and Christophe Bonnard"
	date: "$Date$"
	revision: "$Revision$"

class
	FONT_SELECTION_BOX


inherit
	DIALOG_SELECTION_BOX
		rename
--			dialog_tool as font_tool
		redefine
			make, resource, display --, font_tool
		end

creation
	make

feature -- Creation
	
	make (h: EV_HORIZONTAL_BOX; new_caller: PREFERENCE_WINDOW) is
			-- Creation
		local
			h2: EV_HORIZONTAL_BOX
		do
			Precursor (h, new_caller)
			create h2
			frame.extend (h2)
			create example
			h2.extend (example)
			example.set_minimum_width (120)
			create change_b.make_with_text_and_action ("Change ...",~change)
			h2.extend (change_b)
			h2.disable_item_expand (change_b)
			h2.disable_item_expand (example)
		end

feature -- Commands

	update_changes is
			-- Commit the Result of Font Tool.
		local
--			s: STRING
		do
			update_resource
			caller.update
--			create s.make (20)
--			resource.set_value (s)
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

feature -- Implementation

--	font_tool: EV_FONT_DIALOG
		-- Color Palette from which we can select a color.

	resource: FONT_RESOURCE
		-- Resource.

	example: EV_LABEL
		-- Example written with the font.

end -- class FONT_SELECTION_BOX
