indexing

	description: "Description of a triangle"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
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

create

	make

feature -- Initialization 

	make  is
			-- Create a triangle
		do
			init_fig (Void);
			create center;
			create path.make ;
			create interior.make ;
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class TRIANGLE 

