--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

indexing

    date: "$Date$";
    revision: "$Revision$"

class ARC

inherit

    	OPEN_FIG;

    	PATH
			rename
				make as path_make
			end;

    	ENDED;

    	ANGLE_ROUT

creation

	make

feature -- Creation

	make is
			-- Create current arc.
        	do
            		path_make;
            		!! center;
            		angle2 := 360
        	end;

feature

    	angle1: REAL;
            	-- Angle which specifies start position of
            	-- current arc relative to the orientation

    	angle2: REAL;
            	-- Angle which specifies end position of
            	-- current arc relative to the start of
            	-- current arc

    	center: COORD_XY_FIG;
            		-- Center of the arc

    	draw is
            		-- draw the arc.
        	do
            		if drawing.is_drawable then
                		drawing.set_cap_style (cap_style);
                		set_drawing_attributes (drawing);
                		drawing.draw_arc (center, radius1, radius2, angle1, angle2,
						orientation, -1)
            		end
        	end;

    	is_surimposable (other: like Current): BOOLEAN is
            		-- Is `other' surimposable to current arc ?
            		--| not done
        	do
        	end;

    	orientation: REAL;
            	-- Angle which specifies the position of the first ray
            	-- (length `radius1') relative to the three-o'clock position
            	-- from the center

    	origin: COORD_XY_FIG is
            		-- Origin of line
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
            	-- First radius of the arc

    	radius2: INTEGER;
            	-- Second radius of the arc

    	set_angle1 (an_angle: like angle1) is
            		-- Set angle1 to `an_angle'._
        	require
            		angle1_smaller_than_360: an_angle < 360;
            		angle1_positive: an_angle >= 0
        	do
            		angle1 := an_angle
        	ensure
            		angle1 = an_angle
        	end;

    	set_angle2 (an_angle: like angle2) is
            		-- Set angle2 to `an_angle'.
        	require
            		angle2_smaller_than_360: an_angle <= 360;
            		angle2_positive: an_angle >= 0
        	do
            		angle2 := an_angle
        	ensure
            		angle2 = an_angle
        	end;

    	set_center (a_center: like center) is
            		-- Set `center' to `an_center'.
        	require
            		a_center_exists: not (a_center = Void)
        	do
            		center := a_center
        	ensure
            		center = a_center
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
        	ensure
            		origin.is_surimposable (center)
        	end;

    	set_radius1 (a_radius: like radius1) is
            		-- Set `radius1' to `a_radius'.
        	require
            		a_radius_positive: a_radius >= 0
        	do
            		radius1 := a_radius
        	ensure
            		radius1 = a_radius
        	end;

    	set_radius2 (a_radius: like radius2) is
            		-- Set `radius2' to `a_radius'.
        	require
            		a_radius_positive: a_radius >= 0
        	do
            		radius2 := a_radius
        	ensure
            		radius2 = a_radius
        	end;

    	xyrotate (a: REAL; px, py: INTEGER) is
            		-- Rotate figure by `a' relative to (`px', `py').
            		-- Angle `a' is measured in degrees.
        	require else
            		a_smaller_than_360: a < 360;
            		a_positive: a >= 0
        	do
            		center.xyrotate (a, px, py);
            		orientation := mod360 (orientation+a)
        	end;

    	xyscale (f: REAL; px, py: INTEGER) is
            		-- Scale figure by `f' relative to (`px', `py').
        	require else
            		scale_factor_positive: f > 0.0
        	do
            		center.xyscale (f, px, py);
            		radius1 := real_to_integer (radius1*f);
            		radius2 := real_to_integer (radius2*f)
        	end;

    	xytranslate (vx, vy: INTEGER) is
            		-- Translate by `vx' horizontally and `vy' vertically.
        	do
            		center.xytranslate (vx, vy)
        	end;

invariant

    	not (center = Void);
    	origin_user_type <= 2;
    	radius1 >= 0;
    	radius2 >= 0;
    	orientation < 360;
    	orientation >= 0;
    	angle1 < 360;
    	angle1 >= 0;
    	angle2 <= 360;
    	angle2 >= 0

end
