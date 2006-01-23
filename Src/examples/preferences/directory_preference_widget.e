indexing
	description	: "Default widget for viewing and editing color preferences."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	DIRECTORY_RESOURCE_WIDGET

inherit
	PREFERENCE_WIDGET
		redefine
			preference, 
			change_item_widget,
			update_changes
		end
		
create
	make,
	make_with_preference
		
feature -- Access

	graphical_type: STRING is
			-- Graphical type identifier.
		do
			Result := "DIRECTORY"
		end	
		
	preference: DIRECTORY_RESOURCE
			-- Actual preference.

	last_selected_value: DIRECTORY_NAME

	change_item_widget: EV_GRID_DRAWABLE_ITEM
	
	show is
			-- 
		do
			show_change_item_widget
		end		

feature {PREFERENCE_VIEW} -- Commands

	change is
			-- Change the value.
		require
			preference_exists: preference /= Void
			in_view: caller /= Void
		do
			create directory_tool
			directory_tool.ok_actions.extend (agent update_changes)
			directory_tool.show_modal_to_window (caller.parent_window)
		end 
		
feature {NONE} -- Commands

	update_changes is
			-- Update the changes made in `change_item_widget' to `preference'.		
		local
			directory: STRING
		do
			directory := directory_tool.directory
			create last_selected_value.make_from_string (directory)
			if last_selected_value /= Void then
				preference.set_value (last_selected_value)
			end	
			Precursor {PREFERENCE_WIDGET}
		end
		
	update_preference is
			-- 
		do
			if last_selected_value /= Void then
				preference.set_value (last_selected_value)
			end	
		end		

feature {NONE} -- Implementation

	build_change_item_widget is
			-- Create and setup `change_item_widget'.
		do
			create change_item_widget
			change_item_widget.expose_actions.extend (agent on_directory_item_exposed (?))
			change_item_widget.set_data (preference)			
			change_item_widget.pointer_double_press_actions.force_extend (agent show_change_item_widget)
		end

	show_change_item_widget is
			-- 
		do
			change
			if last_selected_value /= Void then
				preference.set_value (last_selected_value)
			end
		end		

	on_directory_item_exposed (area: EV_DRAWABLE) is
			-- Expose part of directory preference value item.
		do
			if change_item_widget.row.is_selected then				
				area.set_foreground_color (change_item_widget.parent.focused_selection_color)
				area.fill_rectangle (0, 0, change_item_widget.width, change_item_widget.height)
				area.set_foreground_color ((create {EV_STOCK_COLORS}).white)
				area.draw_text_top_left (5, 1, preference.string_value)					
			else
				area.set_foreground_color ((create {EV_STOCK_COLORS}).white)
				area.fill_rectangle (0, 0, change_item_widget.width, change_item_widget.height)
				area.set_foreground_color ((create {EV_STOCK_COLORS}).black)
				area.draw_text_top_left (5, 1, preference.string_value)					
			end			
		end		

	directory_tool: EV_DIRECTORY_DIALOG;
			-- Directory dialog from which we can select a color.

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class DIRECTORY_PREFERENCE_WIDGET
