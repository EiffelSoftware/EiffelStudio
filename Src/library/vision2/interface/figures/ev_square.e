indexing
	description: "EiffelVision square."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_SQUARE

inherit
	EV_REGULAR_POLYGON
		export
			{NONE} number_of_sides,
			set_number_of_sides
		redefine
			make, draw,
			is_superimposable, contains
		end

creation
	make

feature -- Initialization

	make is
			-- Create a square.
		do
			Precursor
			number_of_sides := 4
		end

feature -- Access 

	contains (p: EV_POINT): BOOLEAN is 
			-- Is 'p' in the current square? 
		require else
			orientation_is_zero: orientation = 0.0
		local 
			x0, y0, x1, y1: INTEGER
			converted: INTEGER
		do 
			converted := size_of_side //  2
			x0 := center.x - converted
			y0 := center.y - converted
			x1 := x0 + size_of_side
			y1 := y0 + size_of_side
			Result := p.x >= x0 and p.x <= x1 and p.y >= y0 and p.y <= y1
		end

feature -- Output

	draw is
			-- Draw the square.
		do
			if drawing.is_drawable then
				if interior /= Void then
					interior.set_drawing_attributes (drawing)
					drawing.fill_rectangle (center, size_of_side, size_of_side, orientation)
				end
				if path /= Void then
					path.set_drawing_attributes (drawing)
					drawing.draw_rectangle (center, size_of_side, size_of_side, orientation)
				end
			end
		end

feature -- Status report

	is_superimposable (other: like Current): BOOLEAN is
			-- Is the current square superimposable to `other' ?
			--| not finished
		require else
			other_exists: other /= Void
		do
			Result := center.is_superimposable (other.center) and
				(radius = other.radius) and (orientation = other.orientation)
		end

invariant
	side_constraint: number_of_sides = 4

end -- class EV_SQUARE

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

