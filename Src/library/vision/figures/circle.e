--|---------------------------------------------------------------
--| Copyright (C) Interactive Software Engineering, Inc.        --
--|  270 Storke Road, Suite 7 Goleta, California 93117          --
--|                      (805) 685-1006                         --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- CIRCLE: Description of circle.

class CIRCLE

inherit

    	CLOSED_FIG
        	redefine
			contains
		end;

    	ANGLE_ROUT

creation

	make

feature -- Creation

	make is
			-- Create a circle.
        	do
            		!! center;
            		radius := 0
        	end;

feature

    	center: COORD_XY_FIG;
            		-- Center of the circle.

    	contains (p: COORD_XY_FIG): BOOLEAN is
            		-- Is 'p' in the current circle ?
        	local
            		distance: INTEGER
        	do
            		distance := center.distance (p);
            		Result := distance <= radius
        	end;

    	draw is
            		-- Draw the circle.
        	do
            		if drawing.is_drawable then
                		if not (interior = Void) then
                    			interior.set_drawing_attributes (drawing);
                    			drawing.fill_arc (center, radius, radius, 0, 360, 0, 0)
               			end;
                		if not (path = Void) then
                    			path.set_drawing_attributes (drawing);
                    			drawing.draw_arc (center, radius, radius, 0, 360, 0,
								-1)
                		end
            		end
        	end;

    	is_surimposable (other: like Current): BOOLEAN is
            		-- Is the current circle surimposable to `other' ?
            		--| not finished
        	require else
            		other_exists: not (other = Void)
        	do
            		Result := center.is_surimposable (other.center) and (radius = other.radius)
        	end;

    	origin: COORD_XY_FIG is
            		-- Origin of circle
        	do
            		inspect
                		origin_user_type
            		when 1 then
                		Result := origin_user
            		when 2 then
                		Result := center
            		end
        	end;

    	radius: INTEGER;
            		-- Radius of the circle who contains all the point of the
			-- polygon

    	set_center (a_point: like center) is
            		-- Set `center' to `a_point'.
        	require
            		a_point_exits: not (a_point = Void)
        	do
            		center := a_point
        	ensure
            		center = a_point
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
            		size_positive: new_radius > 0
        	do
            		radius := new_radius
        	ensure
            		radius = new_radius
        	end;

    	xyrotate (a: REAL; px, py: INTEGER) is
            		-- Rotate figure by `a' relative to (`px', `py').
            		-- Angle `a' is measured in degrees.
        	do
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
        	end;

invariant

    	origin_user_type <= 2;
    	radius >= 0;
    	not (center = Void)

end
