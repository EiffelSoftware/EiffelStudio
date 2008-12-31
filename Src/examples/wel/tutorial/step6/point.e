note
	legal: "See notice at end of class."
	status: "See notice at end of class."
class
	POINT

create
	make

feature -- Initialization

	make (a_x, a_y: INTEGER)
			-- Make a point with `a_x' and `a_y'.
		do
			x := a_x
			y := a_y
		ensure
			x_set: x = a_x
			y_set: y = a_y
		end

feature -- Access

	x: INTEGER
			-- x position

	y: INTEGER;
			-- y position

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class POINT

