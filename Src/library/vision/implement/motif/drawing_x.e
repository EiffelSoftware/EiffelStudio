indexing

	description: 
		"General definitions for drawable elements.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class 
	DRAWING_X

inherit

	MATH_CONST
		export
			{NONE} all
		end;

	DRAWING_I;

	G_CONTEXT_X
		rename
			gc_logical_mode as logical_mode
		end;

	MEL_DRAWING
		rename
			draw_arc as mel_draw_arc,
			draw_point as mel_draw_point,
			draw_rectangle as mel_draw_rectangle,
			fill_arc as mel_fill_arc,
			fill_polygon as mel_fill_polygon,
			fill_rectangle as mel_fill_rectangle
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
			bitmap_implementation: PIXMAP_X
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
			bitmap_implementation: PIXMAP_X
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
			x0, y0, x1, y1: INTEGER
		do
			if radius1 = radius2 then
				if arc_style /= -1 then
					x0 := (center.x+radius1*d_cos (angle1+orientation)).truncated_to_integer;
					y0 := (center.y-radius1*d_sin (angle1+orientation)).truncated_to_integer;
					x1 := (center.x+radius1*d_cos (angle1+orientation+angle2)).truncated_to_integer;
					y1 := (center.y-radius1*d_sin (angle1+orientation+angle2)).truncated_to_integer;
					join_lines (center, x0, y0, x1, y1, arc_style)
				end;
				mel_draw_arc (Current, center.x-radius1, center.y-radius1, 
						2*radius1, 2*radius1, angle_x (angle1+orientation), angle_x (angle2))
			elseif orientation = 0.0 then
				if arc_style /= -1 then
					x0 := (center.x+radius1*d_cos (angle1)).truncated_to_integer;
					y0 := (center.y-radius2*d_sin (angle1)).truncated_to_integer;
					x1 := (center.x+radius1*d_cos (angle1+angle2)).truncated_to_integer;
					y1 := (center.y-radius2*d_sin (angle1+angle2)).truncated_to_integer;
					join_lines (center, x0, y0, x1, y1, arc_style)
				end;
				mel_draw_arc (Current, center.x-radius1, center.y-radius2,
						2*radius1, 2*radius2, angle_x (angle1), angle_x (angle2))
			else
				c_draw_arc (display_handle, window, graphic_context, 
						center.x, center.y, radius1, radius2, 
						angle_x (angle1), angle_x (angle2), angle_x (orientation), arc_style)
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
			if abs (y2-y1) > abs (x2-x1) then
				coord1 := x1-(y1*(x2-x1)) // (y2-y1);
				coord2 := x1+((height-y1)*(x2-x1)) // (y2-y1);
				draw_line (Current, coord1, 0, coord2, height)
			else
				coord1 := y1-(x1*(y2-y1)) // (x2-x1);
				coord2 := y1+((width-x1)*(y2-y1)) // (x2-x1);
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
				!! list.make (points_count);
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
		do
			if (orientation = 0.0) or (orientation = 180.0) then
				mel_draw_rectangle (Current, center.x-(r_width // 2), 
						center.y -(r_height // 2), r_width-1, r_height-1);
			elseif (orientation = 90.0) or (orientation = 270.0) then
				mel_draw_rectangle (Current, center.x-(r_height // 2),
						center.y-(r_width // 2), r_height-1, r_width-1)
			else
				c_draw_rectangle (display_handle, window, graphic_context, 
						center.x, center.y, r_width // 2, r_height // 2, 
						(orientation*64).truncated_to_integer)
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
		do
			if radius1 = radius2 then
				set_arc_style (arc_style);
				mel_fill_arc (Current, center.x-radius1, center.y-radius1,
						2*radius1, 2*radius1, angle_x (angle1+orientation), angle_x (angle2))
			elseif orientation = 0.0 then
				set_arc_style (arc_style);
				mel_fill_arc (Current, center.x-radius1, center.y-radius2,
					2*radius1, 2*radius2, angle_x (angle1), angle_x (angle2))
			else
				c_fill_arc (display_handle, window, graphic_context, 
					center.x, center.y, radius1, radius2, 
					angle_x (angle1), angle_x (angle2), angle_x (orientation), arc_style)
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
				!! list.make (points.count);
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
				mel_fill_rectangle (Current, center.x-half_width, 
					center.y-half_height, r_width, r_height)
			elseif (orientation = 90.0) or (orientation = 270.0) then
				mel_fill_rectangle (Current, center.x-half_height,
					center.y-half_width, r_height, r_width)
			else
				c_fill_rectangle (display_handle, window, graphic_context, 
					center.x, center.y, half_width, half_height, 
					(orientation*64).truncated_to_integer)
			end
		end;

feature {NONE} -- Implementatin

	n_64_units: INTEGER is 64;
			-- 64 units

	n_360_degrees: INTEGER is 23040;
			-- 360 degrees in 64ths of a degree (64*360)

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
			-- (angle_x (360) = 360*64)
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

feature {NONE} -- External features

	c_fill_rectangle (dspl_pointer, wndw_obj, gc: POINTER; val1, val2,
					val3, val4, orient: INTEGER) is
		external
			"C"
		end;

	c_fill_arc (dspl_pointer, wndw_obj, gc: POINTER; val1, val2,
					val3, val4, angle1, angle2, angle3, orient: INTEGER) is
		external
			"C"
		end;

	c_draw_rectangle (dspl_pointer, wndw_obj, gc: POINTER; val1, val2,
					val3, val4, orient: INTEGER) is
		external
			"C"
		end;

	d_sin (v: REAL): REAL is
		external
			"C"
		end;

	d_cos (v: REAL): REAL is
		external
			"C"
		end;

	c_draw_arc (dspl_pointer, wndw_obj, gc: POINTER; val1, val2,
					val3, val4, angle1, angle2, angle3, style: INTEGER) is
		external
			"C"
		end;

end -- class DRAWING_X

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, 1995 Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
