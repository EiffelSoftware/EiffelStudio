indexing

	description: 
		"Abstract class of X Drawing functions.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	MEL_DRAWING

inherit

	MEL_DRAWING_CONSTANTS;

	MEL_DRAWABLE
		rename
			identifier as window
		end

feature -- Access

	valid_gc (gc: MEL_GC): BOOLEAN is
			-- Is the graphic context `gc' valid?
		do
			Result := gc /= Void and then
				display.handle = gc.display_handle
		ensure
			yes_if_not_void_and_good_display: Result implies gc /= Void 
					and then display.handle = gc.display_handle
		end;

	display: MEL_DISPLAY is
			-- Associated display
		deferred
		end;

	valid_window: BOOLEAN is
			-- Is the associated window valid?
		do
			Result := window /= default_pointer
		end;

feature -- Output

	clear_area (a_x, a_y, a_width, a_height: INTEGER; exposures: BOOLEAN) is
			-- Clear the area of upper left `a_x' and `a_y' with size
			-- `a_width' and `a_height'. Generate an expose event
			-- if `exposures' is True.
		require
			valid_window: valid_window;
			valid_size: a_width >= 0 and then a_height >= 0
		do
			x_clear_area (display.handle, window, 
					a_x, a_y, a_width, a_height, exposures);
		end;

	clear_window is
			-- Clear the window.
		require
			valid_window: valid_window
		do
			x_clear_window (display_handle, window);
		end;

	draw_point (gc: MEL_GC; x1, y1: INTEGER) is
			-- Draw a point at `x1', `y1'.
		require
			valid_window: valid_window;
			valid_gc: valid_gc (gc)
		do
			x_draw_point (gc.display_handle, window, gc.handle, x1, y1)
		end;

	draw_line (gc: MEL_GC; x1, y1: INTEGER; x2, y2: INTEGER) is
			-- Draw a line between `x1' `y1' to `x2' `y2'.
		require
			valid_window: valid_window;
			valid_gc: valid_gc (gc)
		do
			x_draw_line (gc.display_handle, window, gc.handle, 
				x1, y1, x2, y2)
		end;

	draw_string (gc: MEL_GC; x1, y1: INTEGER; a_string: STRING) is
			-- Draw `a_string' at position `x1' and `y1'. 
		require
			valid_window: valid_window;
			valid_string: a_string /= Void;
			valid_gc: valid_gc (gc)
		local
			ext: ANY
		do
			ext := a_string.to_c;	
			x_draw_string (gc.display_handle, window, gc.handle, 
				x1, y1, $ext, a_string.count)
		end;

	draw_image_string (gc: MEL_GC; x1, y1: INTEGER; a_string: STRING) is
			-- Draw `a_string' at position `x1' and `y1'. `draw_image_string'
			-- is the same as `draw_string' except the text string is filled
			-- with the background pixel from `gc'.
		require
			valid_window: valid_window;
			valid_string: a_string /= Void;
			valid_gc: valid_gc (gc)
		local
			ext: ANY
		do
			ext := a_string.to_c;	
			x_draw_image_string (gc.display_handle, window, gc.handle, 
				x1, y1, $ext, a_string.count)
		end;

	draw_rectangle (gc: MEL_GC; x1, y1: INTEGER; a_width, a_height: INTEGER) is
			-- Draw an outline of rectangle with upper-left coordinates
			-- `x1' `y1' with size `a_width' and `a_height'.
		require
			valid_window: valid_window;
			valid_gc: valid_gc (gc);
			valid_size: a_width >= 0 and then a_height >= 0
		do
			x_draw_rectangle (gc.display_handle, window, gc.handle, 
				x1, y1, a_width, a_height)
		end;

	fill_rectangle (gc: MEL_GC; x1, y1: INTEGER; a_width, a_height: INTEGER) is
			-- Fill a rectangle with upper-left coordinates
			-- `x1' `y1' with size `a_width' and `a_height'.
		require
			valid_window: valid_window;
			valid_gc: valid_gc (gc);
			valid_size: a_width >= 0 and then a_height >= 0
		do
			x_fill_rectangle (gc.display_handle, window, gc.handle,
				x1, y1, a_width, a_height)
		end;

	draw_arc (gc: MEL_GC; x1, y1: INTEGER; a_width, a_height: INTEGER;
				angle1, angle2: INTEGER) is
			-- Draw a circular or elliptical arc at coordinate `x1' and `y1'
			-- with `a_width' and `a_height' to specify the major and
			-- minor axises of the arc. `angle1' specifies the start of the
			-- arc relative to the three o'clock position from the center.
			-- `angle2' specifies the end of the are relative to the start
			-- of the arc. Both `angle1' and `angle2' are 64ths of
			-- of a degree (360 * 64 is a complete circle). Positive
			-- angles indicates counterclockwize direction.
		require
			valid_window: valid_window;
			valid_gc: valid_gc (gc);
			valid_size: a_width >= 0 and then a_height >= 0
		do
			x_draw_arc (gc.display_handle, window, gc.handle, 
				x1, y1, a_width, a_height, angle1, angle2)
		end;

	fill_arc (gc: MEL_GC; x1, y1: INTEGER; a_width, a_height: INTEGER;
				angle1, angle2: INTEGER) is
			-- Fill a circular or elliptical arc at coordinate `x1' and `y1'
			-- with `a_width' and `a_height' to specify the major and
			-- minor axises of the arc. `angle1' specifies the start of the
			-- arc relative to the three o'clock position from the center.
			-- `angle2' specifies the end of the are relative to the start
			-- of the arc. Both `angle1' and `angle2' are 64ths of
			-- of a degree (360 * 64 is a complete circle). Positive
			-- angles indicates counterclockwize direction.
		require
			valid_window: valid_window;
			valid_gc: valid_gc (gc);
			valid_size: a_width >= 0 and then a_height >= 0
		do
			x_fill_arc (gc.display_handle, window, gc.handle, 
				x1, y1, a_width, a_height, angle1, angle2)
		end;

	draw_lines (gc: MEL_GC; list: LIST [MEL_POINT]; is_coord_mode_origin: BOOLEAN) is
			-- Draw a polygon with list of points `list'. If `is_coord_mode_origin'
			-- then coordinate mode is CoordModeOrigin. Otherwize, the coordinate
			-- mode is CoordModePrevious.
		require
			valid_window: valid_window;
			valid_gc: valid_gc (gc);
			valid_list: list /= Void
		local
			list_count, index: INTEGER;
			c_xpoint_array: POINTER;
			an_item: MEL_POINT;
			cur: CURSOR	
		do
			list_count := list.count;
			c_xpoint_array := c_create_xpoints (list_count)
			from
				cur := list.cursor;
				index := 0;
				list.start	
			until
				list.after	
			loop
				an_item := list.item;
				c_put_xpoint (c_xpoint_array, index, an_item.x, an_item.y)
				list.forth;
				index := index + 1;
			end;
			list.go_to (cur);
			if is_coord_mode_origin then
				x_draw_lines (gc.display_handle, window, gc.handle, 
						c_xpoint_array, list_count, CoordModeOrigin)
			else
				x_draw_lines (gc.display_handle, window, gc.handle, 
						c_xpoint_array, list_count, CoordModePrevious)
			end;
			c_free_xpoints (c_xpoint_array)
		end;

	fill_polygon (gc: MEL_GC; list: LIST [MEL_POINT];
				a_shape: INTEGER; is_coord_mode_origin: BOOLEAN) is
			-- Fill a polygon with list of points `list' with shape `a_shape'. 
		 	-- If `is_coord_mode_origin' then coordinate mode is CoordModeOrigin. 
			-- Otherwize, the coordinate mode is CoordModePrevious.
		require
			valid_window: valid_window;
			valid_gc: valid_gc (gc);
			valid_list: list /= Void;
			valid_shape: a_shape >= Complex and then a_shape <= Convex
		local
			list_count, index: INTEGER;
			c_xpoint_array: POINTER;
			an_item: MEL_POINT;
			cur: CURSOR	
		do
			list_count := list.count;
			c_xpoint_array := c_create_xpoints (list_count)
			from
				cur := list.cursor;
				index := 0;
				list.start	
			until
				list.after	
			loop
				an_item := list.item;
				c_put_xpoint (c_xpoint_array, index, an_item.x, an_item.y)
				list.forth;
				index := index + 1;
			end;
			list.go_to (cur);
			if is_coord_mode_origin then
				x_fill_polygon (gc.display_handle, window, gc.handle, 
						c_xpoint_array, list_count, a_shape, CoordModeOrigin);
			else
				x_fill_polygon (gc.display_handle, window, gc.handle, 
						c_xpoint_array, list_count, a_shape, CoordModePrevious);
			end
			c_free_xpoints (c_xpoint_array)
		end;

feature {NONE} -- Implementation

	window: POINTER is
			-- Associated window
		deferred
		end

feature {NONE} -- Implementation

	c_create_xpoints (a_number: INTEGER): POINTER is
		external
			"C"
		end;

	c_put_xpoint (an_array: POINTER; a_pos, x1, y2: INTEGER) is
		external
			"C"
		end;

	c_free_xpoints (an_array: POINTER) is
		external
			"C"
		end;

	x_clear_window (a_display: POINTER; drawable: POINTER) is
		external
			"C [macro <X11/Xlib.h>] (Display *, Window) | <X11/Xlib.h>"
		alias
			"XClearWindow"
		end;

	x_clear_area (a_display: POINTER; w: POINTER; a_x, a_y, width, height: INTEGER;
				exposure: BOOLEAN) is
		external
			"C (Display *, Window, int, int,%
				%unsigned int, unsigned int, Bool) | <X11/Xlib.h>"
		alias
			"XClearArea"
		end;

	x_draw_point (a_display: POINTER; drawable: POINTER; gc_ptr: POINTER; x, y: INTEGER) is
		external
			"C (Display *, Drawable, GC, int, int) | <X11/Xlib.h>"
		alias
			"XDrawPoint"
		end;

	x_draw_line (a_display: POINTER; drawable: POINTER; gc_ptr: POINTER; x1, y1, x2, y2: INTEGER) is
		external
			"C (Display *, Drawable, GC, int, int, int, int) | <X11/Xlib.h>"
		alias
			"XDrawLine"
		end;

	x_draw_rectangle (a_display: POINTER; drawable: POINTER; gc_ptr: POINTER; x, y, width, height: INTEGER) is
		external
			"C (Display *, Drawable, GC, int, int, int, int) | <X11/Xlib.h>"
		alias
			"XDrawRectangle"
		end;

	x_draw_arc (a_display: POINTER; drawable: POINTER; gc_ptr: POINTER; x, y, width, height, angle1, angle2: INTEGER) is
		external
			"C (Display *, Drawable, GC, int, int, int, int, int, int) | <X11/Xlib.h>"
		alias
			"XDrawArc"
		end;

	x_fill_rectangle (a_display: POINTER; drawable: POINTER; gc_ptr: POINTER; x, y, width, height: INTEGER) is
		external
			"C (Display *, Drawable, GC, int, int, int, int) | <X11/Xlib.h>"
		alias
			"XFillRectangle"
		end;

	x_fill_arc (a_display: POINTER; drawable: POINTER; gc_ptr: POINTER; x, y, width, height, angle1, angle2: INTEGER) is
		external
			"C (Display *, Drawable, GC, int, int, int, int, int, int) | <X11/Xlib.h>"
		alias
			"XFillArc"
		end;

	x_draw_lines (a_display, w, gc, arr_pt: POINTER; count,
					val: INTEGER) is
		external
			"C (Display *, Drawable, GC, XPoint *, int, int) | <X11/Xlib.h>"
		alias
			"XDrawLines"
		end;

	x_fill_polygon (a_display, w, a_gc, arr_pt: POINTER;
				count, a_shape, a_mode: INTEGER) is
		external
			"C (Display *, Drawable, GC, XPoint *, int, int, int) | <X11/Xlib.h>"
		alias
			"XFillPolygon"
		end;

	x_draw_image_string (a_display, w, a_gc: POINTER; x1,
					y1: INTEGER; t_name: POINTER; count: INTEGER) is
		external
			"C (Display *, Drawable, GC, int, int, char *, int) | <X11/Xlib.h>"
		alias
			"XDrawImageString"
		end;

	x_draw_string (a_display, w, a_gc: POINTER; x1,
					y1: INTEGER; t_name: POINTER; count: INTEGER) is
		external
			"C (Display *, Drawable, GC, int, int, char *, int) | <X11/Xlib.h>"
		alias
			"XDrawString"
		end;

end -- class MEL_DRAWING


--|----------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel.
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

