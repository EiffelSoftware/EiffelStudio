indexing
	description: "EiffelVision equilateral triangle."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_EQUILATERAL_TRIANGLE

inherit

	EV_REGULAR_POLYGON
		export
			{NONE} number_of_sides,
			set_number_of_sides
		redefine
			is_superimposable
		end

creation
	make

feature -- Status report

	is_superimposable (other: like Current): BOOLEAN is
			-- Is the current triangle superimposable to `other' ?
			--| not finished
		require else
			other_exists: other /= Void
		do
			Result := center.is_superimposable (other.center) and 
				(radius = other.radius) and (orientation = other.orientation)
		end

invariant
	side_constraint: number_of_sides = 3

end -- class EV_EQUILATERAL_TRIANGLE

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

