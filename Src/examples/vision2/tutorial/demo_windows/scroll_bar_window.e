indexing
	description:
		"The demo that goes with the gauge demo";
	date: "$Date$";
	revision: "$Revision$"

class
	SCROLL_BAR_WINDOW

inherit
	EV_HORIZONTAL_SCROLL_BAR
		redefine
			make
		end

	DEMO_WINDOW
	WIDGET_COMMANDS

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the demo in `par'.
			-- We create the box first without parent because it
			-- is faster.
		do

			{EV_HORIZONTAL_SCROLL_BAR} Precursor (Void)	
			make_with_range (par, 0, 100)
			create event_window.make (Current)
			add_widget_commands (Current, event_window, "scroll bar")
			set_parent(par)
		end

	set_tabs is
			-- Set the tabs for the action window.
		do
			set_gauge_tabs
			tab_list.extend(scroll_bar_tab)
			create action_window.make(Current,tab_list)
		end



end -- class SCROLL_BAR_WINDOW

--|----------------------------------------------------------------
--| EiffelVision Tutorial: Example for the ISE EiffelVision library.
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

 

