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
	
	main_box: EV_VERTICAL_BOX
	
	active_widget: EV_WIDGET

feature -- Initialization
	
	make_with_main_widget (main_widget: EV_WIDGET) is
		do
			make
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
			common_box, tmp: EV_HORIZONTAL_BOX 
			buttons_box, entries_box: EV_VERTICAL_BOX
			hide_c: HIDE_COMMAND
			show_c: SHOW_COMMAND
			s_s_c: SET_SIZE_COMMAND			
			g_s_c: GET_SIZE_COMMAND			
			s_ms_c: SET_MIN_SIZE_COMMAND			
			g_ms_c: GET_MIN_SIZE_COMMAND			
			a: EV_ARGUMENT1 [EV_WIDGET]
			aaa: EV_ARGUMENT3 [EV_WIDGET, EV_TEXT_FIELD, EV_TEXT_FIELD]
                do
			!!main_box.make (Current)
			!!common_box.make (main_box)
			common_box.set_homogeneous (False)
			common_box.set_spacing (5)
			!!buttons_box.make (common_box)
			!!entries_box.make (common_box)
			
			!!hide_c
			!!show_c
			!!a.make (active_widget)
			
			!!show_button.make_button (buttons_box, "Show", a, show_c)
			!!hide_button.make_button (buttons_box, "Hide", a, hide_c)

			!!width_entry.make_with_label (entries_box, "Width: ")
			!!height_entry.make_with_label (entries_box, "Height: ")
			!!tmp.make (entries_box)
			
			!!aaa.make_3 (active_widget, width_entry, height_entry)
			
			!!g_s_c
			!!get_size_b.make_button (tmp, "Get", aaa, g_s_c)
			!!s_s_c
			!!set_size_b.make_button (tmp, "Set", aaa, s_s_c)
			
			!!min_width_entry.make_with_label (entries_box, "Minimum width: ")
			!!min_height_entry.make_with_label (entries_box, "Minimum height: ")
			!!tmp.make (entries_box)
			
			!!aaa.make_3 (active_widget, min_width_entry, min_height_entry)
			
			!!g_ms_c
			!!get_size_b.make_button (tmp, "Get", aaa, g_ms_c)
			!!s_ms_c
			!!set_size_b.make_button (tmp, "Set", aaa, s_ms_c)
		end
	
	set_values is
		local
			s: STRING
 		do
			set_title ("Control widget behavior")

			main_box.set_homogeneous (False)
			main_box.set_spacing (10)
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
