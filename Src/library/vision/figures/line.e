--|---------------------------------------------------------------
--| Copyright (C) Interactive Software Engineering, Inc.        --
--|  270 Storke Road, Suite 7 Goleta, California 93117          --
--|                      (805) 685-1006                         --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- LINE: Description of general lines (implementation for X).

deferred class LINE 

inherit

	OPEN_FIG;

	PATH;

	BASIC_ROUTINES
		export
			{NONE} all
		end



	
feature 

	is_horizontal: BOOLEAN is
			-- Is the line horizontal ?
		do
			Result := (p1.y = p2.y)
		end; 

	is_null: BOOLEAN is
			-- Is the line null ?
		deferred
		end; 

	is_vertical: BOOLEAN is
			-- Is the line vertical ?
		do
			Result := (p1.x = p2.x)
		end;

	origin: COORD_XY_FIG is
			-- Origin of line
		do
			inspect
				origin_user_type
			when 0 then
			when 1 then
				Result := origin_user
			when 2 then
				Result := p1
			when 3 then
				Result := p2
			when 4 then
				!!Result;
				Result.set ((p1.x+p2.x) // 2, (p1.y+p2.y) // 2)
			end
		end;

	p2: like p1;
			-- Second point

	p1: COORD_XY_FIG;
			-- First point

	set (o1, o2: like p1) is
			-- Set the two end points of the line.
		require
			o1_exists: not (o1 = Void);
			o2_exists: not (o2 = Void)
		deferred
		ensure
			p1 = o1;
			p2 = o2
		end;

	set_origin_to_first_point is
			-- Set origin to first point of line.
		do
			origin_user_type := 2
		ensure
			origin.is_surimposable (p1)
		end;

	set_origin_to_middle is
			-- Set origin to middle of the segment [`p1', `p2'].
		do
			origin_user_type := 4
		end;

	set_origin_to_second_point is
			-- Set origin to second point of line.
		do
			origin_user_type := 3
		ensure
			origin.is_surimposable (p2)
		end;

	set_p1 (p: like p1) is
			-- Set the first point.
		require
			p_exists: not (p = Void)
		deferred
		ensure
			p1 = p
		end;

	set_p2 (p: like p2) is
			-- Set the second point.
		require
			p_exists: not (p = Void)
		deferred
		ensure
			p2 = p
		end;

	xyrotate (a: REAL; px, py: INTEGER) is
			-- Rotate figure by `a' relative to (`px', `py').
			-- Angle `a' is measured in degrees.
		require else
			a_smaller_than_360: a < 360;
			a_positive: a >= 0.0
		do
			p1.xyrotate (a, px, py);
			p2.xyrotate (a, px, py)
		end;

	xyscale (f: REAL; px,py: INTEGER) is
			-- Scale figure by `f' relative to (`px', `py').
		require else
			scale_factor_positive: f > 0.0
		do
			p1.xyscale (f, px, py);
			p2.xyscale (f, px, py)
		end;

	xytranslate (vx, vy: INTEGER) is
			-- Translate by `vx' horizontally and `vy' vertically.
		do
			p1.xytranslate (vx, vy);
			p2.xytranslate (vx, vy)
		end

invariant

	origin_user_type <= 4;
	is_null = (is_horizontal and is_vertical);
	not (p1 = Void);
	not (p2 = Void)

end
