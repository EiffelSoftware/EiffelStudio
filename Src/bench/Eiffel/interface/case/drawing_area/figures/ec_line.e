indexing

	description: 
		"A line is defined by a list of points.%
		%The line links all this points.";
	date: "$Date$";
	revision: "$Revision $"

deferred class EC_LINE

inherit

	CONSTANTS;
	EC_OPEN_FIG
		undefine
			attach_drawing
		end;
	EC_CLOSED_FIG;
	SINGLE_MATH

 feature -- Initialization

	make is
			-- Create a line with color `a_color'.
		local
			point: EC_COORD_XY
		do
			!!path.make;
			!!interior.make;
			!!points.make;
			!!closure.make;
			!!start;
			points.extend (start);
			!!final;
			points.extend (final)
		ensure
			has_path: path /= Void;
			has_interior: interior /= Void;
			has_two_points: points.count = 2
		end; -- line_make

feature -- Properties

	points: LINKED_LIST [EC_COORD_XY];
			-- Points defining the line

	start: EC_COORD_XY;
			-- First point

	final: EC_COORD_XY;
			-- Last point

	origin: EC_COORD_XY is
			-- origin of segment.
		do
			Result := start
		end -- origin

feature -- Setting

	set_color (a_color: EV_COLOR) is
			-- Set color of Current line to `a_color'.
		require
			valid_color_name: a_color /= Void
		do
			path.set_foreground_color (a_color);
			interior.set_foreground_color (a_color);
		end;

feature -- Update

	recompute_closure is
			-- Recalculate ec_line's closure.
		local
			left_up_corner, right_down_corner: EC_COORD_XY
		do
			closure.set_bound (start, final);
			from
				points.start
			until
				points.after
			loop
				!!left_up_corner;
				!!right_down_corner;
				left_up_corner.set_x (points.item.x - 4);
				left_up_corner.set_y (points.item.y - 4);
				right_down_corner.set_x (points.item.x + 4);
				right_down_corner.set_y (points.item.y + 4);
				closure.enlarge (left_up_corner);
				closure.enlarge (right_down_corner);
				points.forth
			end
		end 

feature -- Access

	contains (p: EC_COORD_XY): BOOLEAN is
			-- Is p in ec_line?
		local
			old_cur: CURSOR;
			pred: EC_COORD_XY;
			x_coord, y_coord: INTEGER
		do
			if closure.contains (p) then
				old_cur := points.cursor;
				x_coord := p.x;
				y_coord := p.y;
				if points.count > 2 then
					from
						points.start;
						pred := points.item;
						points.forth;
					until
						points.after or Result
					loop
							-- Interested in getting more accurate values
							-- for handles
						Result := (abs (x_coord-points.item.x) < 4 and then
										abs (y_coord-points.item.y) < 4) or else
								in_segment (x_coord, y_coord, pred, points.item);
						pred := points.item;
						points.forth
					end;
				else
					pred := points.first;
					Result := in_segment (x_coord, y_coord, 
									pred, points.last)
				end
				points.go_to (old_cur)
			end;
		end; -- contains

	segment_at (x_coord, y_coord: INTEGER): INTEGER is 
			-- Segment pointed by `x_coord' and `y_coord' 
			-- 0 if no Segment is pointed 
		local
			old_cur: CURSOR;
			pred: EC_COORD_XY
		do
			!! pred;
			pred.set (x_coord, y_coord);
			if closure.contains (pred) then
				old_cur := points.cursor;
				from
					points.start;
					pred := points.item;
					points.forth
				until
					points.after or Result > 0
				loop 
					if in_segment (x_coord, y_coord, pred, points.item) then
						Result := points.index-1
					end;
					pred := points.item;
					points.forth
				end;
				points.go_to (old_cur)
			end
		ensure
			Result >= 0;
			Result <= points.count-1
		end; -- segment_at

	point_at (x_coord, y_coord: INTEGER): INTEGER is 
			-- Point pointed by `x_coord' and `y_coord' 
			-- 0 if no point is pointed 
		local
			old_cur: CURSOR
		do
			if points.count > 2 then
				old_cur := points.cursor;
				from
					points.start
				until
					points.after or Result > 0
				loop
					if (abs (x_coord-points.item.x) < 4) and
						(abs (y_coord-points.item.y) < 4) then
						Result := points.index
					end;
					points.forth
				end;
				points.go_to (old_cur)
			end;
		ensure
			Result >= 0;
			Result <= points.count
		end -- point_at

feature {NONE} -- Implementation

	sqr (v: REAL): REAL is
			-- Square of `v'
		do
			Result := v*v
		ensure
			positive_result: Result >= 0.0
		end

	in_segment (x, y: INTEGER; p1, p2: EC_COORD_XY): BOOLEAN is
			-- Is `x`, 'y' in the the segment defined by `p1', `p2' ?
		require
			p1 /= void;
			p2 /= void
		local
			ap2, pb2: REAL;
			ab2, ab: REAL;
			n2: REAL;
		do
			--| 
			--|
			--|
			--|
			--|
			ap2 := sqr (p1.x - x) + sqr(p1.y - y);
			pb2 := sqr (p2.x - x) + sqr(p2.y - y);
			ab := sqrt (sqr (p1.x - p2.x) + sqr (p1.y - p2.y));
			ab2 := ab*ab;
			Result := 
					-- Inside p1 circle of radius 4?
				ap2 < 16 or else
					-- Inside p2 circle of radius 4?
				(pb2 < 16) or else
					-- Inside p1 circle of radius 'from p2 to p1'? 
					-- and inside p2 circle of radius 'from p2 to p1'?
					-- and distance of x and y from infinite line
					-- `p1 to p2' is less than 4?
				((ap2 <= ab2 and then pb2 <= ab2) and then
				(ab > (sqrt(ap2 - 16) + sqrt (pb2 - 16))))
		end; -- in_segment

	is_contained (p: EC_COORD_XY; lwidth: INTEGER): BOOLEAN is
			-- Is p in ec_line ?
		require
			point_exists: not (p = Void);
			width_positive: lwidth >= 0
		do
		end -- is_contained

invariant

	has_points_list: points /= Void;
	two_points_at_least: points.count >= 2;
	has_start: start /= Void;
	has_final: final /= Void

end -- class EC_LINE
