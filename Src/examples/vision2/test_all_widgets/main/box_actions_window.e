indexing
	description: 
	"BOX_ACTIONS_WINDOW, base class for all actions windows.%
	% Belongs to EiffelVision example test_all_widgets."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class 
	BOX_ACTIONS_WINDOW
	
inherit
	ACTIONS_WINDOW
		redefine
			set_widgets
		end

creation
	make_with_main_widget

feature -- Status setting
        
	set_widgets is
			-- Create the widgets inside the window
		local
			set_h_c: SET_HOMOGENEOUS_COMMAND
			a: EV_ARGUMENT2 [EV_BOX, EV_TOGGLE_BUTTON]
			a2: EV_ARGUMENT2 [EV_BOX, EV_TEXT_FIELD]
			homogeneous_tb: EV_TOGGLE_BUTTON
			box_widget: EV_BOX
			spacing_entry: EV_TEXT_FIELD_WITH_LABEL
			set_spacing_c: SET_SPACING_COMMAND
			hsep: EV_HORIZONTAL_SEPARATOR
                do
			{ACTIONS_WINDOW} Precursor
			!! hsep.make (table)
			table.set_child_position (hsep, 8, 0, 9, 4)
			hsep.set_minimum_height (10)

			!! homogeneous_tb.make_with_text (table, "Homogeneous")
			table.set_child_position (homogeneous_tb, 9, 0, 10, 2)
			!! set_h_c
			box_widget ?= active_widget
			!! a.make (box_widget, homogeneous_tb)
			homogeneous_tb.add_click_command (set_h_c, a)
			
			!! spacing_entry.make_with_label (table, "Spacing:")
			table.set_child_position (spacing_entry.box, 9, 2, 10, 4)
			!! a2.make (box_widget, spacing_entry)
			!! set_spacing_c
			spacing_entry.add_activate_command (set_spacing_c, a2)
		end
	
end -- class BOX_ACTION_WINDOW

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

