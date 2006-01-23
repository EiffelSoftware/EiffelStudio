indexing

	description: 
		"Two dimensional point."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_POINT

create
	make

feature {NONE} -- Initialization

	make (an_x, a_y: INTEGER) is
			-- Create a two dimensions point.
		do
			x := an_x;
			y := a_y
		ensure
			x_set: x = an_x;
			y_set: y = a_y
		end;

feature -- Access

	x: INTEGER;

	y: INTEGER

feature -- Element change

	set_x (a_x: INTEGER) is
			-- Change the x coordinate of the point.
		do
			x := a_x
		ensure
			x_set: x = a_x
		end;

	set_y (a_y: INTEGER) is
			-- Change the y coordinate of the point.
		do
			y := a_y
		ensure
			y_set: y = a_y
		end;

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




end -- class MEL_POINT


