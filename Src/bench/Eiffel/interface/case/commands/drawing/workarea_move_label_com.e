indexing

	description: 
		"Command thats moves a label along the relation.";
	date: "$Date$";
	revision: "$Revision $"

class WORKAREA_MOVE_LABEL_COM

inherit

	WORKAREA_MOVE_DATA_COM

	SINGLE_MATH

creation

	make

feature -- Output

	draw is
			-- Draw text during action.
		local
			rel_pt, rel_offset_pt, n, pt: EC_COORD_XY;
			nx, ny: DOUBLE;
			dy, dx: INTEGER;
			dny, dnx: INTEGER;
			new_x: INTEGER;
			a, b: EC_COORD_XY;
			pts: ARRAYED_LIST [EC_COORD_XY];
			mp_r, r: REAL;
			offset: INTEGER;
			was_set: BOOLEAN;
			dan_sq, dap_sq: REAL;
			x_offset, y_offset: INTEGER;	
			offsets: CELL2 [INTEGER, INTEGER];
			last_dist_sq, tmp: REAL;
			ls: BOOLEAN;
		do
			if reverse then
				x_offset := start_rel_x - relation.reverse_label.base_left.x;
				y_offset := start_rel_y - relation.reverse_label.base_left.y 
			else
				x_offset := start_rel_x - relation.label.base_left.x; 
				y_offset := start_rel_y - relation.label.base_left.y 
			end;
			!! rel_pt;
			rel_pt.set (relative_x, relative_y);
			!! rel_offset_pt;
			rel_offset_pt.set (relative_x - x_offset, relative_y - y_offset);
				-- Mouse point position
			pts := relation.closest_points (relative_x, relative_y, reverse);
				-- From handle point

			from
				pts.start;
					-- From point
				a := pts.item;
				pts.forth
			until
				pts.after 
			loop
					-- To point
				b := pts.item;
					-- Calculate the coordinate (p) on the line a->b perpendicular
					-- to point n. (Ask ericb on how the following formula
					-- was calculated).
				if equal (a, b) then
						-- Same point
					ratio := 0.0;
					a := b;
					pts.forth;
				else
					ls := is_label_on_left_side (a, b);
					offsets := relation.calcualate_offsets (a, 
							b, ls, reverse);
					!! n;
					n.set (rel_offset_pt.x - offsets.item1, 
								rel_offset_pt.y - offsets.item2);
						-- This ratio is for relative point
						-- of the label on the line.	
					r := compute_ratio (a, b, n);
						-- Get ratio from actual mouse point
					mp_r := compute_ratio (a, b, rel_pt);	
					if mp_r >= 0 and then mp_r <= 1 then
						if pts.count > 2 then
							dap_sq := mp_r*sqrt(dist_sq_from_two_pts (a, b));
							dap_sq := dap_sq*dap_sq;
							dan_sq := dist_sq_from_two_pts (a, rel_pt);
							tmp := dan_sq - dap_sq;
						end;
						if not was_set or else tmp <= last_dist_sq then
							-- Compare distance to a->b with
							-- with last mp point
							last_dist_sq := tmp;
							if r < 0 then
								r := 0
							elseif r > 1 then
								r := 1
							end
							left_side := ls;
							from_point := a;
							to_point := b;
							from_handle := a;
							ratio := r;
						end;
						was_set := True;
					end;
					pts.forth;
					a := b;
				end;
			end;
			if from_point /= Void then
				current_point := relation.compute_label_coord (reverse,
							left_side,
							from_point, to_point, ratio);
				relation.invert_label_skeleton 
						(workarea.inverted_painter, 
						current_point, reverse)
			end
		end; 

	erase is
			-- Erase the text drawn during action.
		do
			if current_point /= Void then
				relation.invert_label_skeleton 
					(workarea.inverted_painter, 
					current_point, reverse)
			end
		end 

