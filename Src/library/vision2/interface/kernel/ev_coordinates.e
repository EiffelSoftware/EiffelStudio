--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: "EiffelVision coordinates (x, y)";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EV_COORDINATES

inherit
	ANY
		redefine
			out
		end

create
	default_create,
	make,
	set

feature {NONE} -- Initialization

	make is
			-- Empty initialization.
		obsolete
			"Use the default_create method."
		do
		end

feature -- Access

	x: INTEGER
			-- Horizontal position.

	y: INTEGER
			-- Vertical position.

feature -- Element change

	set (new_x, new_y: INTEGER) is
			-- Set `x' to `new_x' and `y' to `new_y'.
		do
			x := new_x
			y := new_y
		ensure
			x_set: x = new_x
			y_set: y = new_y
		end

	set_x (new_x: INTEGER) is
			-- Set `x' to `new_x'.
		do
			x := new_x
		ensure
			x_set: x = new_x
		end

	set_y (new_y: INTEGER) is
			-- Set `y' to `new_y'.
		do
			y := new_y
		ensure
			y_set: y = new_y
		end
		
feature -- Debug

	print_contents is
			-- Write string representation to standard output.
		obsolete
			"Use: io.put_string (yours.out)."
		do
			io.put_string (out)
		end

	out: STRING is
			-- Return readable string.
		do
			Result := "(X: " + x.out + ", Y: " + y.out + ")%N"
		end

end -- class EV_COORDINATES

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!----------------------------------------------------------------


--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.2  2000/02/14 12:05:12  oconnor
--| added from prerelease_20000214
--|
--| Revision 1.1.2.3  2000/02/04 04:36:50  oconnor
--| released
--|
--| Revision 1.1.2.2  2000/01/27 19:30:43  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.1.2.1  2000/01/24 23:43:49  oconnor
--| mv ev_point.e ev_coordinates.e
--|
--| Revision 1.6.4.1.2.1  1999/11/24 17:30:46  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.6.2.2  1999/11/02 17:20:11  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
