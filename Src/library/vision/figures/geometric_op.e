indexing

	description: "Figures implementation for X";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	GEOMETRIC_OP 

inherit

	BASIC_ROUTINES
		export
			{NONE} all
		end 

feature -- Access

	origin: COORD_XY_FIG is
			-- Origin of figure (used by `self_rotate' and `self_scale')
		deferred
		end;

	contains (p: COORD_XY_FIG):BOOLEAN is
			-- Is `p' in Current ?
			-- (Unless redefined, by default it is false)
		do
			Result := false;
		end;

feature -- Element change

	rotate (a: REAL; p: like origin) is
			-- Rotate figure by `a' relative to `p'.
			-- Angle `a' is measured in degrees.
		require
			point_exists: p /= Void
			angle_large_enough: a >= 0
			angle_small_enough: a <= 360
		do
			xyrotate (a, p.x, p.y)
		end;

	scale (f: REAL; p: like origin) is
			-- Scale figure by `f' relative to `p'.
		require
			scale_factor_positive: f > 0.0;
			point_exists: p = Void
		do
			xyscale (f, p.x, p.y)
		end;

	self_rotate (a: REAL) is
			-- Rotate figure by `a' relative to `origin'.
			-- Angle is measured in degrees.
		require
			origin_exists: origin /= Void
			angle_large_enough: a >= 0
			angle_small_enough: a < 360
		do
			xyrotate (a, origin.x, origin.y)
		end;

	self_scale (f: REAL) is
			-- Scale figure by `f' relative to `origin'.
		require
			origin_exists: origin /= Void;
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
			an_origin_exists: an_origin /= Void
		do
			origin_user_type := 1;
			origin_user := an_origin
		end;

	translate (v: VECTOR) is
			-- Translate current figure by `v'.
		require
			vector_exists: v /= Void
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

feature -- Status report

	is_superimposable (other: like Current): BOOLEAN is
			-- Is the figure able to be superimposed on `other' ?
		deferred
		end

feature {NONE} -- Access

	origin_user: like origin;
			-- User definition of `origin' when `origin_user_type' is 1

	origin_user_type: INTEGER;
			-- Type of origin typed by the user

invariant

	origin_user_type_constraint: origin_user_type >= 0;
	user_origin_constraint: (origin_user_type = 1) implies origin_user /= Void

end -- GEOMETRIC_OP



--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

