indexing
	description: 
		"Eiffel Vision cell, Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_CELL_IMP
	
inherit
	EV_CELL_I
		redefine
			interface
		end

	EV_SINGLE_CHILD_CONTAINER_IMP
		undefine
			propagate_foreground_color,
			propagate_background_color
		redefine
			interface,
			compute_minimum_width,
			compute_minimum_height,
			compute_minimum_size
		end

	EV_WEL_CONTROL_CONTAINER_IMP
		rename
			make as ev_wel_control_container_make
		redefine
			top_level_window_imp
		end

create
	make

feature {NONE} -- initialization

	make (an_interface: like interface) is
			-- Create `Current'.
		do
			base_make (an_interface)
			ev_wel_control_container_make
		end

feature -- Element change

	top_level_window_imp: EV_WINDOW_IMP
			-- Top level window that contains `Current'.

	set_top_level_window_imp (a_window: EV_WINDOW_IMP) is
			-- Make `a_window' the new `top_level_window_imp'
			-- of `Current'.
		do
			top_level_window_imp := a_window
			if item_imp /= Void then
				item_imp.set_top_level_window_imp (a_window)
			end
		end

feature {EV_ANY_I} -- Implementation

	compute_minimum_width is
			-- Recompute the minimum_width of `Current'.
		do
			if item_imp /= Void and item_imp.is_show_requested then
				ev_set_minimum_width (item_imp.minimum_width)
			end
		end

	compute_minimum_height is
			-- Recompute the minimum_width of `Current'.
		do
			if item_imp /= Void and item_imp.is_show_requested then
				ev_set_minimum_height (item_imp.minimum_height)
			end
		end

	compute_minimum_size is
			-- Recompute both the minimum_width the
			-- minimum_height of `Current'.
		do
			if item_imp /= Void and item_imp.is_show_requested then
				ev_set_minimum_size (item_imp.minimum_width, 
					item_imp.minimum_height)
			end
		end

	interface: EV_CONTAINER
			-- Provides a common user interface to possibly dependent
			-- functionality implemented by `Current'.

end -- class EV_CELL_IMP

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

