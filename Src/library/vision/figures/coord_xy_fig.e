--|---------------------------------------------------------------
--| Copyright (C) Interactive Software Engineering, Inc.        --
--|  270 Storke Road, Suite 7 Goleta, California 93117          --
--|                      (805) 685-1006                         --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- COORD_XY_FIG: Description of geometric abstract coordinates.

indexing

    	date: "$Date$";
    	revision: "$Revision$"

class COORD_XY_FIG

inherit

    	GEOMETRIC_OP;

    	ANGLE_ROUT;

    	PART_COMPARABLE
		redefine
            		infix ">"
		end;

    	BASIC_ROUTINES;

	SINGLE_MATH;

	COORD_XY

feature

	add (v: VECTOR) is
            		-- add `v' to the two_coord.
        	require
            		vector_exists: not (v = Void)
        	do
            		x := x + v.x;
            		y := y + v.y
        	ensure
            		x = old x + v.x;
            		y = old y + v.y
        	end;

    	distance (other: like Current): INTEGER is
            		-- Distance between current point and `other'
        	local
            		xr, yr: INTEGER
        	do
            		xr := other.x - x;
            		yr := other.y - y;
            		Result := real_to_integer (sqrt(integer_to_real (xr * xr + yr	* yr)));
        	end;

    	duplicate: like Current is
            		-- Create a copy of current point.
        	do
            		!! Result;
            		Result.set (x, y)
        	ensure
        	    	Result.is_surimposable (Current)
        	end;

    	infix ">" (p: like Current): BOOLEAN is
            		-- Make a comparison between coordinates of point.
        	do
            		Result := (x >= p.x and then y >= p.y) and then (x /= p.x or else y/= p.y)
        	end;

    	infix "<" (p: like Current): BOOLEAN is
            		-- Make a comparison between coordinates of point.
        	do
            		Result := (x <= p.x and then y <= p.y) and then (x /= p.x or else y/= p.y)
        	end;

    	infix "-" (other: like Current): VECTOR is
            		-- Current point translated by -`other'
        	require
            		other_exists: not (other = Void)
        	do
            		!! Result;
            		Result.set (x - other.x, y - other.y)
        	ensure
            		Result.x = x - other.x;
            		Result.y = y - other.y
        	end;

    	infix "+" (other: VECTOR): like Current is
            		-- Current point translated by `other'
        	require
            		other_exists: not (other = Void)
        	do
            		!! Result;
            		Result.set (x + other.x, y + other.y)
        	ensure
            		Result.x = x + other.x;
            		Result.y = y + other.y
        	end;

    	is_surimposable (other: like Current): BOOLEAN is
            		-- Is the point surimposable to `other' ?
        	do
            		Result := (x=other.x) and (y=other.y)
        	end;

    	origin: COORD_XY_FIG is
            		-- Origin of point
        	do
            		inspect
                		origin_user_type
            		when 0 then
            		when 1 then
                		Result := origin_user
            		when 2 then
                		Result := Current
            		end
        	end;

    	prefix "-": like Current is
            		-- Make a negative copy of current point
        	do
            		!! Result;
            		Result.set (-x, -y)
        	ensure
            		Result.x = -x;
            		Result.y = -y
        	end;

    	prefix "+": like Current is
            		-- Make a positive copy of current point
        	do
            		!! Result;
            		Result.set (x, y)
        	ensure
            		Result.is_surimposable (Current)
        	end;

    	set_max (other: like Current) is
            		-- Set both coordinates to the maximum between current and `other'.
        	require
            		other_exists: not (other = Void)
        	do
            		x := max (x, other.x);
            		y := max (y, other.y)
        	ensure
            		x =  max (old x, other.x);
            		y =  max (old y, other.y)
        	end;

    	set_min (other: like Current) is
            		-- Set both coordinates to the minimum between current and `other'.
        	require
            		other_exists: not (other = Void)
        	do
            		x := min (x, other.x);
            		y := min (y, other.y)
        	ensure
            		x =  min (old x, other.x);
            		y =  min (old y, other.y)
        	end;

    	set_origin_to_himself is
            		-- Set origin of point to himself.
        	do
            		origin_user_type := 2
        	end;

    	set_x (x1: INTEGER) is
            		-- Set horizontal coordinate.
        	do
            		x := x1
        	ensure
            		x = x1
        	end;

    	set_y (y1: INTEGER) is
            		-- Set vertical coordinate.
        	do
            		y := y1
        	ensure
            		y = y1
        	end;

    	subtract (other: VECTOR) is
            		-- Translate current point by -`other'.
        	require
            		other_exists: not (other = Void)
        	do
            		x := x - other.x;
            		y := y - other.y
        	ensure
            		x = old x - other.x;
            		y = old y - other.y
        	end;

    	xyrotate (a: REAL; px,py: INTEGER) is
            		-- Rotate by `a' relative to (`px', `py').
        	local
            		xr, yr: INTEGER;
            		cosinus, sinus: REAL
        	do
            		if a  /= 0.0 then
                		xr := x - px;
                		yr := y - py;
                		cosinus := cos (a);
                		sinus := sin (a);
                		x := px+real_to_integer (xr*cosinus)+real_to_integer (yr*sinus);
                		y := py+real_to_integer (yr*cosinus)-real_to_integer (xr*sinus)
		        end
        	end;

    	xyscale (f: REAL; px,py: INTEGER) is
            		-- Scale figure by `f' relative to (`px', `py').
        	require else
            		scale_factor_positive: f > 0.0
        	do
            		x := x - px;
            		y := y - py;
            		x := real_to_integer (f * x);
            		y := real_to_integer (f * y);
            		x := x + px;
            		y := y + py
        	end;

    	xytranslate (vx, vy: INTEGER) is
            		-- Translate by `vx' horizontally and `vy' vertically.
        	do
            		x := x + vx;
            		y := y + vy
        	ensure then
            		x = old x + vx;
            		y = old y + vy
        	end;

invariant

    	origin_user_type <= 2

end
