indexing

	description: 
		"Geometrical triangle used to draw links.";
	date: "$Date$";
	revision: "$Revision $"

class EC_TRIANGLE

inherit

	CONSTANTS
		undefine
			copy, is_equal
		end;
	EC_OPEN_FIG
		undefine
			copy, is_equal
		end;
	EC_CLOSED_FIG
		undefine
			copy, is_equal
		end;
	BASIC_ROUTINES
		undefine
			copy, is_equal
		end;
	FIXED_LIST [EC_COORD_XY]
		rename
			make as list_make,
			make_filled as list_make_filled -- pascalf
		end

creation

	make

feature -- Initialization

	make is
			-- Make a triangle as link's characteristic
		local
			point: EC_COORD_XY;
			i: INTEGER
		do
			!!closure.make;
			list_make_filled (3);
			from
				i := 1
			until
				i > 3
			loop
				!!point;
				put_i_th (point, i);
				i := i+1
			end;
			!!path.make;
			!!interior.make;
		ensure
			has_path: path /= Void;
			has_interior: interior /= Void;
		end -- make

feature -- Properties

	origin: EC_COORD_XY is
			-- origin of segment.
		do
			Result := i_th (1)
		end -- origin

feature -- Setting

	set_color (a_color: EV_COLOR) is
		require
			valid_a_color: a_color /= Void
		do
			path.set_foreground_color (a_color)
			interior.set_foreground_color (a_color)
		end

feature -- Access

	contains (a_point : EC_COORD_XY) : BOOLEAN is
			-- Is 'a_point' in triangle?
		do
			Result := contains_xy (a_point.x, a_point.y)
		end; -- contains

	contains_xy (x, y : INTEGER) : BOOLEAN is
			--
		local
			x2, y2, x3, y3, den, a, b, c, d, xx, yy: REAL
		do
			x2 := i_th (2).x-i_th (1).x;
			y2 := i_th (2).y-i_th (1).y;
			x3 := i_th (3).x-i_th (1).x;
			y3 := i_th (3).y-i_th (1).y;
			den := x3*y2-x2*y3;
			a := y2/den;
			b := -x2/den;
			c := -y3/den;
			d := x3/den;
			xx := a*(x-i_th (1).x)+
			b*(y-i_th (1).y);
			yy := c*(x-i_th (1).x)+
			d*(y-i_th (1).y);
			Result := (xx >= 0) and
				(yy >= 0) and
				(xx+yy <= 1)
		end; -- contains_xy

feature -- Output

	draw is
			-- Draw current triangle in drawing area
		do
			if drawing.is_drawable then
				path.set_drawing_attributes (drawing);
				drawing.set_line_width (1);
				drawing.draw_polyline (Current, true)
			end
		end; 

	erase is
			-- Erase current triangle from drawing area.
		do
			if drawing.is_drawable then
				path.set_drawing_attributes (drawing);
				drawing.set_foreground_color (Resources.drawing_bg_color);
				drawing.set_line_width (1);
				drawing.draw_polyline (Current, true)
			end
		end; -- erase

feature -- Update

	recompute_closure is
			-- Recalculate triangle's closure
		local
			x_min, x_max, y_min, y_max : INTEGER
		do
			x_min := i_th (1).x.min (i_th (2).x);
			x_min := x_min.min (i_th (3).x);
			x_max := i_th (1).x.max (i_th (2).x);
			x_max := x_max.max (i_th (3).x);
			y_min := i_th (1).y.min (i_th (2).y);
			y_min := y_min.min (i_th (3).y);
			y_max := i_th (1).y.max (i_th (2).y);
			y_max := y_max.max (i_th (3).y);
			closure.set (x_min, y_min, x_max - x_min, y_max - y_min)
		end 


invariant

	has_three_points : count = 3


end -- class EC_TRIANGLE
