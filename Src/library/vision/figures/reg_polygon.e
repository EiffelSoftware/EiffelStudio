--|---------------------------------------------------------------
--| Copyright (C) Interactive Software Engineering, Inc.        --
--|  270 Storke Road, Suite 7 Goleta, California 93117          --
--|                      (805) 685-1006                         --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- REG_POLYGON: Description of a regular polygon (square, pentagon,...).

class REG_POLYGON 

inherit

	CLOSED_FIG;

	JOINABLE;

	ANGLE_ROUT
		export
			{NONE} all
		end

creation

	make

feature 

	center: COORD_XY_FIG;
			-- Center of the reg_polygon.

	make is
			-- Create a reg_polygon.
		do
			!! center;
			number_of_sides := 3;
			radius := 0
		end;

	draw is
			-- Draw the reg_polygon.
		local
			polygon: POLYGON;
			a_point: COORD_XY_FIG;
			i: INTEGER
		do
			if drawing.is_drawable then
				!! polygon.make;
				from
					i := 0
				until
					i > number_of_sides
				loop
					!! a_point;
					a_point.set (real_to_integer (center.x+radius*cos ((i+0.5)*(360.0/number_of_sides)+orientation)), real_to_integer (center.y-radius*sin ((i+0.5)*(360.0/number_of_sides)+orientation)));
					polygon.add_left (a_point);
					i := i+1
				end;
				drawing.set_join_style (join_style);
				if not (interior = Void) then
					interior.set_drawing_attributes (drawing);
					drawing.fill_polygon (polygon)
				end;
				if not (path = Void) then
					path.set_drawing_attributes (drawing);
					drawing.draw_polyline (polygon, true)
				end
			end
		end;

	is_surimposable (other: like Current): BOOLEAN is
			-- Is the current reg_polygon surimposable to `other' ?
			--| not finished
		require else
			other_exists: not (other = Void)
		do
			Result := center.is_surimposable (other.center) and (number_of_sides = other.number_of_sides) and (radius = other.radius) and (orientation = other.orientation)
		end;

	number_of_sides: INTEGER;
			-- Number of sides

	orientation: REAL;
			-- Orientation in degree of the reg_polygon

	origin: COORD_XY_FIG is
			-- Origin of reg_polygon
		do
			inspect
				origin_user_type
			when 0 then
			when 1 then
				Result := origin_user
			when 2 then
				Result := center
			end
		end;

	radius: INTEGER;
			-- Radius of the circle who contains all the point of the polygon

	set_center (a_point: like center) is
			-- Set `center' to `a_point'.
		require
			a_point_exits: not (a_point = Void)
		do
			center := a_point
		ensure
			center = a_point
		end;

	set_number_of_sides (new_number_of_sides: like number_of_sides) is
			-- Set `number_of_sides' to `new_number_of_sides'.
		require
			at_least_three_sides: new_number_of_sides >= 3
		do
			number_of_sides := new_number_of_sides
		ensure
			number_of_sides = new_number_of_sides
		end;

	set_orientation (new_orientation: like orientation) is
			-- Set `orientation' to `new_orientation'.
		require
			orientation_positive: new_orientation >= 0;
			orientation_smaller_than_360: new_orientation < 360
		do
			orientation := new_orientation
		ensure
			orientation = new_orientation
		end;

	set_origin_to_center is
			-- Set origin to `center'.
		do
			origin_user_type := 2
		ensure then
			origin.is_surimposable (center)
		end; 

	set_radius (new_radius: like radius) is
			-- Set `radius' to `new_radius', change `size_of_side'.
		require
			size_positive: new_radius >= 0
		do
			radius := new_radius
		ensure
			radius = new_radius
		end;

	set_size_of_side (a_size: INTEGER) is
			-- Set `size_of_side' to `a_size', change `radius'.
		require
			a_size_positive: a_size >= 0
		do
			radius := real_to_integer (a_size*cos (180.0/number_of_sides)/2)
		ensure
			size_of_side = a_size
		end;

	size_of_side: INTEGER is
			-- Size of a side
		do
			Result := real_to_integer (2*radius*cos (180.0/number_of_sides))
		end;

	xyrotate (a: REAL; px, py: INTEGER) is
			-- Rotate figure by `a' relative to (`px', `py').
			-- Angle `a' is measured in degrees.
		do
			orientation := mod360 (orientation+a);
			center.xyrotate (a, px, py)
		end;

	xyscale (f: REAL; px,py: INTEGER) is
			-- Scale figure by `f' relative to (`px', `py').
		require else
			scale_factor_positive: f > 0.0
		do
			radius := real_to_integer (f*radius);
			center.xyscale (f, px, py)
		end;

	xytranslate (vx, vy: INTEGER) is
			-- Translate by `vx' horizontally and `vy' vertically.
		do
			center.xytranslate (vx, vy)
		end 

invariant

	origin_user_type <= 2;
	radius >= 0;
	size_of_side >= 0;
	number_of_sides >= 3;
	orientation < 360;
	orientation >= 0;
	not (center = Void)

end
