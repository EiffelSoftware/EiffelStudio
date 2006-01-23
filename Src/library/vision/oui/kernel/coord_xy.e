indexing

	description: "Definition of a structure (x, y)"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	COORD_XY 

feature -- Access

	x: INTEGER;
			-- Value of horizontal position.

	y: INTEGER;
			-- Value of vertical position.

feature -- Element change

	set (new_x, new_y: INTEGER) is
			-- Set position
		do
			x := new_x;
			y := new_y
		ensure
			x_set: x = new_x 
			y_set: y = new_y
		end

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




end -- class COORD_XY

