--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                      (805) 685-1006                                --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- GEOMETRIC_OP: Figures implementation for X.

indexing

	date: "$Date$";
	revision: "$Revision$"

deferred class GEOMETRIC_OP 

inherit

	BASIC_ROUTINES
		export
			{NONE} all
		end

feature 

	contains (p: COORD_XY_FIG):BOOLEAN is
			-- Is `p' in Current ?
			-- (Unless redefined, by default it is false)
		do
			Result := false;
		end;

	is_surimposable (other: like Current): BOOLEAN is
			-- Is the figure surimposable to `other' ?
		deferred
		end;

	origin: COORD_XY_FIG is
			-- Origin of figure (used by `self_rotate' and `self_scale')
		deferred
		end;

feature {NONE}

	origin_user: like origin;
			-- User definition of `origin' when `origin_user_type' is 1

	origin_user_type: INTEGER;
			-- Type of origin typed by the user

feature 

	rotate (a: REAL; p: like origin) is
			-- Rotate figure by `a' relative to `p'.
			-- Angle `a' is measured in degrees.
		require
			point_exists: not (p = Void)
		do
			xyrotate (a, p.x, p.y)
		end;

	scale (f: REAL; p: like origin) is
			-- Scale figure by `f' relative to `p'.
		require
			scale_factor_positive: f > 0.0;
			point_exists: not (p = Void)
		do
			xyscale (f, p.x, p.y)
		end;

	self_rotate (a: REAL) is
			-- Rotate figure by `a' relative to `origin'.
			-- Angle is measured in degrees.
		require
			origin_exists: not (origin = Void)
		do
			xyrotate (a, origin.x, origin.y)
		end;

	self_scale (f: REAL) is
			-- Scale figure by `f' relative to `origin'.
		require
			origin_exists: not (origin = Void);
			scale_factor_positive: f > 0.0
		do
			xyscale (f, origin.x, origin.y)
		end;

	set_no_origin is
			-- Erase other definition of `origin'.
		do
			origin_user_type := 0
		end;

	set_origin (an_origin: like origin) is
			-- Set `origin' to `an_origin'.
		require
			an_origin_exists: not (an_origin = Void)
		do
			origin_user_type := 1;
			origin_user := an_origin
		end;

	translate (v: VECTOR) is
			-- Translate current figure by `v'.
		require
			vector_exists: not (v = Void)
		do
			xytranslate (v.x, v.y)
		end;

	xyrotate (a: REAL; px, py: INTEGER) is
			-- Rotate figure by `a' relative to (`px', `py').
			-- Angle `a' is measured in degrees.
		require
			a_smaller_than_360: a < 360;
			a_positive: a >= 0.0
		deferred
		end;

	xyscale (f: REAL; px,py: INTEGER) is
			-- Scale figure by `f' relative to (`px', `py').
		require
			scale_factor_positive: f > 0.0
		deferred
		end;

	xytranslate (vx, vy: INTEGER) is
			-- Translate by `vx' horizontally and `vy' vertically.
		deferred
		end;

invariant

	origin_user_type >= 0;
	(origin_user_type = 1) implies (not (origin_user = Void))

end
