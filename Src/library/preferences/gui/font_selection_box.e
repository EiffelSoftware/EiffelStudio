indexing
	description	: "Font Selection Box."
	author		: "Pascal Freund and Christophe Bonnard"
	date		: "$Date$"
	revision	: "$Revision$"

class
	FONT_SELECTION_BOX

inherit
	SELECTION_BOX
		redefine
			resource, 
			display
		end

create
	make

feature -- Display
	
	display (new_resource: like resource) is
			-- Display Current with title 'txt' and content 'new_value'.
		do
			Precursor (new_resource)
			display_font (resource.actual_value)
		end

feature {NONE} -- Commands

	change is
			-- Change the value 
		do
			check
				resource_exists: resource /= Void
			end
				-- Create Font Tool.
			create font_tool
			font_tool.set_font (resource.actual_value)

			font_tool.ok_actions.extend (agent update_changes)
			change_dialog.disable_sensitive
			font_tool.show_modal_to_window (caller)
			change_dialog.enable_sensitive
		end 

	update_changes is
			-- Commit the Result of Font Tool.
		local
			font: EV_FONT
		do
			font := font_tool.font
			resource.set_actual_value (font)
			update_resource
			display_font (font)
			caller.update (resource)
		end

	display_font (a_font: EV_FONT) is
			-- Display font in example label.
		do
			example.set_font (a_font)
		end

feature {NONE} -- Implementation

	build_change_item_widget is
			-- Create and setup `change_item_widget'.
		local
			h2: EV_HORIZONTAL_BOX
			a_frame: EV_FRAME
		do
			create h2
			h2.set_padding (3)
			
			create change_b.make_with_text_and_action ("Change ...", agent change)
			change_b.set_minimum_height (change_b.height)

			create example
			example.set_text (example_string)

			h2.extend (example)
			h2.extend (change_b)
			h2.disable_item_expand (change_b)

			create a_frame
			a_frame.extend (h2)
			change_item_widget := a_frame
		end

	resource: FONT_RESOURCE
			-- Resource.

	change_b: EV_BUTTON
			-- Button

	font_tool: EV_FONT_DIALOG
			-- Dialog from which we can select a font.

	example: EV_LABEL
			-- Example label using the selected font.

	example_string: STRING is "Abc"

end -- class FONT_SELECTION_BOX