feature -- Execution

	execute_button_release (notused: NONE; butrel_data: EV_BUTTON_EVENT_DATA) is
			-- Called when the mouse button is released.
		local
			move_label_u: MOVE_LABEL_U
		do
			if moving then
				erase
			end
			workarea.drawing_area.remove_motion_notify_commands
			workarea.drawing_area.remove_button_release_commands (1)
			if from_handle /= Void then 
				!! move_label_u.make (relation.data, left_side, 
					reverse, ratio, relation.handle_position (reverse, from_handle))
			end
			relation := Void
			from_handle := Void
			current_point := Void
			to_point := Void
			from_point := Void
			moving := False
		ensure then
			relation = Void
			from_handle = Void
			current_point = Void
		end 

feature {NONE} -- Implementation properties

	from_handle: EC_COORD_XY
			-- Current from handle 

	ratio: REAL
			-- From ratio where label is positioned

	left_side: BOOLEAN
			-- Is label on the left side?

	reverse: BOOLEAN
			-- Is label is reverse label data?

	relation: GRAPH_CLIENTELE
			-- Graph relation in which we add a handle

	from_point, to_point, current_point: EC_COORD_XY
			-- Current points where label is being displayed

feature {WORKAREA_SELECT_COM} -- Implementation

	set_relation (new_relation: like relation; r: BOOLEAN) is
			-- Set relation in which we add a handle
		require
			has_relation: new_relation /= void
		do
			relation := new_relation
			reverse := r
		ensure
			relation_correctly_set: relation = new_relation
		end

feature {NONE} -- Implementation

	is_label_on_left_side (a, b: EC_COORD_XY): BOOLEAN is
			-- Calculate with side for point `n' relative
			-- to `from_point' and `b'
		local
			rel_x, rel_y: INTEGER;
			x, y: INTEGER;
			is_left_of_line: BOOLEAN
		do
					-- Ordered as:
					-- 4th / 1st
					-- 3rd / 2nd (Quadrants
			rel_x := (b.x - a.x);
			rel_y := (b.y - a.y);
					-- 1st quad
			if ((b.x - a.x)*
						(relative_y - a.y) -
					(b.y - a.y)*
						(relative_x - a.x)) < 0
			then
				is_left_of_line := True
			end;
				-- Left_on_is_side gives the visual orientation.
					-- first quad
			if (rel_x > 0) and (rel_y < 0) or else
					-- 4th quad
				(rel_x < 0) and (rel_y < 0)
			then
				Result := is_left_of_line
			elseif -- 2nd quad
				(rel_x > 0) and (rel_y > 0) or else
					-- 3rd quad
				(rel_x < 0) and (rel_y > 0)
			then
				Result := not is_left_of_line
			elseif (rel_x = 0) then
					-- Vertical
				Result := (relative_x <= a.x)
			elseif (rel_y = 0) then
					-- Horizontal
				if rel_x > 0 then
						-- right side
					Result := (relative_y <= a.y)
				else
						-- left side
					Result := (relative_y >= a.y)
				end
			end;
		end;

	dist_sq_from_two_pts (a, b: EC_COORD_XY): INTEGER is
			-- Distance squared from `pt1' to `pt2'
		local
			aby: INTEGER
			abx: INTEGER
		do
			aby := (a.y - b.y)
			abx := (a.x - b.x)
			Result := abx*abx + aby*aby
		end

	compute_ratio (a, b, n: EC_COORD_XY): REAL is
			-- Compute ratio between pt `a' and 
			-- perpendicular line from `n' to `a' and
			-- `b' relative to point `b'.
		local
			xan, yan, xbn, ybn, xab, yab: REAL
		do
			xan := (a.x - n.x)
			yan := (a.y - n.y)
			xbn := (b.x - n.x)
			ybn := (b.y - n.y)
			xab := (a.x - b.x)
			yab := (a.y - b.y)
			Result := 0.5*(((yan*yan + xan*xan - xbn*xbn - ybn*ybn)/
					(xab*xab + yab*yab)) + 1)
		end

invariant

	from_point /= Void implies to_point /= Void

end -- class WORKAREA_MOVE_LABEL_COM
