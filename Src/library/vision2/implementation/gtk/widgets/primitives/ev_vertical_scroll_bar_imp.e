indexing
	description:
		"EiffelVision vertical scroll bar. Gtk implementation."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_VERTICAL_SCROLL_BAR_IMP

inherit
	EV_VERTICAL_SCROLL_BAR_I

	EV_SCROLL_BAR_IMP
		undefine
			set_default_options
		end

create
	make,
	make_with_range

feature {NONE} -- Initialization

	make is
			-- Create a vscrolbar with 0 as minimum,
			-- 100 as maximum and `par' as parent.
		do
			-- Parameters are:
			-- value, lower, upper, step_increment, page_increment, page_size.
			widget := c_gtk_vscrollbar_new (0, 0, 100, 1, 5, 1)

			adjustment_widget := c_gtk_range_adjustment (widget)
			gtk_object_ref (widget)
		end

	make_with_range (min: INTEGER; max: INTEGER) is
			-- Create a vscrolbar with `min' as minimum, `max' as maximum
			-- and `par' as parent.
		do
			-- Parameters are:
			-- value, lower, upper, step_increment, page_increment, page_size.
			widget := c_gtk_vscrollbar_new (0, 0, 100, 1, 5, 1)
			gtk_object_ref (widget)
		end

end -- class EV_VERTICAL_SCROLL_BAR_IMP

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
