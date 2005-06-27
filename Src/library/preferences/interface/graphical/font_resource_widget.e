indexing
	description	: "Default widget for viewing and editing font resources."
	date		: "$Date$"
	revision	: "$Revision$"

class
	FONT_PREFERENCE_WIDGET

inherit
	PREFERENCE_WIDGET
		redefine
			resource, 
			set_resource,
			change_item_widget,
			update_changes
		end

create
	make,
	make_with_resource

feature -- Status Setting
	
	set_resource (new_resource: like resource) is
			-- Set the resource.
		do
			Precursor (new_resource)
		end

feature -- Access

	graphical_type: STRING is
			-- Graphical type identifier.
		do
			Result := "FONT"
		end	

	resource: FONT_PREFERENCE
			-- Actual resource.

	last_selected_value: EV_FONT
			-- Value last selected by user.

	change_item_widget: EV_GRID_LABEL_ITEM
	
feature {PREFERENCE_VIEW} -- Commands

	change is
			-- Change the value.
		require
			resource_exists: resource /= Void
			in_view: caller /= Void
		do
				-- Create Font Tool.
			create font_tool
			font_tool.set_font (resource.value)

			font_tool.ok_actions.extend (agent update_changes)
			font_tool.cancel_actions.extend (agent cancel_changes)
			font_tool.show_modal_to_window (caller.parent_window)
		end 

feature {NONE} -- Commands

	update_changes is
			-- Commit the result of Font Tool.
		local
			font: EV_FONT
		do
			font := font_tool.font
			last_selected_value := font
			if last_selected_value /= Void then
				resource.set_value (last_selected_value)
				change_item_widget.set_font (last_selected_value)
				change_item_widget.set_text (resource.string_value)
			end
			Precursor {PREFERENCE_WIDGET}
		end

	cancel_changes is
			-- Commit the result of Font Tool.
		do
			last_selected_value := Void
		end

	update_resource is
			-- Update resource to reflect recently chosen value
		do
			if last_selected_value /= Void then
				resource.set_value (last_selected_value)	
			end
		end		

	show is
			-- Show the widget in its editable state
		do			
			show_change_item_widget
		end

feature {NONE} -- Implementation

	build_change_item_widget is
			-- Create and setup `change_item_widget'.
		do
			create change_item_widget
			change_item_widget.set_text (resource.string_value)
			change_item_widget.set_font (resource.value)
			change_item_widget.pointer_double_press_actions.force_extend (agent show_change_item_widget)
		end
		
	show_change_item_widget is
			-- 
		do
			change			
		end		

	font_tool: EV_FONT_DIALOG
			-- Dialog from which we can select a font.

end -- class FONT_PREFERENCE_WIDGET
