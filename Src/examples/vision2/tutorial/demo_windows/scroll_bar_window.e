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

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the demo in `par'.
			-- We create the box first without parent because it
			-- is faster.
		do
			{EV_HORIZONTAL_SCROLL_BAR} Precursor (Void)
			
			set_gauge_tabs
			create scroll_bar_tab.make (Void)
			tab_list.extend(scroll_bar_tab)
			create action_window.make(Current,tab_list)
			make_with_range (par, 0, 100)
			set_parent(par)

		end


feature -- Access

	scroll_bar_tab: SCROLL_BAR_TAB

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

 

