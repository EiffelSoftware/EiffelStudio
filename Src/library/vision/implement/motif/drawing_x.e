
-- General definitions for drawable elements.

indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class DRAWING_X 

inherit

	MATH_CONST
		export
			{NONE} all
		end;

	G_CONTEXT_X

feature {NONE}

	angle_x (angle: REAL): INTEGER is
			-- Convert `angle' in an integer in 64th of degree
			-- (angle_x (360) = 360*64)
		do
			Result := real_to_integer (64*angle);
			if Result > 23040 then
				Result := Result \\ 23040
			end
		ensure
			Result >= -23040;
			Result <= 23040
		end; -- angle_x

feature 

	clear is
			-- Clear the entire area.
		do
			if is_drawable then
				x_clear_window (display_pointer, window_object)
			end
		end;

	copy_bitmap (a_point: COORD_XY; a_bitmap: PIXMAP) is
			-- Copy `a_bitmap' to the drawing at `a_point'.
		require
			a_point_exists: not (a_point = Void);
			a_bitmap_exists: not (a_bitmap = Void);
			a_bitmap_valid: a_bitmap.is_valid
		
		local
			resource_x: POINTER;
			a_bitmap_implementation: PIXMAP_X	
		do
			a_bitmap_implementation ?= a_bitmap.implementation;
			resource_x := a_bitmap_implementation.resource_bitmap (screen);
			x_copy_plane (display_pointer, resource_x, window_object, graphic_context, 0, 0, a_bitmap.width, a_bitmap.height, a_point.x, a_point.y, 1)
		end;

	copy_pixmap (a_point: COORD_XY; a_pixmap: PIXMAP) is
			-- Copy `a_pixmap' to the drawing at `a_point'.
		require
			a_point_exists: not (a_point = Void);
			a_pixmap_exists: not (a_pixmap = Void);
			a_pixmap_valid: a_pixmap.is_valid
		local
			resource_x: POINTER;
			a_bitmap_implementation: PIXMAP_X	
		do
			a_bitmap_implementation ?= a_pixmap.implementation;
			resource_x := a_bitmap_implementation.resource_pixmap (screen);
			x_copy_area (display_pointer, resource_x, window_object, graphic_context, 0, 0, a_pixmap.width, a_pixmap.height, a_point.x, a_point.y)
		end; 

	draw_arc (center: COORD_XY; radius1, radius2: INTEGER; angle1, angle2, orientation: REAL; arc_style: INTEGER) is
			-- Draw an arc centered in (`x', `y') with a great radius of
			-- `radius1' and a small radius of `radius2'
			-- beginnning at `angle1' and finishing at `angle1'+`angle2'
			-- and with an orientation of `orientation'.
		require
			center_exits: not (center = Void);
			radius1 >= 0;
			radius2 >= 0;
			angle1 >= 0;
			angle2 >= 0;
			angle1+angle2 <= 360;
			orientation >= 0;
			orientation < 360;
			arc_style >= -1;
			arc_style <= 1
		local
			x0, y0, x1, y1: INTEGER
		do
			if radius1 = radius2 then
				if arc_style /= -1 then
					x0 := real_to_integer (center.x+radius1*d_cos (angle1+orientation));
					y0 := real_to_integer (center.y-radius1*d_sin (angle1+orientation));
					x1 := real_to_integer (center.x+radius1*d_cos (angle1+orientation+angle2));
					y1 := real_to_integer (center.y-radius1*d_sin (angle1+orientation+angle2));
					join_lines (center, x0, y0, x1, y1, arc_style)
				end;
				x_draw_arc (display_pointer, window_object, graphic_context, center.x-radius1, center.y-radius1, 2*radius1, 2*radius1, angle_x (angle1+orientation), angle_x (angle2))
			elseif orientation = 0.0 then
				if arc_style /= -1 then
					x0 := real_to_integer (center.x+radius1*d_cos (angle1));
					y0 := real_to_integer (center.y-radius2*d_sin (angle1));
					x1 := real_to_integer (center.x+radius1*d_cos (angle1+angle2));
					y1 := real_to_integer (center.y-radius2*d_sin (angle1+angle2));
					join_lines (center, x0, y0, x1, y1, arc_style)
				end;
				x_draw_arc (display_pointer, window_object, graphic_context, center.x-radius1, center.y-radius2, 2*radius1, 2*radius2, angle_x (angle1), angle_x (angle2))
			else
				c_draw_arc (display_pointer, window_object, graphic_context, center.x, center.y, radius1, radius2, angle_x (angle1), angle_x (angle2), angle_x (orientation), arc_style)
			end
		end;

	draw_image_text (base: COORD_XY; text: STRING) is
			-- Draw text
		require
			text_exists: not (text = Void);
			base_exists: not (base = Void)
		local
			ext_name: ANY
		do
			ext_name := text.to_c;
			x_draw_image_string (display_pointer, window_object, graphic_context, base.x, base.y, $ext_name, text.count)
		end; 

	draw_inf_line (point1, point2: COORD_XY) is
			-- Draw an infinite line traversing `point1' and `point2'.
		require
			point1_exists: not (point1 = Void);
			point2_exists: not (point2 = Void)
		
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
				x_draw_line (display_pointer, window_object, graphic_context, coord1, 0, coord2, height)
			else
				coord1 := y1-(x1*(y2-y1)) // (x2-x1);
				coord2 := y1+((width-x1)*(y2-y1)) // (x2-x1);
				x_draw_line (display_pointer, window_object, graphic_context, 0, coord1, width, coord2)
			end
		end;

	draw_point (a_point: COORD_XY) is
			-- Draw `a_point'.
		
		do
			x_draw_point (display_pointer, window_object, graphic_context, a_point.x, a_point.y)
		end;

	draw_polyline (points: LIST [COORD_XY]; is_closed: BOOLEAN) is
			-- Draw a polyline, close it automatically if `is_closed'.
		require
			points_exists: not (points = Void);
			list_not_empty: not points.empty;
			list_not_too_large: points.count <= max_count_for_draw_polyline
		
		local
			array_points: POINTER;
			points_count: INTEGER;
			keep_cursor: CURSOR;
		do
			if is_closed and ((points.first.x /= points.last.x) or (points.first.x /= points.last.y)) then
				points_count := points.count+1
			else
				points_count := points.count
			end;
			array_points := c_create_points (points_count);
			keep_cursor := points.cursor;
			from
				points.start
			until
				points.off
			loop
				c_put_point (array_points, points.index-1, points.item.x, points.item.y);
				points.forth
			end;
			if points_count = points.count+1 then
				c_put_point (array_points, points_count-1, points.first.x, points.first.y)
			end;
			points.go_to (keep_cursor);
			x_draw_lines (display_pointer, window_object, graphic_context, array_points, points_count, CoordModeOrigin);
			c_free_points (array_points)
		end; 

	draw_rectangle (center: COORD_XY; r_width, r_height: INTEGER; orientation: REAL) is
			-- Draw a rectangle whose center is `center' and
			-- whose size is `r_width' and `r_height'.
		require
			center_exists: not (center = Void);
			width_positive: r_width >= 0;
			height_positive: r_height >= 0;
			an_orientation_positive: orientation >= 0;
			an_orientation_less_than_360: orientation < 360
		
		do
			if (orientation = 0.0) or (orientation = 180.0) then
				x_draw_rectangle (display_pointer, window_object, graphic_context, center.x-(r_width // 2), center.y-(r_height // 2), r_width-1, r_height-1)
				elseif (orientation = 90.0) or (orientation = 270.0) then
				x_draw_rectangle (display_pointer, window_object, graphic_context, center.x-(r_height // 2), center.y-(r_width // 2), r_height-1, r_width-1)
			else
				c_draw_rectangle (display_pointer, window_object, graphic_context, center.x, center.y, r_width // 2, r_height // 2, real_to_integer (orientation*64))
			end
		end;

	draw_segment (point1, point2: COORD_XY) is
			-- Draw a segment between `point1' and `point2'.
		require
			point1_exists: not (point1 = Void);
			point2_exists: not (point2 = Void)
		
		do
			x_draw_line (display_pointer, window_object, graphic_context, point1.x, point1.y, point2.x, point2.y)
		end;

	draw_text (base: COORD_XY; text: STRING) is
			-- Draw text
		require
			text_exists: not (text = Void);
			base_exists: not (base = Void)
		local
			ext_name: ANY
		do
			ext_name := text.to_c;
			x_draw_string (display_pointer, window_object, graphic_context, base.x, base.y, $ext_name, text.count)
		end; 

	
feature {NONE}

	fill_arc (center: COORD_XY; radius1, radius2: INTEGER; angle1, angle2, orientation: REAL; arc_style: INTEGER) is
			-- Fill an arc centered in (`x', `y') with a great radius of
			-- `radius1' and a small radius of `radius2'
			-- beginnning at `angle1' and finishing at `angle1'+`angle2'
			-- and with an orientation of `orientation'.
		require
			center_exits: not (center = Void);
			radius1 >= 0;
			radius2 >= 0;
			angle1 >= 0;
			angle2 >= 0;
			angle1+angle2 <= 360;
			orientation >= 0;
			orientation < 360;
			arc_style >= 0;
			arc_style <= 1
		
		do
			if radius1 = radius2 then
				set_arc_style (arc_style);
				x_fill_arc (display_pointer, window_object, graphic_context, center.x-radius1, center.y-radius1, 2*radius1, 2*radius1, angle_x (angle1+orientation), angle_x (angle2))
			elseif orientation = 0.0 then
				set_arc_style (arc_style);
				x_fill_arc (display_pointer, window_object, graphic_context, center.x-radius1, center.y-radius2, 2*radius1, 2*radius2, angle_x (angle1), angle_x (angle2))
			else
				c_fill_arc (display_pointer, window_object, graphic_context, center.x, center.y, radius1, radius2, angle_x (angle1), angle_x (angle2), angle_x (orientation), arc_style)
			end
		end;

	
feature 

	fill_polygon (points: LIST [COORD_XY]) is
			 -- Fill a polygon.
		require
			points_exists: not (points = Void);
			list_with_two_points_at_least: points.count >= 3;
			list_not_too_large: points.count <= max_count_for_draw_polyline
		
		local
			array_points: POINTER;
			keep_cursor: CURSOR;
		do
			array_points := c_create_points (points.count);
			keep_cursor := points.cursor;
			from
				points.start
			until
				points.off
			loop
				c_put_point (array_points, points.index-1, points.item.x, points.item.y);
				points.forth
			end;
			points.go_to (keep_cursor);
			x_fill_polygon (display_pointer, window_object, graphic_context, array_points, points.count, Complex, CoordModeOrigin);
			c_free_points (array_points)
		end;

	fill_rectangle (center: COORD_XY; r_width, r_height: INTEGER; orientation: REAL) is
			-- Fill a rectangle whose center is `center' and
			-- whose size is `r_width' and `r_height'.
		require
			center_exists: not (center = Void);
			width_positive: r_width >= 0;
			height_positive: r_height >= 0;
			an_orientation_positive: orientation >= 0;
			an_orientation_less_than_360: orientation < 360
		
		local
			half_width, half_height: INTEGER
		do
			half_width := r_width // 2;
			half_height := r_height // 2;
			if (orientation = 0.0) or (orientation = 180.0) then
				x_fill_rectangle (display_pointer, window_object, graphic_context, center.x-half_width, center.y-half_height, r_width, r_height)
				elseif (orientation = 90.0) or (orientation = 270.0) then
				x_fill_rectangle (display_pointer, window_object, graphic_context, center.x-half_height, center.y-half_width, r_height, r_width)
			else
				c_fill_rectangle (display_pointer, window_object, graphic_context, center.x, center.y, half_width, half_height, real_to_integer (orientation*64))
			end
		end; 

	
feature {NONE}

	height: INTEGER is
			-- Height of drawing area
		deferred
		end; 

	join_lines (center: COORD_XY; x0, y0, x1, y1: INTEGER; arc_style: INTEGER) is
			-- Join (x0, y0) and (x1, y1) if `arc_style' = 0,
			-- or join ((x0, y0), center and (x1, y1) if `arc_style' = 1.
		require
			not (center = Void);
			arc_style >= 0;
			arc_style <= 1
		
		do
			if (arc_style = 0) then
				x_draw_line (display_pointer, window_object, graphic_context, x0, y0, x1, y1)
			else
				x_draw_line (display_pointer, window_object, graphic_context, x0, y0, center.x, center.y);
				x_draw_line (display_pointer, window_object, graphic_context, center.x, center.y, x1, y1)
			end
		end;

	
feature 

	max_count_for_draw_polyline: INTEGER is
			-- Maximum value for `points.count' for `draw_polyline'
		
		do
			Result := (x_max_request_size (display_pointer)-3) // 2
		ensure
			Result >= 1
		end;

	set_background_gc_color (background_color: COLOR) is
			-- Set background value of GC.
		require
			color_not_void: not (background_color = Void)
		local
			background_color_implementation: COLOR_X	
		do
			background_color_implementation ?= background_color.implementation;
			set_gc_background (background_color_implementation.pixel (screen))
		end;

	set_drawing_font (font: FONT) is
			-- Set a font.
		require
			font_exists: not (font = Void)
		local
			font_implementation: FONT_X	
		do
			font_implementation ?= font.implementation;
			x_set_font (display_pointer, graphic_context, c_font_id (font_implementation.resource (screen)))
		end;

	set_foreground_gc_color (foreground_color: COLOR) is
			-- Set foreground value of GC.
		require
			color_not_void: not (foreground_color = Void)
		local
			foreground_color_implementation: COLOR_X	
		do
			foreground_color_implementation ?= foreground_color.implementation;
			set_gc_foreground (foreground_color_implementation.pixel (screen))
		end;

	
feature {NONE}

	width: INTEGER is
			-- Width of drawing area
		deferred
		end;


feature {NONE} -- External features

	x_clear_window (dspl_pointer, wndw_obj: POINTER) is
		external
			"C"
		alias
			"XClearWindow"
		end;

	c_font_id (p: POINTER): POINTER is
		external
			"C"
		end;

	x_set_font (dspl_pointer, gc, val: POINTER) is
		external
			"C"
		alias
			"XSetFont"
		end;

	x_max_request_size (dspl_pointer: POINTER): INTEGER is
		external
			"C"
		alias
			"XMaxRequestSize"
		end;

	c_fill_rectangle (dspl_pointer, wndw_obj, gc: POINTER; val1, val2,
                    val3, val4, orient: INTEGER) is
		external
			"C"
		end;

	x_fill_rectangle (dspl_pointer, wndw_obj, gc: POINTER; val1, val2,
					val3, val4: INTEGER) is
		external
			"C"
		alias
			"XFillRectangle"
		end;

	x_fill_polygon (dspl_pointer, wndw_obj, gc, arr_pt: POINTER; 
				count, val1, val2: INTEGER) is
		external
			"C"
		alias
			"XFillPolygon"
		end;

	c_fill_arc (dspl_pointer, wndw_obj, gc: POINTER; val1, val2,
                    val3, val4, angle1, angle2, angle3, orient: INTEGER) is
		external
			"C"
		end;

	x_fill_arc (dspl_pointer, wndw_obj, gc: POINTER; val1, val2,
                    val3, val4, angle1, angle2: INTEGER) is
		external
			"C"
		alias
			"XFillArc"
		end;

	x_draw_string (dspl_pointer, wndw_obj, gc: POINTER; val1,
					val2: INTEGER; t_name: ANY; count: INTEGER) is
		external
			"C"
		alias
			"XDrawString"
		end;

	c_draw_rectangle (dspl_pointer, wndw_obj, gc: POINTER; val1, val2,
                    val3, val4, orient: INTEGER) is
		external
			"C"
		end;

	x_draw_rectangle (dspl_pointer, wndw_obj, gc: POINTER; val1, val2,
					val3, val4: INTEGER) is
		external
			"C"
		alias
			"XDrawRectangle"
		end;

	c_free_points (arr_pt: POINTER) is
		external
			"C"
		end;

	x_draw_lines (dspl_pointer, wndw_obj, gc, arr_pt: POINTER; count,
					val: INTEGER) is
		external
			"C"
		alias
			"XDrawLines"
		end;

	c_put_point (arr_pt: POINTER; pos, x_val, y_val: INTEGER) is
		external
			"C"
		end;

	c_create_points (count: INTEGER): POINTER is
		external
			"C"
		end;

	x_draw_point (dspl_pointer, wndw_obj, gc: POINTER; x_val,
					y_val: INTEGER) is
		external
			"C"
		alias
			"XDrawPoint"
		end;

	x_draw_line (dspl_pointer, wndw_obj, gc: POINTER; val1, val2,
					val3, val4: INTEGER) is
		external
			"C"
		alias
			"XDrawLine"
		end;

	x_draw_image_string (dspl_pointer, wndw_obj, gc: POINTER; val1,
					val2: INTEGER; t_name: ANY; count: INTEGER) is
		external
			"C"
		alias
			"XDrawImageString"
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

	x_draw_arc (dspl_pointer, wndw_obj, gc: POINTER; val1, val2,
					val3, val4, angle1, angle2: INTEGER) is
		external
			"C"
		alias
			"XDrawArc"
		end;

	x_copy_area (dspl_pointer, res_x, wndw_obj, gc: POINTER; val1, val2,
                    bm_wdth, bm_hght, x_val, y_val: INTEGER) is
		external
			"C"
		alias
			"XCopyArea"
		end;

	x_copy_plane (dspl_pointer, res_x, wndw_obj, gc: POINTER; val1, val2,
					bm_wdth, bm_hght, x_val, y_val, val3: INTEGER) is
		external
			"C"
		alias
			"XCopyPlane"
		end;

end



--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
