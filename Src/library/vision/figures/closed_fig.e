indexing

	description: 
		"Closed figures (e.g. circles, polygons). % 
		%Such figures may be filled with a fill pattern";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	CLOSED_FIG 

inherit

	FIGURE

feature -- Access 
	
	center: COORD_XY_FIG is
			-- Center of the closed figure
		deferred
		end;

	interior: INTERIOR;
			-- Type of the interior
			-- Void if the figure shouldn't be filled

	path: PATH;
			-- Type of path
			-- Void if the path of the figure shouldn't be drawn

feature -- Status setting

	set_origin_to_center is
			-- Set origin to `center'
		deferred
		end;

	set_interior (an_interior: INTERIOR) is
			-- Set `interior' to `an_interior'.
		do
			interior := an_interior;
		ensure
			interior = an_interior
		end;

	set_path (a_path: PATH) is
			-- Set `path' to `a_path'.
		do
			path := a_path;
		ensure
			path = a_path
		end

end -- class CLOSED_FIG


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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

