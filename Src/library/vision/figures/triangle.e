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

