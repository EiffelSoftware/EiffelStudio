indexing

	description: "Description of a triangle";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	TRIANGLE

inherit

	REG_POLYGON
		undefine
			make
		redefine
			set_number_of_sides,
			is_superimposable
		end

creation

	make

feature -- Initialization 

	make  is
			-- Create a triangle
		do
			init_fig (Void);
			!! center;
			!! path.make ;
			!! interior.make ;
			interior.set_no_op_mode;
			number_of_sides := 3;
			radius := 0;
		end;

feature -- Element change

	set_number_of_sides (new_number_of_sides: like number_of_sides) is
			-- Set `number_of_sides' to `new_number_of_sides'.
		require else
			can_change_on_triangle: false
		do
		end;

feature -- Status report

	is_superimposable (other: like Current): BOOLEAN is
			-- Is the current triangle superimposable to `other' ?
			--| not finished
		require else
			other_exists: other /= Void
		do
			Result := center.is_superimposable (other.center) and 
				(radius = other.radius) and (orientation = other.orientation)
		end;

invariant

	side_constraint: number_of_sides = 3

end -- class TRIANGLE 

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------

