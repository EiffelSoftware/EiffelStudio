indexing
	description	: "Default widget for viewing and editing color resources."
	date		: "$Date$"
	revision	: "$Revision$"

class
	DIRECTORY_RESOURCE_WIDGET

inherit
	PREFERENCE_WIDGET
		redefine
			resource, 
			change_item_widget,
			update_changes
		end
		
create
	make,
	make_with_resource
		
feature -- Access

	graphical_type: STRING is
			-- Graphical type identifier.
		do
			Result := "DIRECTORY"
		end	
		
	resource: DIRECTORY_RESOURCE
			-- Actual resource.

	last_selected_value: DIRECTORY_NAME

	change_item_widget: EV_GRID_DRAWABLE_ITEM

feature {PREFERENCE_VIEW} -- Commands

	change is
			-- Change the value.
		require
			resource_exists: resource /= Void
			in_view: caller /= Void
		do
			create directory_tool
			directory_tool.ok_actions.extend (agent update_changes)
			directory_tool.show_modal_to_window (caller.parent_window)
		end 
		
feature {NONE} -- Commands

	update_changes is
			-- Update the changes made in `change_item_widget' to `resource'.		
		local
			directory: STRING
		do
			directory := directory_tool.directory
			create last_selected_value.make_from_string (directory)
			if last_selected_value /= Void then
				resource.set_value (last_selected_value)
			end	
			Precursor {PREFERENCE_WIDGET}
		end
		
	update_resource is
			-- 
		do
			if last_selected_value /= Void then
				resource.set_value (last_selected_value)
			end	
		end		

feature {NONE} -- Implementation

	build_change_item_widget is
			-- Create and setup `change_item_widget'.
		do
			create change_item_widget
			change_item_widget.expose_actions.extend (agent on_directory_item_exposed (?))
			change_item_widget.set_data (resource)			
			change_item_widget.pointer_double_press_actions.force_extend (agent show_change_item_widget)
		end

	show_change_item_widget is
			-- 
		do
			change
			if last_selected_value /= Void then
				resource.set_value (last_selected_value)
			end
		end		

	on_directory_item_exposed (area: EV_DRAWABLE) is
			-- Expose part of directory preference value item.
		do
			if change_item_widget.row.is_selected then				
				area.set_foreground_color (change_item_widget.parent.focused_selection_color)
				area.fill_rectangle (0, 0, change_item_widget.width, change_item_widget.height)
				area.set_foreground_color ((create {EV_STOCK_COLORS}).white)
				area.draw_text_top_left (5, 1, resource.string_value)					
			else
				area.set_foreground_color ((create {EV_STOCK_COLORS}).white)
				area.fill_rectangle (0, 0, change_item_widget.width, change_item_widget.height)
				area.set_foreground_color ((create {EV_STOCK_COLORS}).black)
				area.draw_text_top_left (5, 1, resource.string_value)					
			end			
--			area.set_foreground_color ((create {EV_STOCK_COLORS}).black)
--			area.draw_rectangle (1, 1, 12, 12)
--			area.set_foreground_color (resource.value)
--			area.fill_rectangle (2, 2, 10, 10)			
		end		

	directory_tool: EV_DIRECTORY_DIALOG
			-- Directory dialog from which we can select a color.

end -- class DIRECTORY_PREFERENCE_WIDGET
