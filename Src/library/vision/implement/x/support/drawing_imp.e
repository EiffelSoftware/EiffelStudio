indexing

	description: 
		"General definitions for drawable elements.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class 
	DRAWING_IMP

inherit

	DOUBLE_MATH
		export
			{NONE} all
		undefine
			is_equal
		end;

	DRAWING_I
		undefine
			is_equal
		end;

	G_CONTEXT_X
		rename
			is_destroyed as gc_destroyed,
			gc_logical_mode as logical_mode,
			destroy as gc_destroy
		end;

	MEL_DRAWING
		rename
			draw_arc as mel_draw_arc,
			draw_point as mel_draw_point,
			draw_rectangle as mel_draw_rectangle,
			fill_arc as mel_fill_arc,
			fill_polygon as mel_fill_polygon,
			fill_rectangle as mel_fill_rectangle
		undefine
			is_equal
		end;

feature -- Access

	max_count_for_draw_polyline: INTEGER is
			-- Maximum value for `points.count' for `draw_polyline'
		do
			Result := (display.max_request_size-3) // 2
		end;

feature -- Output

	clear is
			-- Clear the entire area.
		do
			if is_drawable then
				clear_window;				
			end
		end;

	copy_bitmap (a_point: COORD_XY; a_bitmap: PIXMAP) is
			-- Copy `a_bitmap' to the drawing at `a_point'.
		local
			bitmap_implementation: PIXMAP_IMP
		do
			bitmap_implementation ?= a_bitmap.implementation;
			bitmap_implementation.allocate_bitmap;
			copy_plane (bitmap_implementation.bitmap, Current,
					0, 0, bitmap_implementation.width, 
					bitmap_implementation.height,
					a_point.x, a_point.y, 1)
		end;

	copy_pixmap (a_point: COORD_XY; a_pixmap: PIXMAP) is
			-- Copy `a_pixmap' to the drawing at `a_point'.
		local
			bitmap_implementation: PIXMAP_IMP
		do
			bitmap_implementation ?= a_pixmap.implementation;
			x_copy_area (display_handle, 
				bitmap_implementation.identifier, window, graphic_context,
				0, 0, bitmap_implementation.width, bitmap_implementation.height, 
				a_point.x, a_point.y)
		end;

	draw_arc (center: COORD_XY; radius1, radius2: INTEGER; 
				angle1, angle2, orientation: REAL; arc_style: INTEGER) is
			-- Draw an arc centered in (`x', `y') with a great radius of
			-- `radius1' and a small radius of `radius2'
			-- beginnning at `angle1' and finishing at `angle1'+`angle2'
			-- and with an orientation of `orientation'.
		local
			x0, y0, x1, y1: INTEGER;
			double_x0, double_y0, double_x1, double_y1: DOUBLE;
			loc_arc_points: ARRAYED_LIST [MEL_POINT];
			mel_center: MEL_POINT
		do
			if radius1 = radius2 then
				if arc_style /= -1 then 
					double_x0 := center.x + radius1 * cosine ((angle1 + orientation) * deg_rad_rate);					
					double_y0 := center.y - radius1 * sine ((angle1 + orientation) * deg_rad_rate);
					double_x1 := center.x + radius1 * cosine ((angle1 + orientation + angle2) * deg_rad_rate);
					double_y1 := center.y - radius1 * sine ((angle1 + orientation + angle2) * deg_rad_rate);
					x0 := double_x0.truncated_to_integer;
					y0 := double_y0.truncated_to_integer;
					x1 := double_x1.truncated_to_integer;
					y1 := double_y1.truncated_to_integer;
					join_lines (center, x0, y0, x1, y1, arc_style)
				end;
				mel_draw_arc (Current, center.x-radius1, center.y-radius1, 
						2*radius1, 2*radius1, angle_x (angle1+orientation), angle_x (angle2))
			elseif orientation = 0.0 then
				if arc_style /= -1 then
					double_x0 := center.x + radius1 * cosine (angle1 * deg_rad_rate);
					double_y0 := center.y - radius2 * sine (angle1 * deg_rad_rate);
					double_x1 := center.x + radius1 * cosine ((angle1 + angle2) * deg_rad_rate);
					double_y1 := center.y - radius2 * sine ((angle1 + angle2) * deg_rad_rate);
					x0 := double_x0.truncated_to_integer;
					y0 := double_y0.truncated_to_integer;
					x1 := double_x1.truncated_to_integer;
					y1 := double_y1.truncated_to_integer;
					join_lines (center, x0, y0, x1, y1, arc_style)
				end;
				mel_draw_arc (Current, center.x-radius1, center.y-radius2,
						2*radius1, 2*radius2, angle_x (angle1), angle_x (angle2))
			else
				loc_arc_points := arc_points (center, radius1, radius2, angle1, angle2, orientation);
				if arc_style = 0 then
					loc_arc_points.extend (loc_arc_points.first)
				elseif arc_style = 1 then
					!!mel_center.make (center.x, center.y);
					loc_arc_points.extend (mel_center);
					loc_arc_points.extend (loc_arc_points.first)
				end;
				draw_lines (Current, loc_arc_points, True)
			end
		end;

	draw_image_text (base: COORD_XY; text: STRING) is
			-- Draw text
		local
			ext_name: ANY
		do
			draw_image_string (Current, base.x, base.y, text)
		end;

	draw_inf_line (point1, point2: COORD_XY) is
			-- Draw an infinite line traversing `point1' and `point2'.
		local
			x1, y1, x2, y2: INTEGER;
			coord1, coord2: INTEGER
		do
			x1 := point1.x;
			y1 := point1.y;
			x2 := point2.x;
			y2 := point2.y;
			if abs (y2 - y1) > abs (x2 - x1) then
				coord1 := x1 - (y1 * (x2 - x1)) // (y2 - y1);
				coord2 := x1 + ((height - y1) * (x2 - x1)) // (y2 - y1);
				draw_line (Current, coord1, 0, coord2, height)
			else
				coord1 := y1 - (x1 * (y2 - y1)) // (x2 - x1);
				coord2 := y1 + ((width - x1) * (y2 - y1)) // (x2 - x1);
				draw_line (Current, 0, coord1, width, coord2)
			end
		end;

	draw_point (a_point: COORD_XY) is
			-- Draw `a_point'.
		do
			mel_draw_point (Current, a_point.x, a_point.y)
		end;

	draw_polyline (points: LIST [COORD_XY]; is_closed: BOOLEAN) is
			-- Draw a polyline, close it automatically if `is_closed'.
		local
			cur: CURSOR;
			mp: MEL_POINT;
			p: COORD_XY;
			points_count: INTEGER;
			list: FIXED_LIST [MEL_POINT]
		do
			if is_closed and ((points.first.x /= points.last.x) or (points.first.y /= points.last.y)) then
				points_count := points.count + 1
			else
				points_count := points.count
			end;
			cur := points.cursor;
			from
				!! list.make_filled (points_count);
				list.start;
				points.start
			until
				points.after
			loop
				p := points.item
				!! mp.make (p.x, p.y);
				list.replace (mp);
				list.forth;
				points.forth
			end;
			if not list.after then
				p := points.first;
				!! mp.make (p.x, p.y);
				list.replace (mp)
			end;
			check
				valid_list: not list.has (Void)
			end;
			points.go_to (cur);
			draw_lines (Current, list, True);
		end;

	draw_rectangle (center: COORD_XY; r_width, r_height: INTEGER; orientation: REAL) is
			-- Draw a rectangle whose center is `center' and
			-- whose size is `r_width' and `r_height'.
		local
			r_points: ARRAYED_LIST [MEL_POINT];
		do
			if (orientation = 0.0) or (orientation = 180.0) then
				mel_draw_rectangle (Current, center.x - (r_width // 2),
				center.y - (r_height // 2), r_width - 1, r_height - 1);
			elseif (orientation = 90.0) or (orientation = 270.0) then
				mel_draw_rectangle (Current, center.x - (r_height // 2),
				center.y - (r_width // 2), r_height - 1, r_width - 1)
			else
				r_points := rectangle_points (center, r_width, r_height, orientation);
				r_points.extend (r_points.first);
				draw_lines (Current, r_points, True)
			end
		end;

	draw_segment (point1, point2: COORD_XY) is
			-- Draw a segment between `point1' and `point2'.
		do
			draw_line (Current, point1.x, point1.y, point2.x, point2.y)
		end;

	draw_text (base: COORD_XY; text: STRING) is
			-- Draw text
		do
			draw_string (Current, base.x, base.y, text)
		end;			
			
	fill_arc (center: COORD_XY; radius1, radius2: INTEGER; 
				angle1, angle2, orientation: REAL; arc_style: INTEGER) is
			-- Fill an arc centered in (`x', `y') with a great radius of
			-- `radius1' and a small radius of `radius2'
			-- beginnning at `angle1' and finishing at `angle1'+`angle2'
			-- and with an orientation of `orientation'.
		local
			loc_arc_points: ARRAYED_LIST [MEL_POINT];
			mel_center: MEL_POINT
		do
			if radius1 = radius2 then
				set_arc_style (arc_style);
				mel_fill_arc (Current, center.x - radius1, center.y - radius1,
						2 * radius1, 2 * radius1, angle_x (angle1 + orientation), angle_x (angle2))
			elseif orientation = 0.0 then
				set_arc_style (arc_style);
				mel_fill_arc (Current, center.x - radius1, center.y - radius2,
					2 * radius1, 2 * radius2, angle_x (angle1), angle_x (angle2))
			else
				loc_arc_points := arc_points (center, radius1, radius2, angle1, angle2, orientation);
				if arc_style = 1 then
					!!mel_center.make (center.x, center.y);
					loc_arc_points.extend (mel_center);
					loc_arc_points.extend (loc_arc_points.first)
				end
				mel_fill_polygon (Current, loc_arc_points, Complex,True)
			end
		end;

	fill_polygon (points: LIST [COORD_XY]) is
			 -- Fill a polygon.
		local
			cur: CURSOR;
			mp: MEL_POINT;
			p: COORD_XY;
			list: FIXED_LIST [MEL_POINT]
		do
			cur := points.cursor;
			from
				!! list.make_filled (points.count);
				list.start;
				points.start
			until
				points.after
			loop
				p := points.item
				!! mp.make (p.x, p.y);
				list.replace (mp);
				list.forth;
				points.forth
			end;
			mel_fill_polygon (Current, list, Complex, True);
		end;

	fill_rectangle (center: COORD_XY; r_width, r_height: INTEGER; orientation: REAL) is
			-- Fill a rectangle whose center is `center' and
			-- whose size is `r_width' and `r_height'.
		local
			half_width, half_height: INTEGER
		do
			half_width := r_width // 2;
			half_height := r_height // 2;
			if (orientation = 0.0) or (orientation = 180.0) then
				mel_fill_rectangle (Current, center.x - half_width, 
					center.y - half_height, r_width, r_height)
			elseif (orientation = 90.0) or (orientation = 270.0) then
				mel_fill_rectangle (Current, center.x - half_height,
					center.y - half_width, r_height, r_width)
			else
				mel_fill_polygon (Current, rectangle_points (center, r_width, r_height, orientation), Complex, True)
			end
		end;


feature {NONE} -- Implementation

	n_64_units: INTEGER is 64;
			-- 64 units

	n_360_degrees: INTEGER is 23040;
			-- 360 degrees in 64ths of a degree (64 * 360)

	height: INTEGER is
			-- Height of drawing area
		deferred
		end;

	width: INTEGER is
			-- Width of drawing 
		deferred
		end;

	angle_x (angle: REAL): INTEGER is
			-- Convert `angle' in an integer in 64th of degree
			-- (angle_x (360) = 360 * 64)
		do
			Result := (n_64_units*angle).truncated_to_integer;
			if Result > n_360_degrees then
				Result := Result \\ n_360_degrees
			end
		ensure
			result_greater_than: Result >= - n_360_degrees;
			result_less_than: Result <= n_360_degrees
		end;

	join_lines (center: COORD_XY; x0, y0, x1, y1: INTEGER; arc_style: INTEGER) is
			-- Join (x0, y0) and (x1, y1) if `arc_style' = 0,
			-- or join ((x0, y0), center and (x1, y1) if `arc_style' = 1.
		require
			center_not_void: center /= Void;
			valid_arc_style: arc_style >= 0 and then arc_style <= 1
		do
			if (arc_style = 0) then
				draw_line (Current, x0, y0, x1, y1)
			else
				draw_line (Current, x0, y0, center.x, center.y);
				draw_line (Current, center.x, center.y, x1, y1)
			end
		end;

	arc_points (center: COORD_XY; radius1, radius2: INTEGER; 
				angle1, angle2, orientation: REAL): ARRAYED_LIST [MEL_POINT] is
			-- Returns the list of an arbitrary number of ordonated points composing the arc
		local
			seg_count, loop_angle, angle_inc, sino, coso, ell_x, ell_y, rot_x, rot_y: DOUBLE;
			point_count, i, loop_upper_bound, center_x, center_y: INTEGER;
			a_point: MEL_POINT;
			points_area: SPECIAL [MEL_POINT];
			array: ARRAY [MEL_POINT]
		do
			coso := cosine (- orientation * deg_rad_rate);
			sino := sine (- orientation * deg_rad_rate);
			center_x := center.x;
			center_y := center.y;
			seg_count:= 4 * radius1.max(radius2) * angle2 * deg_rad_rate;
			point_count := seg_count.rounded + 1;
			angle_inc := - angle2 * deg_rad_rate / (point_count - 1);
			!!Result.make_filled (point_count);
			array := Result;
			points_area := array.area;
			loop_upper_bound := point_count - 1;
			from
				i := 0
			until
				i > loop_upper_bound
			loop
				ell_x := radius1 * cosine (loop_angle);
				ell_y := radius2 * sine (loop_angle);
				rot_x := center_x + ell_x * coso - ell_y * sino;
				rot_y := center_y + ell_x * sino + ell_y * coso;
				!!a_point.make (rot_x.rounded, rot_y.rounded);
				points_area.put (a_point, i);
				loop_angle := loop_angle + angle_inc;
				i := i + 1
			end
		end;

	deg_rad_rate: DOUBLE is
			-- degrees into radians conversion constant
		once
			Result := Pi / 180
		end

	rectangle_points (center: COORD_XY; r_width, r_height: INTEGER; orientation: REAL): ARRAYED_LIST [MEL_POINT] is
			-- Returns the 4 points composing the rectangle
		local
			coso, sino, point_x, point_y, half_r_width_coso, half_r_width_sino, half_r_height_coso, half_r_height_sino: DOUBLE
			a_point: MEL_POINT
		do
			!! Result.make (4);
			coso := cosine (- orientation * Pi / 180); -- Ys are downward under Motif
			sino := sine (- orientation * Pi / 180);
			half_r_width_coso := r_width * coso / 2;
			half_r_width_sino := r_width * sino / 2;
			half_r_height_coso := r_height * coso / 2;
			half_r_height_sino := r_height * sino / 2;
			point_x := center.x + half_r_width_coso - half_r_height_sino;
			point_y := center.y + half_r_width_sino + half_r_height_coso;
			!! a_point.make (point_x.rounded, point_y.rounded);
			Result.extend (a_point);
			point_x := center.x - half_r_width_coso - half_r_height_sino;
			point_y := center.y - half_r_width_sino + half_r_height_coso;
			!! a_point.make (point_x.rounded, point_y.rounded);
			Result.extend (a_point);
			point_x := center.x - half_r_width_coso + half_r_height_sino;
			point_y := center.y - half_r_width_sino - half_r_height_coso;
			!! a_point.make (point_x.rounded, point_y.rounded);
			Result.extend (a_point);
			point_x := center.x + half_r_width_coso + half_r_height_sino;
			point_y := center.y + half_r_width_sino - half_r_height_coso;
			!! a_point.make (point_x.rounded, point_y.rounded);
			Result.extend (a_point)
		end;

end -- class DRAWING_IMP


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

