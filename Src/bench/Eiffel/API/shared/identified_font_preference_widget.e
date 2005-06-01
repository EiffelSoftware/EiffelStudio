indexing
	description	: "Default widget for viewing and editing font resources."
	date		: "$Date$"
	revision	: "$Revision$"

class
	IDENTIFIED_FONT_PREFERENCE_WIDGET

inherit
	PREFERENCE_WIDGET
		redefine
			resource, 
			set_resource
		end
		
	EV_SHARED_SCALE_FACTORY
		undefine	
			default_create
		end

create
	make

feature -- Status Setting
	
	set_resource (new_resource: like resource) is
			-- Set the resource.
		do
			Precursor (new_resource)
			display_font (resource.value.font)
		end

feature -- Access

	graphical_type: STRING is
			-- Graphical type identifier.
		do
			Result := "IDENTIFIED_FONT"
		end	

	resource: IDENTIFIED_FONT_PREFERENCE
			-- Actual resource.

	last_selected_value: EV_IDENTIFIED_FONT

feature {PREFERENCE_VIEW} -- Commands

	change is
			-- Change the value.
		require
			resource_exists: resource /= Void
			in_view: caller /= Void
		do
				-- Create Font Tool.
			create font_tool
			font_tool.set_font (resource.value.font)

			font_tool.ok_actions.extend (agent update_changes)
			font_tool.show_modal_to_window (caller.parent_window)
		end 

feature {NONE} -- Commands

	update_changes is
			-- Commit the result of Font Tool.
		do
			last_selected_value := font_factory.registered_font (font_tool.font)
			display_font (last_selected_value.font)
		end
		
	update_resource is
			-- 
		do
			if last_selected_value /= Void then
				resource.set_value (last_selected_value)				
			end
		end		

	reset is
			-- 
		do
			if resource.has_default_value then
				resource.reset
			end	
			display_font (resource.value.font)
		end	

	display_font (a_font: EV_FONT) is
			-- Display font in example label.
		require
			font_not_void: a_font /= Void
		do	
			example_label.set_font (a_font)	
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

			create example_label
			example_label.set_text (example_string)

			h2.extend (example_label)
			h2.extend (change_b)
			h2.disable_item_expand (change_b)

			create a_frame
			a_frame.extend (h2)
			change_item_widget := a_frame
		end

	change_b: EV_BUTTON
			-- Button to popup EV_FONT_DIALOG.

	font_tool: EV_FONT_DIALOG
			-- Dialog from which we can select a font.

	example_label: EV_LABEL
			-- Example label using the selected font for preview.

	example_string: STRING is "Abc"
			-- Example string to use in `example_label'.

end -- class IDENTIFIED_FONT_PREFERENCE_WIDGET
