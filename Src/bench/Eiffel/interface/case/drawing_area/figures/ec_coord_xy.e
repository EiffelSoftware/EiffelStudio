indexing

	description: "Abstraction of coordinates which build figures.";
	date: "$Date$";
	revision: "$Revision $"

class EC_COORD_XY 

inherit

	SINGLE_MATH
	EV_COORDINATES
	PART_COMPARABLE
		redefine
			infix ">", infix "<=",  infix ">="
		end

feature -- Access

	duplicate: EC_COORD_XY is
			-- Same point
		do
			!!Result;
			Result.set (x, y)
		ensure
			Result /= void;
			Result.x = x;
			Result.y = y
		end; -- duplicate

feature -- Setting

	set_x (new_x: like x) is
			-- Set horizontal coordinate.
		do
			x := new_x
		ensure
			x = new_x
		end; -- set_x

	set_y (new_y: like y) is
			-- Set vertical coordinate.
		do
			y := new_y
		ensure
			y = new_y
		end -- set_y

feature -- Comparison

	infix ">" (p: like Current): BOOLEAN is
			-- Make a comparison between coordinates of point.
		do
			Result := (x >= p.x and then y >= p.y) and then
				(x /= p.x or else y /= p.y)
		end; -- ">"

	infix ">=" (p: like Current): BOOLEAN is
			-- Make a comparison between coordinates of point.
			--| (Redefined for efficency).
		do
			Result := (x >= p.x and then y >= p.y)
		end; -- ">="

	infix "<=" (p: like Current): BOOLEAN is
			-- Make a comparison between coordinates of point.
			--| (Redefined for efficency).
		do
			Result := (x <= p.x and then y <= p.y)
		end; -- ">="

	infix "<" (p: like Current): BOOLEAN is
			-- Make a comparison between coordinates of point.
		do
			Result := (x <= p.x and then y <= p.y) and then
				(x /= p.x or else y /= p.y)
		end; -- "<"

feature -- Basic operations

	infix "-" (other: like Current): like Current is
			-- Current point translated by -`other'
		require
			other_exists: not (other = Void)
		do
			!!Result;
			Result.set (x - other.x, y - other.y)
		ensure
			Result.x = x - other.x;
			Result.y = y - other.y
		end; -- "-"

	infix "+" (other: like current): like Current is
			-- Current point translated by `other'
		require
			other_exists: not (other = Void)
		do
			!!Result;
			Result.set (x + other.x, y + other.y)
		ensure
			Result.x = x + other.x;
			Result.y = y + other.y
		end; -- "+"

	infix "//" (factor : INTEGER) : like Current is
			-- Current point div by `factor'
		do
			!!Result;
			Result.set (x // factor, y // factor)
		ensure
			Result.x = x // factor;
			Result.y = y // factor 
		end; -- "//"

	prefix "-": like Current is
			-- Make a negative copy of current point
		do
			!!Result;
			Result.set (-x, -y)
		ensure
			Result.x = -x;
			Result.y = -y
		end; -- "-"

	prefix "+": like Current is
	-- Make a positive copy of current point
		do
			!!Result;
			Result.set (x, y)
		end; -- "+"

feature -- Setting

	set_max (other: like Current) is
			-- Set both coordinates to the maximum between current
			-- and `other'.
		require
			other_exists: other /= Void
		do
			x := x.max (other.x)
			y := y.max (other.y)
		ensure
			x =  (old x).max (other.x);
			y =  (old y).max (other.y)
		end; -- set_max

	set_min (other: like Current) is
			-- Set both coordinates to the minimum between current
			-- and `other'.
		require
			other_exists: other /= Void
		do
			x := x.min (other.x);
			y := y.min (other.y)
		ensure
			x = (old x).min (other.x);
			y = (old y).min (other.y)
		end 

feature -- Update

	xyrotate (a: REAL; px,py: INTEGER) is
			-- Rotate by `a' relative to (`px', `py').
		local
			xr, yr: INTEGER;
			cosinus, sinus: REAL
		do
			if a  /= 0.0 then
				xr := x - px;
				yr := y - py;
				cosinus := cosine (a);
				sinus := sine (a);
				x := px + (xr*cosinus).truncated_to_integer +
				(yr*sinus).truncated_to_integer;
				y := py + (yr*cosinus).truncated_to_integer -
				(xr*sinus).truncated_to_integer
			end
		end;

	xyscale (f: REAL; px,py: INTEGER) is
			-- Scale figure by `f' relative to (`px', `py').
		do
			x := x - px;
			y := y - py;
			x := (f * x).truncated_to_integer;
			y := (f * y).truncated_to_integer;
			x := x + px;
			y := y + py
		end; -- xy_scale

	xytranslate (vx, vy: INTEGER) is
			-- Translate by `vx' horizontally and `vy' vertically.
		do
			x := x + vx;
			y := y + vy
		end 

end -- class EC_COORD_XY
