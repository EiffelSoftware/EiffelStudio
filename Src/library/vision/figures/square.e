--|---------------------------------------------------------------
--| Copyright (C) Interactive Software Engineering, Inc.        --
--|  270 Storke Road, Suite 7 Goleta, California 93117          --
--|                      (805) 685-1006                         --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- SQUARE: Description of a square.

class SQUARE 

inherit

	REG_POLYGON
		undefine
			make
		redefine
			draw, set_number_of_sides,
			is_surimposable, contains
		end

creation

	make

feature 

	make is
			-- Create a square.
		do
			!! center;
			number_of_sides := 4;
			radius := 0
		end; -- Create

	contains (p: COORD_XY_FIG): BOOLEAN is 
			-- Is 'p' in the current square? 
		require else
			orientation_is_zero: orientation = 0.0
		local 
			x0, y0, x1, y1, pointX, pointY: INTEGER;
			convert: BASIC_ROUTINES;
			converted: INTEGER
		do 
			pointX := p.x; pointY := p.y; 
			!! convert;
			converted := convert.real_to_integer (size_of_side/2);
			x0 := center.x - converted; 
			y0 := center.y - converted; 
			x1 := x0 + size_of_side; 
			y1 := y0 + size_of_side; 
			Result :=  
				(p.x >= x0 and p.x <= x1 
				and p.y >= y0 and p.y <= y1);
		end;

	draw is
			-- Draw the square.
		local
			polygon: POLYGON
		do
			if drawing.is_drawable then
				if not (interior = Void) then
					interior.set_drawing_attributes (drawing);
					drawing.fill_rectangle (center, size_of_side, size_of_side, orientation)
				end;
				if not (path = Void) then
					path.set_drawing_attributes (drawing);
					drawing.draw_rectangle (center, size_of_side, size_of_side, orientation)
				end
			end
		end;

	is_surimposable (other: like Current): BOOLEAN is
			-- Is the current square surimposable to `other' ?
			--| not finished
		require else
			other_exists: not (other = Void)
		do
			Result := center.is_surimposable (other.center) and (radius = other.radius) and (orientation = other.orientation)
		end;

	set_number_of_sides (new_number_of_sides: like number_of_sides) is
			-- Set `number_of_sides' to `new_number_of_sides'.
		require else
			can_change_on_square: false
		do
		end;

invariant

	number_of_sides = 4

end
