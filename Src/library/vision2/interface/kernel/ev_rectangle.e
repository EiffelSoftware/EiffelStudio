--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: "EiffelVision clip. Rectangular area.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EV_RECTANGLE

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

	make (a_x, a_y, a_width, a_height: INTEGER) is
			-- 
		require
			a_width_positive: a_width >= 0
			a_height_positive: a_height >= 0
		do
			x := a_x
			y := a_y
			width := a_width
			height := a_height
		end

feature -- Access

	x: INTEGER
			-- Horizontal position.

	y: INTEGER
			-- Vertical position.

	width: INTEGER
			-- Width of the clip area

	height: INTEGER
			-- Height of the clip area.

feature -- Status report

	upper_left: EV_COORDINATES is
			-- Upper-left corner of the clip area.
		do
			create Result.set (x, y)
		ensure
			Result_exists: Result /= Void
			Result_assigned: Result.x = x and then Result.y = y
		end

	upper_right: EV_COORDINATES is
			-- Upper-right corner of the clip area.
		do
			create Result.set (x + width, y)
		ensure
			Result_exists: Result /= Void
			Result_assigned: Result.x = x + width and then Result.y = y
		end

	lower_left: EV_COORDINATES is
			-- Lower-left corner of the clip area.
		do
			create Result.set (x, y + height)
		ensure
			Result_exists: Result /= Void
			Result_assigned: Result.x = x and then Result.y = y + height
		end

	lower_right: EV_COORDINATES is
			-- Lower-right corner of the clip area.
		do
			create Result.set (x + width, y + height)
		ensure
			Result_exists: Result /= Void
			Result_assigned: Result.x = x + width and then Result.y = y + height
		end

feature -- Element change

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

	set_width (new_width: INTEGER) is
			-- Set 'width' to `new_width'.
		require
			new_width_positive: new_width >= 0
		do
			width := new_width
		ensure
			width_assigned: width = new_width
		end

	set_height (new_height: INTEGER) is
			-- Set `height' to `new_height'.
		require
			new_height_positive: new_height >= 0
		do
			height := new_height
		ensure
			height_assigned: height = new_height
		end

	set (upper_left_POINT: EV_COORDINATES; new_width, new_height: INTEGER) is
			-- Set all values op the clip area.
		require
			upper_left_POINT: upper_left_POINT /= Void
			new_width_positive: new_width >= 0
			new_height_positive: new_height >= 0
		do
			x := upper_left_POINT.x
			y := upper_left_POINT.y
			width := new_width
			height := new_height
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
			Result := "(X: " + x.out + ", Y: " + y.out +
				", Width: " + width.out +
				", Height: " + height.out + ")%N"
		end

invariant
	width_positive: width >= 0
	height_positive: height >= 0

end -- class EV_RECTANGLE

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
--| Revision 1.6  2000/02/14 11:40:48  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.5.4.1.2.5  2000/02/04 05:02:31  oconnor
--| released
--|
--| Revision 1.5.4.1.2.4  2000/01/27 19:30:45  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.5.4.1.2.3  2000/01/24 23:54:22  oconnor
--| renamed EV_CLIP -> EV_RECTANGLE
--|
--| Revision 1.5.4.1.2.2  2000/01/20 19:06:09  brendel
--| Changed make to something useful.
--|
--| Revision 1.5.4.1.2.1  1999/11/24 17:30:46  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.5.2.2  1999/11/02 17:20:11  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
