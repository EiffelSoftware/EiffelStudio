indexing

	description: "Description of a square";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	SQUARE 

inherit

	REG_POLYGON
		undefine
			make
		redefine
			draw, set_number_of_sides,
			is_superimposable, contains
		end

creation

	make

feature -- Initialization

	make  is
			-- Create a square.
		do
			init_fig (Void);
			!! center;
			!! path.make ;
			!! interior.make ;
			interior.set_no_op_mode;
			number_of_sides := 4;
			radius := 0;
		end;

feature -- Access 

	contains (p: COORD_XY_FIG): BOOLEAN is 
			-- Is 'p' in the current square? 
		require else
			orientation_is_zero: orientation = 0.0
		local 
			x0, y0, x1, y1, pointX, pointY: INTEGER;
			converted: INTEGER
		do 
			pointX := p.x; pointY := p.y; 
			converted := (size_of_side/2).truncated_to_integer;
			x0 := center.x - converted; 
			y0 := center.y - converted; 
			x1 := x0 + size_of_side; 
			y1 := y0 + size_of_side; 
			Result :=  
				(p.x >= x0 and p.x <= x1 
				and p.y >= y0 and p.y <= y1);
		end;

feature -- Element change

	set_number_of_sides (new_number_of_sides: like number_of_sides) is
			-- Set `number_of_sides' to `new_number_of_sides'.
		require else
			can_change_on_square: false
		do
		end;


feature -- Output

	draw is
			-- Draw the square.
		do
			if drawing.is_drawable then
				if interior /= Void then
					interior.set_drawing_attributes (drawing);
					drawing.fill_rectangle (center, size_of_side, size_of_side, orientation)
				end;
				if path /= Void then
					path.set_drawing_attributes (drawing);
					drawing.draw_rectangle (center, size_of_side, size_of_side, orientation)
				end
			end
		end;

feature -- Status report

	is_superimposable (other: like Current): BOOLEAN is
			-- Is the current square superimposable to `other' ?
			--| not finished
		require else
			other_exists: other /= Void
		do
			Result := center.is_superimposable (other.center) and
				(radius = other.radius) and (orientation = other.orientation)
		end;

invariant

	side_constraint: number_of_sides = 4

end -- class SQUARE


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

