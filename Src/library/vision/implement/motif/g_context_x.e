
-- General class which manipulates X Graphic Context.

indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class G_CONTEXT_X

inherit

	GRAPHIC_R_X
		export
			{NONE} all
		end;

	BASIC_ROUTINES
		export
			{NONE} all
		end

feature 

	create_gc is
			-- Create X graphic context and get all information
			-- about current X window, current display and screen.
		local
			void_pointer: POINTER
		do
			graphic_context := x_create_gc (display_pointer, root_window_object, 0, void_pointer);
			set_gc_values;
		end;

	destroy_gc is
			-- Destroy current graphic context and initialize
			-- all corresponding attributes.
		do
			x_free_gc (display_pointer, graphic_context)
		end;

	
feature {NONE}

	display_pointer: POINTER;
			-- Pointer on current display

	graphic_context: POINTER;
			-- X object of current graphic context

	
feature 

	is_drawable: BOOLEAN is
			-- If the GC has not been created,
			--   create it and return true if a window X exists.
			--   return false if there's no window X.
			-- If there's a GC created,
			--   true if a window X exists, false else.
		local
			void_pointer: POINTER
		do
			Result := (window_object /= void_pointer)
		end;
	
feature {NONE}

	root_window_object: POINTER is
			-- X identifier of the root window of the screen.
		
		do
			Result := c_root_window (display_pointer)
		end; 

	screen: SCREEN_I is
			-- Screen of widget
		deferred
		ensure
			not (Result = Void)
		end;

	screen_object: POINTER is
			-- X object with which current graphic context
			-- is associated
		deferred
		end; 
	
feature 

	set_arc_style (arc_style: INTEGER) is
			-- Set style of filled arc.
		require
			arc_style >= 0;
			arc_style <= 1
		
		do
			if arc_style /= gc_arc_style then
				x_set_arc_mode (display_pointer, graphic_context, arc_style);
			end;
		end;

	set_cap_style (cap_style: INTEGER) is
			-- Specifies the appearance of ends of line.
		require
			cap_style >= 0;
			cap_style <= 3
		
		do
			if cap_style /= gc_cap_style then
				c_set_cap_style (display_pointer, graphic_context, cap_style);
			end;
		end; 

	set_clip (a_clip: CLIP) is
			-- Set a clip area.
		require
			a_clip_exists: not (a_clip = Void)
		
		do
			if is_drawable then
				c_set_clip_rectangles (display_pointer, graphic_context, a_clip.upper_left.x, a_clip.upper_left.y, a_clip.width, a_clip.height)
			end
		end;

	set_dash_pattern (a_dash: DASH) is
			-- Set pattern of dash lengths.
		require
			a_dash_exists: not (a_dash = Void);
			a_dash_valid: not a_dash.empty
		
		local
			an_array_of_char: STRING;
			ext_name: ANY
		do
			!! an_array_of_char.make (a_dash.count);
			from
				a_dash.start
			until
				a_dash.off
			loop
				an_array_of_char.extend (charconv (a_dash.item));
				a_dash.forth
			end;
			ext_name := an_array_of_char.to_c;
			x_set_dashes (display_pointer, graphic_context,
					a_dash.offset, $ext_name, a_dash.count)
		end;

	set_fill_style (a_fill_style: INTEGER) is
			-- Set the style of fill.
		
		do
			if a_fill_style /= gc_fill_style then
				x_set_fill_style (display_pointer, graphic_context, a_fill_style);
			end;
		end;

	
feature {NONE}

	set_gc_background (pixel_value: POINTER) is
			-- Set background color of current GC to `pixel_value'.
		
		do
			x_set_background (display_pointer, graphic_context, pixel_value)
		end;

	set_gc_foreground (pixel_value: POINTER) is
			-- Set foreground color of current GC to `pixel_value'.
		
		do
			x_set_foreground (display_pointer, graphic_context, pixel_value)
		end; 
	
feature 

	set_join_style (join_style: INTEGER) is
			-- Specifies type appearance of joints between consecutive lines.
		require
			join_style >= 0;
			join_style <= 2
		
		do
			if join_style /= gc_join_style then
				c_set_join_style (display_pointer, graphic_context, join_style);
			end;
		end;

	set_line_style (line_style: INTEGER) is
			-- Set line style.
		require
			line_style >= 0;
			line_style <= 2
		
		do
			if line_style /= gc_line_style then
				c_set_line_style (display_pointer, graphic_context, line_style);
			end;
		end;
	
