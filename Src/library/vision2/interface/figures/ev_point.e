indexing
	description: "EiffelVision point. Description of geometric%
				% abstract coordinates"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_POINT

inherit

	EV_COORDINATES

	EV_GEOMETRICAL
		export
			{NONE} all
			{ANY} translate, rotate
		redefine
			set_modified
		end

	EV_ANGLE_ROUTINES
		export
			{NONE} all
		end

	PART_COMPARABLE
		redefine
			infix ">"
		end

creation
	make,
	set

feature -- Access

	origin: EV_POINT is
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
		end

	distance (other: like Current): INTEGER is
			-- Distance between current point and `other'
		local
			xr, yr: INTEGER
		do
			xr := other.x - x
			yr := other.y - y
			Result := (sqrt(xr * xr + yr * yr)).truncated_to_integer
		end

feature -- Comparison

	infix ">" (p: like Current): BOOLEAN is
			-- Make a comparison between coordinates of point.
		do
			Result := (x >= p.x and then y >= p.y) and then (x /= p.x or else y/= p.y)
		end

	infix "<" (p: like Current): BOOLEAN is
			-- Make a comparison between coordinates of point.
		do
			Result := (x <= p.x and then y <= p.y) and then (x /= p.x or else y/= p.y)
		end

feature -- Status report
	
	is_superimposable (other: like Current): BOOLEAN is
			-- Is the point superimposable to `other' ?
		do
			Result := (x=other.x) and (y=other.y)
		end
	
feature -- Basic operation

	infix "-" (other: like Current): EV_VECTOR is
			-- Current point translated by -`other'
		require
			other_exists: other /= Void
		do
			!! Result.set (x - other.x, y - other.y)
		ensure
			x_set: Result.x = x - other.x
			y_set: Result.y = y - other.y
		end

	infix "+" (other: EV_VECTOR): like Current is
			-- Current point translated by `other'
		require
			other_exists: other /= Void
		do
			!! Result.set (x + other.x, y + other.y)
		ensure
			x_set: Result.x = x + other.x
			y_set: Result.y = y + other.y
		end

	infix "*" (other: INTEGER): like Current is
			-- Current point multiplied by `other'.
		do
			!! Result.set (x * other, y * other)
		end

	infix "//" (other: INTEGER): like Current is
			-- Current point devided by `other'.
		do
			!! Result.set (x // other, y // other)
		end

	prefix "-": like Current is
			-- Make a negative copy of current point
		do
			!! Result.set (-x, -y)
		ensure
			x_set: Result.x = -x
			y_set: Result.y = -y
		end

	prefix "+": like Current is
			-- Make a positive copy of current point
		do
			!! Result.set (x, y)
		ensure
			superimposable_result: Result.is_superimposable (Current)
		end

feature -- Duplication

	duplicate: like Current is
			-- Create a copy of current point.
		do
			!! Result.set (x, y)
		ensure
			superimposable_result: Result.is_superimposable (Current)
		end
	
feature -- Element change

	add (v: EV_VECTOR) is
			-- add `v' to the two_coord.
		require
			vector_exists: v /= Void
		do
			x := x + v.x
			y := y + v.y
			set_modified
		ensure
			updated_x: x = old x + v.x
			updated_y: y = old y + v.y
		end

	set_max (other: like Current) is
			-- Set both coordinates to the maximum between current and `other'.
		require
			other_exists: other /= Void
		do
			x := x.max (other.x)
			y := y.max (other.y)
			set_modified
		ensure
			max_x: x =  other.x.max (old x)
			max_y: y =  other.y.max (old y)
		end

	set_min (other: like Current) is
			-- Set both coordinates to the minimum between current and `other'.
		require
			other_exists: other /= Void
		do
			x := x.min (other.x)
			y := y.min (other.y)
			set_modified
		ensure
			min_x: x =  other.x.min (old x)
			min_y: y =  other.y.min (old y)
		end

	set_origin_to_himself is
			-- Set origin of point to himself.
		do
			origin_user_type := 2
		end

	set_x (x1: INTEGER) is
			-- Set horizontal coordinate.
		do
			x := x1
			set_modified
		ensure
			x_set: x = x1
		end

	set_y (y1: INTEGER) is
			-- Set vertical coordinate.
		do
			y := y1
			set_modified
		ensure
			y_set: y = y1
		end

	subtract (other: EV_VECTOR) is
			-- Translate current point by -`other'.
		require
			other_exists: other /= Void
		do
			x := x - other.x
			y := y - other.y
			set_modified
		ensure
			updated_x: x = old x - other.x
			updated_y: y = old y - other.y
		end

	xyrotate (a: REAL; px,py: INTEGER) is
			-- Rotate by `a' relative to (`px', `py').
		local
			xr, yr: INTEGER
			cosinus, sinus: REAL
		do
			if a  /= 0.0 then
				xr := x - px
				yr := y - py
				cosinus := cos (a)
				sinus := sin (a)
				x := px + ((xr * cosinus) + (yr * sinus)).truncated_to_integer
				y := py + ((yr * cosinus) - (xr * sinus)).truncated_to_integer
				set_modified
			end
		end

	xyscale (f: REAL; px,py: INTEGER) is
			-- Scale figure by `f' relative to (`px', `py').
		require else
			scale_factor_positive: f > 0.0
		do
			x := x - px
			y := y - py
			x := (f * x).truncated_to_integer
			y := (f * y).truncated_to_integer
			x := x + px
			y := y + py
			set_modified
		end

	xytranslate (vx, vy: INTEGER) is
			-- Translate by `vx' horizontally and `vy' vertically.
		do
			x := x + vx
			y := y + vy
			set_modified
		ensure then
			x_translated: x = old x + vx
			y_translated: y = old y + vy
		end

feature {NONE} -- Element change

	set_modified is
		do
		end

invariant
	origin_user_type_constraint: origin_user_type <= 2

end -- class EV_POINT

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

