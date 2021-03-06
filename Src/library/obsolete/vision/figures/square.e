note

	description: "Description of a square"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
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

create

	make

feature -- Initialization

	make
			-- Create a square.
		do
			init_fig (Void);
			create center;
			create path.make ;
			create interior.make ;
			interior.set_no_op_mode;
			number_of_sides := 4;
			radius := 0;
		end;

feature -- Access 

	contains (p: COORD_XY_FIG): BOOLEAN 
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

	set_number_of_sides (new_number_of_sides: like number_of_sides)
			-- Set `number_of_sides' to `new_number_of_sides'.
		require else
			can_change_on_square: false
		do
		end;


feature -- Output

	draw
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

	is_superimposable (other: like Current): BOOLEAN
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




end -- class SQUARE

