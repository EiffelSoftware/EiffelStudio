indexing
	description: 
	"ACTIONS_WINDOW, base class for all actions windows. Belongs to EiffelVision example test_all_widgets."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class 
	ACTIONS_WINDOW

inherit
	EV_WINDOW
	
	
creation
	make_with_main_widget

feature -- Access
	
	Default_string_length: INTEGER is 5;
	
	table: EV_TABLE
	
	active_widget: EV_WIDGET

feature -- Initialization
	
	make_with_main_widget (par: EV_WINDOW; main_widget: EV_WIDGET) is
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
			show_button, hide_button, get_size_b, set_size_b: ACTIONS_WINDOW_BUTTON
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
			!! table.make (Current)
			table.set_homogeneous (False)

			!!hide_c
			!!show_c
			!!a.make (active_widget)
			
			-- Show and hide button
			!!show_button.make_button (table, "Show", a, show_c)
			table.set_child_position (show_button, 0, 0, 4, 1)
			!!hide_button.make_button (table, "Hide", a, hide_c)
			table.set_child_position (hide_button, 4, 0, 8, 1)
			!!vsep.make (table)
			table.set_child_position (vsep, 0, 1, 8, 2)
			vsep.set_minimum_width (10)

			-- Width and height entries
			!!width_entry.make_with_label (table, "Width: ")
			table.set_child_position (width_entry.box, 0, 2, 1, 4)
			!!height_entry.make_with_label (table, "Height: ")
			table.set_child_position (height_entry.box, 1, 2, 2, 4)

			-- Get and set buttons
			!!aaa.make_3 (active_widget, width_entry, height_entry)
			!!g_s_c
			!!get_size_b.make_button (table, "Get", aaa, g_s_c)
			table.set_child_position (get_size_b, 2, 2, 3, 3)
			!!s_s_c
			!!set_size_b.make_button (table, "Set", aaa, s_s_c)
			table.set_child_position (set_size_b, 2, 3, 3, 4)
			set_size_b.set_insensitive (True)
			!!hsep.make (table)
			table.set_child_position (hsep, 3, 2, 5, 4)
			hsep.set_minimum_height (10)

			-- Minimum width and height entries
			!!min_width_entry.make_with_label (table, "Minimum width: ")
			table.set_child_position (min_width_entry.box, 5, 2, 6, 4)
			!!min_height_entry.make_with_label (table, "Minimum height: ")
			table.set_child_position (min_height_entry.box, 6, 2, 7, 4)
			
			-- Get and set buttons
			!!aaa.make_3 (active_widget, min_width_entry, min_height_entry)
			!!g_ms_c
			!!get_size_b.make_button (table, "Get", aaa, g_ms_c)
			table.set_child_position (get_size_b, 7, 2, 8, 3)
			!!s_ms_c
			!!set_size_b.make_button (table, "Set", aaa, s_ms_c)
			table.set_child_position (set_size_b, 7, 3, 8, 4)
		end
	
	set_values is
		local
			s: STRING
 		do
			set_title ("Control widget behavior")
 		end

end
--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
