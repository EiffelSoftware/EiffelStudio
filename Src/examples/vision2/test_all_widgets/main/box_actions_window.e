indexing

	description: 
	"BOX_ACTIONS_WINDOW, base class for all actions windows. Belongs to EiffelVision example test_all_widgets."
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

feature -- Access
	
	box_controls: EV_HORIZONTAL_BOX


feature -- Status setting
        
	set_widgets is
			-- Create the widgets inside the window
		local
			set_h_c: SET_HOMOGENEOUS_COMMAND
			a: EV_ARGUMENT2 [EV_BOX, EV_TOGGLE_BUTTON]
			a2: EV_ARGUMENT2 [EV_BOX, EV_TEXT_FIELD]
			e: EV_EVENT
			homogeneous_tb: EV_TOGGLE_BUTTON
			box_widget: EV_BOX
			spacing_entry: EV_TEXT_FIELD_WITH_LABEL
			set_spacing_c: SET_SPACING_COMMAND
                do
			Precursor
			!!box_controls.make (main_box)
			!!homogeneous_tb.make_with_label (box_controls, "Homogeneous")
			!!e.make ("toggled")
			!!set_h_c
			box_widget ?= active_widget
			!!a.make_2 (box_widget, homogeneous_tb)
			homogeneous_tb.add_command (e, set_h_c, a)
			
			!!spacing_entry.make_with_label (box_controls, "Spacing:")
			!!e.make ("activate")
			!!a2.make_2 (box_widget, spacing_entry)
			!!set_spacing_c
			spacing_entry.add_command (e, set_spacing_c, a2)
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
