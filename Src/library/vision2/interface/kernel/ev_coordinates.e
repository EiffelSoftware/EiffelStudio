indexing
	description:
		"A position in a 2 dimensional space as INTEGERs (x, y)"
	status: "See notice at end of class"
	date: "$Date$"
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
	set

feature -- Access

	x: INTEGER
			-- Horizontal position.

	y: INTEGER
			-- Vertical position.

feature -- Element change

	set (a_x, a_y: INTEGER) is
			-- Assign `a_x' to `x' and `a_y' to `y'.
		do
			x := a_x
			y := a_y
		ensure
			x_assigned: x = a_x
			y_assigned: y = a_y
		end

	set_x (a_x: INTEGER) is
			-- Assign `a_x' to `x'.
		do
			x := a_x
		ensure
			x_assigned: x = a_x
		end

	set_y (a_y: INTEGER) is
			-- Assign `a_y' to `y'.
		do
			y := a_y
		ensure
			y_assigned: y = a_y
		end
		
feature -- Output

	out: STRING is
			-- Textual representation.
		do
			Result := "(X: " + x.out + ", Y: " + y.out + ")%N"
		end

feature {NONE} -- Obsolete

	make is
			-- Empty initialization.
		obsolete
			"Use the default_create method."
		do
		end

end -- class EV_COORDINATES

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
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
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.7  2000/03/16 01:33:47  oconnor
--| typo fix
--|
--| Revision 1.6  2000/03/16 01:12:44  oconnor
--| improved operand names and comments
--|
--| Revision 1.5  2000/02/29 19:20:22  oconnor
--| removed simicolons from indexing
--|
--| Revision 1.4  2000/02/29 18:09:08  oconnor
--| reformatted indexing cluase
--|
--| Revision 1.3  2000/02/22 18:39:48  oconnor
--| updated copyright date and formatting
--|
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
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
