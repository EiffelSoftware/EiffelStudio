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
			Result := "(X: " + x.out + ", Y: " + y.out + ")"
		end
		
feature -- Obsolete

	trace is
			-- Write string representation to standard output.
		Obsolete
			"Please do not use this feature as it will shortly be removed."
		do
			io.error.put_string (out)
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
