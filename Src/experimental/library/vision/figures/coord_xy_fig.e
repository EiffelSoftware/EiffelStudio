note

	description: "Description of geometric abstract coordinates"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	COORD_XY_FIG

inherit

	GEOMETRIC_OP;

	ANGLE_ROUT
			export
				{NONE} all
			end;

	PART_COMPARABLE
		redefine
			infix ">"
		end;

	BASIC_ROUTINES
			export
				{NONE} all
			end;

		SINGLE_MATH
			export
				{NONE} all
			end;

		CONFIGURE_NOTIFY
			rename
				make as notify_make
			export
				{NONE} all
			redefine
				set_conf_modified
			end;

		COORD_XY

feature -- Access

	origin: COORD_XY_FIG
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

	distance (other: like Current): INTEGER
			-- Distance between current point and `other'
		local
			xr, yr: INTEGER
		do
			xr := other.x - x;
			yr := other.y - y;
			Result := (sqrt(xr * xr + yr	* yr)).truncated_to_integer;
		end;

feature -- Comparison

	infix ">" (p: like Current): BOOLEAN
			-- Make a comparison between coordinates of point.
		do
			Result := (x >= p.x and then y >= p.y) and then (x /= p.x or else y/= p.y)
		end;

   	infix "<" (p: like Current): BOOLEAN
			-- Make a comparison between coordinates of point.
		do
			Result := (x <= p.x and then y <= p.y) and then (x /= p.x or else y/= p.y)
		end;

feature -- Status report
	
	is_superimposable (other: like Current): BOOLEAN
			-- Is the point superimposable to `other' ?
		do
			Result := (x=other.x) and (y=other.y)
		end;
	
feature -- Basic operation

	infix "-" (other: like Current): VECTOR
			-- Current point translated by -`other'
		require
			other_exists: other /= Void
		do
			create Result;
			Result.set (x - other.x, y - other.y)
		ensure
			x_set: Result.x = x - other.x;
			y_set: Result.y = y - other.y
		end;

	infix "+" (other: VECTOR): like Current
			-- Current point translated by `other'
		require
			other_exists: other /= Void
		do
			create Result;
			Result.set (x + other.x, y + other.y)
		ensure
			x_set: Result.x = x + other.x;
			y_set: Result.y = y + other.y
		end;

	prefix "-": like Current
			-- Make a negative copy of current point
		do
			create Result;
			Result.set (-x, -y)
		ensure
			x_set: Result.x = -x;
			y_set: Result.y = -y
		end;

	prefix "+": like Current
			-- Make a positive copy of current point
		do
			create Result;
			Result.set (x, y)
		ensure
			superimposable_result: Result.is_superimposable (Current)
		end;

feature -- Duplication

	duplicate: like Current
			-- Create a copy of current point.
		do
			create Result;
			Result.set (x, y)
		ensure
			superimposable_result: Result.is_superimposable (Current)
		end;
	
feature -- Element change

	add (v: VECTOR)
			-- add `v' to the two_coord.
		require
			vector_exists: v /= Void
		do
			x := x + v.x;
			y := y + v.y;
			set_conf_modified
		ensure
			updated_x: x = old x + v.x;
			updated_y: y = old y + v.y
		end;
  	
	set_max (other: like Current)
			-- Set both coordinates to the maximum between current and `other'.
		require
			other_exists: other /= Void
		do
			x := x.max (other.x);
			y := y.max (other.y);
			set_conf_modified
		ensure
			max_x: x =  other.x.max (old x);
			max_y: y =  other.y.max (old y)
		end;

	set_min (other: like Current)
			-- Set both coordinates to the minimum between current and `other'.
		require
			other_exists: other /= Void
		do
			x := x.min (other.x);
			y := y.min (other.y);
			set_conf_modified
		ensure
			min_x: x =  other.x.min (old x);
			min_y: y =  other.y.min (old y)
		end;

	set_origin_to_himself
			-- Set origin of point to himself.
		do
			origin_user_type := 2
		end;

	set_x (x1: INTEGER)
			-- Set horizontal coordinate.
		do
			x := x1;
			set_conf_modified
		ensure
			x_set: x = x1
		end;

	set_y (y1: INTEGER)
			-- Set vertical coordinate.
		do
			y := y1;
			set_conf_modified
		ensure
			y_set: y = y1
		end;

	subtract (other: VECTOR)
			-- Translate current point by -`other'.
		require
			other_exists: other /= Void
		do
			x := x - other.x;
			y := y - other.y;
			set_conf_modified
		ensure
			updated_x: x = old x - other.x;
			updated_y: y = old y - other.y
		end;

	xyrotate (a: REAL; px,py: INTEGER)
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
				x := px+(xr*cosinus).truncated_to_integer+(yr*sinus).truncated_to_integer;
				y := py+(yr*cosinus).truncated_to_integer-(xr*sinus).truncated_to_integer;
				set_conf_modified
			end;
		end;

	xyscale (f: REAL; px,py: INTEGER)
			-- Scale figure by `f' relative to (`px', `py').
		require else
			scale_factor_positive: f > 0.0
		do
			x := x - px;
			y := y - py;
			x := (f * x).truncated_to_integer;
			y := (f * y).truncated_to_integer;
			x := x + px;
			y := y + py;
			set_conf_modified
		end;

	xytranslate (vx, vy: INTEGER)
			-- Translate by `vx' horizontally and `vy' vertically.
		do
			x := x + vx;
			y := y + vy;
			set_conf_modified
		ensure then
			x_translated: x = old x + vx;
			y_translated: y = old y + vy
		end;

feature {NONE} -- Element change

	set_conf_modified
		do
		end;

invariant

	origin_user_type_constraint: origin_user_type <= 2

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- COORD_XY_FIG

