indexing
	description: "Eiffel Vision viewport. Implementation interface."
	status: "See notice at end of class"
	keywords: "container, virtual, display"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_VIEWPORT_I

inherit
	EV_CELL_I

feature -- Access

	x_offset: INTEGER is
			-- Horizontal position of viewport relative to `item'.
		deferred
		end

	y_offset: INTEGER is
			-- Vertical position of viewport relative to `item'.
		deferred
		end

feature -- Element change

	set_x_offset (an_x: INTEGER) is
			-- Assign `an_x' to `x_offset'.
		deferred
		ensure
			assigned: x_offset = an_x
		end

	set_y_offset (a_y: INTEGER) is
			-- Assign `a_y' to `y_offset'.
		deferred
		ensure
			assigned: y_offset = a_y
		end

	set_offset (an_x, a_y: INTEGER) is
			-- Assign `an_x' to `x_offset'.
			-- Assign `a_y' to `y_offset'.
		do
			set_x_offset (an_x)
			set_y_offset (a_y)
		ensure
			assigned: x_offset = an_x
			assigned: y_offset = a_y
		end

end -- class EV_VIEWPORT_I

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

