indexing

	description: 
		"Arrow triangle head used to draw inheritance and reference links.";
	date: "$Date$";
	revision: "$Revision $"

class EC_TRIANGLE_HEAD

inherit

	ONCES 
		undefine
			is_equal,
			setup,
			copy,
			consistent
		end

	EC_TRIANGLE
		rename
			make as triangle_make
		redefine
			draw, erase, origin
		end;
	EC_ARROW_HEAD
		undefine
			consistent, copy, setup, is_equal,
			set_color
		end;
	SINGLE_MATH
		undefine
			consistent, copy, setup, is_equal
		end

creation

	make

feature -- Initialization

	make (an_origin: EC_COORD_XY; i : INTEGER) is
			-- Make a triangle head for arrow
		require
			has_origin: an_origin /= Void
		do
			type := i
			triangle_make;
			origin := an_origin
		ensure
			origin_correctly_set: origin = an_origin
		end -- make

feature -- Properties

	origin: EC_COORD_XY

feature -- Update

	build (first_point, last_point: EC_COORD_XY) is
			-- Build a triangle as arrow's head
		local
			dx, dy: INTEGER
			a,b: REAL
		do
			dx := origin.x - last_point.x
			dy := origin.y - last_point.y
			if dx = 0 then
				if 0 < dy then
					a := pi / 2
				else
					a := -pi / 2
				end
			else
				a := -arc_tangent (dy / dx)
				if 0 < dx then
					a := a + pi
				end;
			end;
			
			b := sine ( a-(pi/2)).abs

			i_th (1).set (origin.x, origin.y)
			i_th (2).set (origin.x, origin.y)
			i_th (2).xytranslate (Resources.link_arrow_size,
						-(((1+b)/2)*Resources.link_arrow_size).floor)
			i_th (3).set (origin.x, origin.y)
			i_th (3).xytranslate (Resources.link_arrow_size,
						(((1+b)/2)*Resources.link_arrow_size).floor)

			dx := origin.x - last_point.x
			dy := origin.y - last_point.y
			if dx = 0 then
				if 0 < dy then
					a := pi / 2
				else
					a := -pi / 2
				end
			else
				a := -arc_tangent (dy / dx)
				if 0 < dx then
					a := a + pi
				end;
			end
			i_th (2).xyrotate (a, origin.x, origin.y)
			i_th (3).xyrotate (a, origin.x, origin.y)
		end

feature -- Output

	draw is
			-- Draw a fill triangle as arrow's head
		do
			if drawing.is_drawable then
				interior.set_drawing_attributes (drawing);
				drawing.set_line_width (1);
				--if System.uml_layout then
				--	if type=1 then
				--		drawing.draw_polyline ( Current, TRUE )
				--	end
				--else
					drawing.fill_polygon (Current)
				--end
			end
		end; 

	erase is
			-- Erase by fill triangle drawn with `erase_color'.
		do
			if drawing.is_drawable then
				interior.set_drawing_attributes (drawing);
				drawing.set_foreground_color (Resources.drawing_bg_color);
				drawing.set_line_width (1);
				drawing.fill_polygon (Current);
			end
		end 

feature -- Access

	base (first_point, last_point: EC_COORD_XY): EC_COORD_XY is
			-- Intersection point between base of triangle and arrow's body
		require else
			has_first: first_point /= Void;
			has_last: last_point /= Void
		local
			x_arrow: INTEGER;
					-- x composant of arrow as vector
			y_arrow: INTEGER;
					-- y composant of arrow as vector
			length_arrow: REAL;
					-- length of arrow as vector
			factor_arrow: REAL
		do
			Result := last_point;
			x_arrow := last_point.x - first_point.x;
			y_arrow := last_point.y - first_point.y;
			length_arrow := sqrt (x_arrow * x_arrow + y_arrow * y_arrow);
			--if System.uml_layout and then type=2 then
			--	factor_arrow := 0
			--else
				factor_arrow := length_arrow / (Resources.link_arrow_size);
			--end
			if factor_arrow = 0 then
				Result.set_x (Result.x);
				Result.set_y (Result.y);
			else
				Result.set_x (Result.x - 
						(x_arrow / factor_arrow).truncated_to_integer);
				Result.set_y (Result.y - 
						(y_arrow / factor_arrow).truncated_to_integer)
			end
		end -- base

end -- class EC_TRIANGLE_HEAD
