indexing
	description: 
	"BOX_ACTIONS_WINDOW, base class for all actions windows.%
	% Belongs to EiffelVision example test_all_widgets."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

create
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
			Precursor {ACTIONS_WINDOW}
			create hsep.make (table)
			table.set_child_position (hsep, 8, 0, 9, 4)
			hsep.set_minimum_height (10)

			create homogeneous_tb.make_with_text (table, "Homogeneous")
			table.set_child_position (homogeneous_tb, 9, 0, 10, 2)
			create set_h_c
			box_widget ?= active_widget
			create a.make (box_widget, homogeneous_tb)
			homogeneous_tb.add_click_command (set_h_c, a)
			
			create spacing_entry.make_with_label (table, "Spacing:")
			table.set_child_position (spacing_entry.box, 9, 2, 10, 4)
			create a2.make (box_widget, spacing_entry)
			create set_spacing_c
			spacing_entry.add_activate_command (set_spacing_c, a2)
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


end -- class BOX_ACTION_WINDOW

