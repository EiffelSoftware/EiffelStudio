--|---------------------------------------------------------------
--| Copyright (C) Interactive Software Engineering, Inc.        --
--|  270 Storke Road, Suite 7 Goleta, California 93117          --
--|                      (805) 685-1006                         --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- ELLIPSE: Description of ellipse.

class ELLIPSE

inherit

    	CLOSED_FIG;

    	ANGLE_ROUT

creation

	make

feature -- Creation

	make is
            		-- Create a ellipse.
        	do
            		!! center
        	end;

feature

    	center: COORD_XY_FIG;
            	-- Center of the ellipse.

    	draw is
            		-- Draw the ellipse.
        	do
            		if drawing.is_drawable then
                		if not (interior = Void) then
                    			interior.set_drawing_attributes (drawing);
                    			drawing.fill_arc (center, radius1, radius2, 0, 360,
								orientation, 0)
                		end;
                		if not (path = Void) then
                    			path.set_drawing_attributes (drawing);
                    			drawing.draw_arc (center, radius1, radius2, 0, 360,
								orientation, -1)
                		end
            		end
        	end;

    	is_surimposable (other: like Current): BOOLEAN is
            		-- Is the current ellipse surimposable to `other' ?
            		--| not finished
        	require else
            		other_exists: not (other = Void)
        	do
            		Result := center.is_surimposable (other.center) and (radius1 =
				other.radius1) and (radius2 = other.radius2) and
				(orientation = other.orientation)
        	end;

    	orientation: REAL;
            	-- Angle which specifies the position of the first ray
            	-- (length `radius1') relative to the three-o'clock position
            	-- from the center

    	origin: COORD_XY_FIG is
            		-- Origin of ellipse
        	do
            		inspect
                		origin_user_type
            		when 1 then
                		Result := origin_user
            		when 2 then
                		Result := center
            		end
        	end;

    	radius1: INTEGER;
            	-- First radius of the ellipse

    	radius2: INTEGER;
            	-- Second radius of the ellipse

    	set_center (a_point: like center) is
            		-- Set `center' to `a_point'.
        	require
            		a_point_exits: not (a_point = Void)
        	do
            		center := a_point
        	ensure
            		center = a_point
        	end;

    	set_orientation (an_orientation: like orientation) is
            		-- Set `orientation' to `an_orientation'.
        	require
            		orientation_smaller_than_360: an_orientation < 360;
            		orientation_positive: an_orientation >= 0
        	do
            		orientation := an_orientation
        	ensure
            		orientation = an_orientation
        	end;

    	set_origin_to_center is
            		-- Set origin to `center'.
        	do
            		origin_user_type := 2
        	ensure then
            		origin.is_surimposable (center)
        	end;

    	set_radius1 (new_radius1: like radius1) is
            		-- Set `radius1' to `new_radius1', change `size_of_side'.
        	require
            		size_positive: new_radius1 > 0
        	do
            		radius1 := new_radius1
        	ensure
            		radius1 = new_radius1
        	end;

    	set_radius2 (new_radius2: like radius2) is
            		-- Set `radius1' to `new_radius2', change `size_of_side'.
        	require
            		size_positive: new_radius2 > 0
        	do
            		radius2 := new_radius2
        	ensure
            		radius2 = new_radius2
        	end;

    	xyrotate (a: REAL; px, py: INTEGER) is
            		-- Rotate figure by `a' relative to (`px', `py').
            		-- Angle `a' is measured in degrees.
        	do
            		center.xyrotate (a, px, py);
            		orientation := mod360 (orientation+a)
        	end;

    	xyscale (f: REAL; px,py: INTEGER) is
            		-- Scale figure by `f' relative to (`px', `py').
        	require else
            		scale_factor_positive: f > 0.0
        	do
            		radius1 := real_to_integer (f*radius1);
            		radius2 := real_to_integer (f*radius2);
            		center.xyscale (f, px, py)
        	end;

    	xytranslate (vx, vy: INTEGER) is
            		-- Translate by `vx' horizontally and `vy' vertically.
        	do
            		center.xytranslate (vx, vy)
        	end;

invariant

    	origin_user_type <= 2;
    	radius1 >= 0;
    	radius2 >= 0;
    	orientation < 360;
    	orientation >= 0;
    	not (center = Void)

end