feature {NONE}

	set_line_width (new_width: INTEGER) is
			-- Set line to be displayed with width of `new_width'.
		require
			width_large_enough: new_width >= 0
		
		do
			if new_width /= gc_line_width then
				c_set_line_width (display_pointer, graphic_context, new_width);
			end;
		end;
	
feature 

	set_logical_mode (a_mode: INTEGER) is
			-- Set drawing logical function to `a_mode'.
		require
			a_mode >= 0;
			a_mode <= 15
		
		do
			if a_mode /= gc_logical_mode then
				x_set_function (display_pointer, graphic_context, a_mode);
			end;
		end; 

	set_no_clip is
			-- Remove all clip area.
		
		do
			if is_drawable then
				c_set_no_clip (display_pointer, graphic_context)
			end
		end;

	set_stipple (a_stipple: PIXMAP) is
			-- Set stipple used to fill figures
		require
			a_stipple_exists: not (a_stipple = Void);
			a_stipple_valid: a_stipple.is_valid
		local
			a_stipple_implementation: PIXMAP_X	
		do
			a_stipple_implementation ?= a_stipple.implementation;
			x_set_stipple (display_pointer, graphic_context, a_stipple_implementation.resource_bitmap (screen))
		end; 
	
feature {NONE}

	set_subwindow_mode (mode: INTEGER) is
			-- Set the subwindow mode.
		do
			x_set_subwindow_mode (display_pointer, graphic_context, mode)
		end;
	
feature 

	set_tile (a_tile: PIXMAP) is
			-- Set tile used to fill figures
		require
			a_tile_exists: not (a_tile = Void);
			a_tile_valid: a_tile.is_valid
		local
			a_tile_implementation: PIXMAP_X	
		do
			a_tile_implementation ?= a_tile.implementation;
			x_set_tile (display_pointer, 
					graphic_context, 
					a_tile_implementation.resource_pixmap (screen))
		end;

feature {NONE} -- Access

	set_gc_values is
		do
			gc_arc_style 		:= -1;
			gc_cap_style 		:= -1;
			gc_fill_style 		:= -1;
			gc_join_style 		:= -1;
			gc_line_style 		:= -1;
			gc_line_width 		:= -1;
			gc_logical_mode 	:= -1;
		end;

    gc_arc_style: INTEGER;

	gc_cap_style: INTEGER;

	gc_fill_style: INTEGER;

	gc_join_style: INTEGER;

	gc_line_style: INTEGER;

	gc_line_width: INTEGER;

	gc_logical_mode: INTEGER;

	

feature {NONE}

	window_object: POINTER is
		deferred
		end

feature {NONE} -- External features

	x_create_gc (dspl_pointer, wnd_obj: POINTER; val1: INTEGER; val2: POINTER): POINTER is
		external
			"C"
		end;

	x_set_tile (dspl_pointer, gc, value: POINTER) is
		external
			"C"
		end;

	x_set_subwindow_mode (dspl_pointer, gc: POINTER; mode: INTEGER) is
		external
			"C"
		end;

	x_set_stipple (dspl_pointer, gc, value: POINTER) is
		external
			"C"
		end;

	c_set_no_clip (dspl_pointer, gc: POINTER) is
		external
			"C"
		end;

	x_set_function (dspl_pointer, gc: POINTER; mode: INTEGER) is
		external
			"C"
		end;

	c_set_line_width (dspl_pointer, gc: POINTER; width: INTEGER) is
		external
			"C"
		end;

	c_set_line_style (dspl_pointer, gc: POINTER; style: INTEGER) is
		external
			"C"
		end;

	c_set_join_style (dspl_pointer, gc: POINTER; style: INTEGER)  is
		external
			"C"
		end;

	x_set_foreground (dspl_pointer, gc, value: POINTER) is
		external
			"C"
		end;

	x_set_background (dspl_pointer, gc, value: POINTER) is
		external
			"C"
		end;

	x_set_fill_style (dspl_pointer, gc: POINTER; style: INTEGER) is
		external
			"C"
		end;

	x_set_dashes (dspl_pointer, gc: POINTER; offset: INTEGER; name: ANY;
					count: INTEGER) is
		external
			"C"
		end;

	c_set_clip_rectangles (dspl_pointer, gc: POINTER; x_val, y_val,
					wdth, hght: INTEGER) is
		external
			"C"
		end;

	c_set_cap_style (dspl_pointer, gc: POINTER; style: INTEGER) is
		external
			"C"
		end;

	x_set_arc_mode (dspl_pointer, gc: POINTER; style: INTEGER) is
		external
			"C"
		end;

	c_root_window (dspl_pointer: POINTER): POINTER is
		external
			"C"
		end;

	x_free_gc (dspl_pointer, gc: POINTER) is
		external
			"C"
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
