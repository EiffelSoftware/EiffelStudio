indexing
	description: 
		"ACTIONS_WINDOW, base class for all actions windows.%
		% Belongs to EiffelVision example test_all_widgets."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class 
	ACTIONS_WINDOW

inherit
	EV_WINDOW

create
	make_with_main_widget

feature -- Access
	
	Default_string_length: INTEGER is 5;
	
	table: EV_TABLE
		-- A table to organise the widgets
	
	active_widget: EV_WIDGET
		-- The widget on which it works

feature -- Initialization
	
	make_with_main_widget (par: EV_WINDOW; main_widget: EV_WIDGET) is
			-- Create the action windows
		do
			make (par)
			active_widget := main_widget
			set_widgets
			set_values
		end
	
feature -- Status setting
        
	set_widgets is
			-- Create the widgets inside the window
		local
			show_button, hide_button, get_size_b, set_size_b: EV_BUTTON
			width_entry, height_entry, min_width_entry, min_height_entry: EV_TEXT_FIELD_WITH_LABEL
			hide_c: HIDE_COMMAND
			show_c: SHOW_COMMAND
			s_s_c: SET_SIZE_COMMAND			
			g_s_c: GET_SIZE_COMMAND			
			s_ms_c: SET_MIN_SIZE_COMMAND			
			g_ms_c: GET_MIN_SIZE_COMMAND			
			a: EV_ARGUMENT1 [EV_WIDGET]
			aaa: EV_ARGUMENT3 [EV_WIDGET, EV_TEXT_FIELD, EV_TEXT_FIELD]
			vsep: EV_VERTICAL_SEPARATOR
			hsep: EV_HORIZONTAL_SEPARATOR
                do
			create table.make (Current)
			table.set_homogeneous (False)

			create hide_c
			create show_c
			create a.make (active_widget)
			
			-- Show and hide button
			create show_button.make_with_text (table, "Show")
			show_button.add_click_command (show_c, a)
			table.set_child_position (show_button, 0, 0, 4, 1)
			create hide_button.make_with_text (table, "Hide")
			hide_button.add_click_command (hide_c, a)
			table.set_child_position (hide_button, 4, 0, 8, 1)
			create vsep.make (table)
			table.set_child_position (vsep, 0, 1, 8, 2)
			vsep.set_minimum_width (10)

			-- Width and height entries
			create width_entry.make_with_label (table, "Width: ")
			table.set_child_position (width_entry.box, 0, 2, 1, 4)
			create height_entry.make_with_label (table, "Height: ")
			table.set_child_position (height_entry.box, 1, 2, 2, 4)

			-- Get and set buttons
			create aaa.make (active_widget, width_entry, height_entry)
			create g_s_c
			create get_size_b.make_with_text (table, "Get")
 			get_size_b.add_click_command (g_s_c, aaa)
			table.set_child_position (get_size_b, 2, 2, 3, 3)
			create s_s_c
			create set_size_b.make_with_text (table, "Set")
			set_size_b.add_click_command (s_s_c, aaa)
			table.set_child_position (set_size_b, 2, 3, 3, 4)
			set_size_b.set_insensitive (True)
			create hsep.make (table)
			table.set_child_position (hsep, 3, 2, 5, 4)
			hsep.set_minimum_height (10)

			-- Minimum width and height entries
			create min_width_entry.make_with_label (table, "Minimum width: ")
			table.set_child_position (min_width_entry.box, 5, 2, 6, 4)
			create min_height_entry.make_with_label (table, "Minimum height: ")
			table.set_child_position (min_height_entry.box, 6, 2, 7, 4)
			
			-- Get and set buttons
			create aaa.make (active_widget, min_width_entry, min_height_entry)
			create g_ms_c
			create get_size_b.make_with_text (table, "Get")
			get_size_b.add_click_command (g_ms_c, aaa)
			table.set_child_position (get_size_b, 7, 2, 8, 3)
			create s_ms_c
			create set_size_b.make_with_text (table, "Set")
			set_size_b.add_click_command (s_ms_c, aaa)
			table.set_child_position (set_size_b, 7, 3, 8, 4)
		end
	
	set_values is
			-- Set the values on the widgets.
 		do
			set_title ("Control widget behavior")
 		end

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


end -- class ACTION_WINDOW

