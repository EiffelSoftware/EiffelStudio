indexing
	description: "EiffelVision closed figures (ellipse, polygon).%
				% May be filled with a fill pattern."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_CLOSED_FIGURE

inherit
	EV_FIGURE

feature -- Access
	
	center: EV_POINT is
			-- Center of the closed figure
		deferred
		end

	interior: EV_INTERIOR
			-- Type of the interior
			-- Void if the figure shouldn't be filled

	path: EV_PATH
			-- Type of path
			-- Void if the path of the figure shouldn't be drawn

feature -- Status setting

	set_origin_to_center is
			-- Set origin to `center'
		deferred
		end

	set_interior (an_interior: EV_INTERIOR) is
			-- Set `interior' to `an_interior'.
		do
			interior := an_interior
		ensure
			interior = an_interior
		end

	set_path (a_path: EV_PATH) is
			-- Set `path' to `a_path'.
		do
			path := a_path
		ensure
			path = a_path
		end

end -- class EV_CLOSED_FIGURE

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

