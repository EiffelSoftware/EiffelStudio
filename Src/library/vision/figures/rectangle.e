--|---------------------------------------------------------------
--| Copyright (C) Interactive Software Engineering, Inc.        --
--|  270 Storke Road, Suite 7 Goleta, California 93117          --
--|                      (805) 685-1006                         --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- RECTANGLE: Description of a rectangle.

class RECTANGLE 

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

	center: COORD_XY_FIG is
			-- Center of the rectangle.
		local
			v_cos, v_sin: REAL;
			half_width, half_height: INTEGER
		do
			v_cos := cos (orientation);
			v_sin := sin (orientation);
			half_width := width // 2;
			half_height := height // 2;
			!! Result;
			Result.set (upper_left.x+real_to_integer (half_width*v_cos+half_height*v_sin), upper_left.y-real_to_integer (half_width*v_sin-half_height*v_cos))
		end;

	make is
			-- Create a rectangle.
		do
			!! upper_left;
			width := 1;
			height := 1
		end; 

	draw is
			-- Draw the rectangle.
		do
			if drawing.is_drawable then
				drawing.set_join_style (join_style);
				if not (interior = Void) then
					interior.set_drawing_attributes (drawing);
					drawing.fill_rectangle (center, width, height, orientation)
				end;
				if not (path = Void) then
					path.set_drawing_attributes (drawing);
					drawing.draw_rectangle (center, width, height, orientation)
				end
			end
		end;

	height: INTEGER;
			-- Height of rectangle

	is_surimposable (other: like Current): BOOLEAN is
			-- Is the current rectangle surimposable to `other' ?
		require else
			other_exists: not (other = Void)
		do
			Result := upper_left.is_surimposable (other.upper_left) and (width = other.width) and (height = other.height)
		end; 

feature {NONE}

	orientation: REAL;
			-- Orientation in degree of the rectangle

feature 

	origin: COORD_XY_FIG is
			-- Origin of rectangle
		do
			inspect
				origin_user_type
			when 0 then
			when 1 then
				Result := origin_user
			when 2 then
				Result := upper_left
			when 3 then
				Result := center
			end
		end;

	set_height (new_height: like height) is
			-- Set `height' to `new_height'.
		require
			new_height_positive: new_height >= 0
		do
			height := new_height
		ensure
			height = new_height
		end;

feature {NONE}

	set_orientation (new_orientation: like orientation) is
			-- Set `orientation' to `new_orientation'.
		require
			orientation_positive: orientation >= 0;
			orientation_smaller_than_360: orientation < 360
		do
			orientation := new_orientation
		ensure
			orientation = new_orientation
		end;

feature 

	set_origin_to_center is
			-- Set origin to `center'.
		do
			origin_user_type := 3
		ensure then
			origin.is_surimposable (center)
		end;

	set_origin_to_upper_left is
			-- Set origin to upper left coiner.
		do
			origin_user_type := 2
		ensure
			origin.is_surimposable (upper_left)
		end;

	set_upper_left (a_point: like upper_left) is
			-- Set `upper_left' to `a_point'.
		require
			a_point_exists: not (a_point = Void)
		do
			upper_left := a_point
		ensure
			upper_left = a_point
		end;

	set_width (new_width: like width) is
			-- Set `width' to `new_width'
		require
			new_width_positive: new_width >= 0
		do
			width := new_width
		ensure
			width = new_width
		end;

	upper_left: COORD_XY_FIG;
			-- Upper left coin of the rectangle

	width: INTEGER;
			-- Width of rectangle

	xyrotate (a: REAL; px, py: INTEGER) is
			-- Rotate figure by `a' relative to (`px', `py').
			-- Angle `a' is measured in degrees.
		require else
			a_smaller_than_360: a < 360;
			a_positive: a >= 0.0
		do
			orientation := orientation+a;
			if orientation >= 360 then
				orientation := orientation-360
			end;
			if orientation < 0 then
				orientation := orientation+360
			end;
			upper_left.xyrotate (a, px, py)
		end;

	xyscale (f: REAL; px,py: INTEGER) is
			-- Scale figure by `f' relative to (`px', `py').
		require else
			scale_factor_positive: f > 0.0
		do
			width := real_to_integer (f*width);
			height := real_to_integer (f*height);
			upper_left.xyscale (f, px, py)
		end;

	xytranslate (vx, vy: INTEGER) is
			-- Translate by `vx' horizontally and `vy' vertically.
		do
			upper_left.xytranslate (vx, vy)
		end 

invariant

	origin_user_type <= 3;
	orientation < 360;
	orientation >= 0;
	width >= 0;
	height >= 0;
	not (upper_left = Void)

end 
