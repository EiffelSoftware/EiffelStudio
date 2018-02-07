note
	description	: "Default widget for viewing and editing color preferences."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

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
	make_with_preference

feature -- Access

	change_item_widget: EV_GRID_DRAWABLE_ITEM

	graphical_type: STRING
			-- Graphical type identifier.
		do
			Result := "DIRECTORY"
		end


	last_selected_value: detachable like {DIRECTORY_RESOURCE}.value

feature -- Basic operations

	show
			-- Show widget
		do
			show_change_item_widget (0, 0, 0, 0, 0, 0, 0, 0)
		end

feature {PREFERENCE_VIEW} -- Commands

	change
			-- Change the value.
		require
			preference_exists: preference /= Void
			in_view: caller /= Void
		local
			l_directory_tool: like directory_tool
		do
			create l_directory_tool
			directory_tool := l_directory_tool
			l_directory_tool.ok_actions.extend (agent update_changes)
			if attached caller as l_caller and then attached l_caller.parent_window as p then
				l_directory_tool.show_modal_to_window (p)
			else
				check caller_has_parent_window: False end
			end
		end

feature {NONE} -- Commands

	update_changes
			-- Update the changes made in `change_item_widget' to `preference'.		
		local
			directory: STRING_32
			l_last_selected_value: like last_selected_value
		do
			if attached directory_tool as d then
				directory := d.directory
				create l_last_selected_value.make_from_string (directory)
				last_selected_value := l_last_selected_value
				preference.set_value (l_last_selected_value)
			end
			Precursor {PREFERENCE_WIDGET}
		end

feature {PREFERENCE_VIEW} -- Implementation

	preference: DIRECTORY_RESOURCE
			-- Actual preference.

feature {NONE} -- Implementation

	build_change_item_widget
			-- Create and setup `change_item_widget'.
		local
			l_change_item_widget: like change_item_widget
		do
			create l_change_item_widget
			change_item_widget := l_change_item_widget
			l_change_item_widget.expose_actions.extend (agent on_directory_item_exposed (?))
			l_change_item_widget.set_data (preference)
			l_change_item_widget.pointer_double_press_actions.extend (agent show_change_item_widget)
		end

	show_change_item_widget (x, y, b: INTEGER_32; x_tilt, y_tilt, pressure: REAL_64; screen_x, screen_y: INTEGER_32)
			-- Show change widget
		do
			change
			if attached last_selected_value as v then
				preference.set_value (v)
			end
		end

	on_directory_item_exposed (area: EV_DRAWABLE)
			-- Expose part of directory preference value item.
		do
			if change_item_widget.row.is_selected then
				if attached change_item_widget.parent as p then
					area.set_foreground_color (p.focused_selection_color)
				end
				area.fill_rectangle (0, 0, change_item_widget.width, change_item_widget.height)
				area.set_foreground_color ((create {EV_STOCK_COLORS}).white)
				area.draw_text_top_left (5, 1, preference.value)
			else
				area.set_foreground_color ((create {EV_STOCK_COLORS}).white)
				area.fill_rectangle (0, 0, change_item_widget.width, change_item_widget.height)
				area.set_foreground_color ((create {EV_STOCK_COLORS}).black)
				area.draw_text_top_left (5, 1, preference.value)
			end
		end

	directory_tool: detachable EV_DIRECTORY_DIALOG;
			-- Directory dialog from which we can select a color.

note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
