indexing
	description:
		"The demo that goes with the spin button demo";
	date: "$Date$";
	revision: "$Revision$"

class
	SPIN_BUTTON_WINDOW

inherit
	EV_SPIN_BUTTON
		redefine
			make
		end

	DEMO_WINDOW
	WIDGET_COMMANDS
	TEXT_COMPONENT_COMMANDS
	TEXT_FIELD_COMMANDS
	

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the demo in `par'.
			-- We create the spin button first without parent because it
			-- is faster.
		do
			{EV_SPIN_BUTTON} Precursor (par)
			create event_window.make (Current)
			add_widget_commands (Current, event_window, "spin button")
			add_text_component_commands (Current, event_window, "Spin button")
			add_text_field_commands (Current, event_window, "spin button")
			set_parent(par)		
		end


	set_tabs is
			-- Set the tabs for the action window.
		do
			set_gauge_tabs
			tab_list.extend(spin_button_tab)
			create action_window.make(Current,tab_list)
		end


feature -- Access
	
	
end -- class SPIN_BUTTON_WINDOW

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

