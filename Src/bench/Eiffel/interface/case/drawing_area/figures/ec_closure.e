indexing

	description: 
		"Lowest rectangle containing a figure.";
	date: "$Date$";
	revision: "$Revision $"

class EC_CLOSURE 

creation

	make

feature -- Initialization

	make is
			-- Create a closure
		do
			empty := true
		end

feature -- Properties

	up_left_x: INTEGER
			-- Upper left corner x

	up_left_y: INTEGER
			-- Upper left corner y

	down_right_x: INTEGER
			-- Bottom right corner x

	down_right_y: INTEGER
			-- Bottom right corner y

	empty: BOOLEAN
			-- Is the closure empty ?

	up_left: EC_COORD_XY is
			-- Coordinates of Current , at the upper left corner.
		do
			!! Result
			Result.set (up_left_x, up_left_y)
		ensure
			Result_not_void: Result /= Void
		end

feature -- Setting

	set (x, y, width, height: INTEGER) is
			-- Set coordinates and size of closure.
		require
			width >= 0
			height >= 0
		do
			if width+height > 0 then
				up_left_x := x
				up_left_y := y
				down_right_x := x+width
				down_right_y := y+height
				empty := false
			else
				empty := true
			end
		end

	set_bound (p1, p2: EC_COORD_XY) is
			-- Set coordinates
		require
			not (p1 = Void)
			not (p2 = Void)
		do
			wipe_out
			enlarge (p1)
			enlarge (p2)
		end

feature -- Access

	contains (p : EC_COORD_XY) : BOOLEAN is
			-- Is p in figure?
		do
			Result := p.x >= up_left_x and then
				p.x <= down_right_x and then
				p.y >= up_left_y and then
				p.y <= down_right_y 
		end 

	includes (other: like Current): BOOLEAN is
			-- Does the rectangle surround `other'?
		require
			other_exists: other /= Void;
			other_not_empty: not other.empty
		do
			if not empty then
				Result := 
					(other.up_left_x >= up_left_x) and then
					(other.up_left_y >= up_left_y) and then
					(other.down_right_x <= down_right_x) and then
					(other.down_right_y <= down_right_y) 
			end
		end

	intersects (other: like Current): BOOLEAN is
			-- Does Current intersects `other'?
		require
			not_empty: not empty;
			other_exists: other /= Void;
			other_not_empty: not other.empty;
		do
			Result := (other.up_left_x <= down_right_x) and then
				(other.down_right_x >= up_left_x) and then
				(other.up_left_y <= down_right_y) and then
				(other.down_right_y >= up_left_y)
		end 

feature -- Element change

	enlarge (p: EC_COORD_XY) is
			-- Enlarge the rectangle in order to include `p'
		require
			point_exists: p /= Void
		do
			if empty then
				up_left_x := p.x 
				up_left_y := p.y
				down_right_x := up_left_x
				down_right_y := up_left_y
				empty := false
			else
				up_left_x := up_left_x.min (p.x)
				up_left_y := up_left_y.min (p.y)
				down_right_x := down_right_x.max (p.x)
				down_right_y := down_right_y.max (p.y)
			end
		ensure
			not empty
		end

	merge (other: like Current) is
			-- Enlarge the rectangle in order to include `other'.
		require
			rectangle_exists: other /= Void;
		do
			if not other.empty then
				if empty then
					up_left_x := other.up_left_x
					up_left_y := other.up_left_y
					down_right_x := other.down_right_x
					down_right_y := other.down_right_y
					empty := false
				else
					up_left_x := up_left_x.min (other.up_left_x)
					up_left_y := up_left_y.min (other.up_left_y)
					down_right_x := down_right_x.max (other.down_right_x)
					down_right_y := down_right_y.max (other.down_right_y)
				end
			end
		end; 

	--merge_clip (clip: CLIP) is
			-- Enlarge the rectangle in order to include `clip'.
	--	require
	--		not (clip = Void)
	--	local
	--		clos: EC_CLOSURE
	--	do
	--		!! clos.make
	--		clos.set (clip.upper_left.x, clip.upper_left.y,
	--					clip.width, clip.height)
	--		merge (clos)
	--	ensure
	--		not empty
	--	end 

feature -- Removal

	wipe_out is
			-- Wipe out the closure
		do
			empty := true
		ensure
			empty
		end 

end -- class EC_CLOSURE 
