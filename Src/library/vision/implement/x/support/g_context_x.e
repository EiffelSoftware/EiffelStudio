indexing

	description: 
		"General class which manipulates X Graphic Context";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class 
	G_CONTEXT_X

inherit

	MEL_GC
		rename
			make as make_gc,
			is_valid as is_gc_valid,
			handle as graphic_context,
			make_from_existing as gc_make_from_existing,
			set_arc_mode as mel_set_arc_style,	
			set_cap_style as mel_set_cap_style,
			set_fill_style as mel_set_fill_style,
			set_background_color as mel_set_gc_background_color,
			set_foreground_color as mel_set_gc_foreground_color,
			set_background as mel_set_gc_background,
			set_foreground as mel_set_gc_foreground,
			set_join_style as mel_set_join_style,
			set_line_style as mel_set_line_style,
			set_line_width as mel_set_line_width,
			set_stipple as mel_set_stipple,
			set_subwindow_mode as mel_set_subwindow_mode,
			set_tile as mel_set_tile,
			set_font as set_gc_font
		end

feature {NONE} -- Initialization

	create_gc (a_drawable: MEL_DRAWABLE) is
			-- Create a graphic context for `a_drawable'.
		require
			valid_drawable: a_drawable /= Void and then a_drawable.is_valid
	   	do
			make_gc (a_drawable);
			set_gc_values	
		end

feature -- Access

	is_drawable: BOOLEAN is
			-- Is the Current drawable valid?
		do
			Result := (window /= default_pointer)
		end;
	
	window: POINTER is
			-- Associated window	
		deferred
		end

feature -- Status setting

	set_clip (a_clip: CLIP) is
			-- Set a clip area.
		do
			if is_drawable then
				set_clip_rectangle (a_clip.upper_left.x, a_clip.upper_left.y, 
					a_clip.width, a_clip.height)
			end
		end;

	set_dash_pattern (a_dash: DASH) is
			-- Set pattern of dash lengths.
		require
			a_dash_exists: not (a_dash = Void);
			a_dash_valid: not a_dash.empty
		do
			set_dashes (a_dash, a_dash.offset)
		end;

	set_arc_style (arc_style: INTEGER) is
			-- Set style of filled arc.
		do
			if arc_style /= gc_arc_style then
				mel_set_arc_style (arc_style);
				gc_arc_style := arc_style
			end;
		end;

	set_cap_style (cap_style: INTEGER) is
			-- Specifies the appearance of ends of line.
		do
			if cap_style /= gc_cap_style then
				mel_set_cap_style (cap_style);
				gc_cap_style := cap_style
			end;
		end;

	set_fill_style (a_fill_style: INTEGER) is
			-- Set the style of fill.
		do
			if a_fill_style /= gc_fill_style then
				mel_set_fill_style (a_fill_style);
				gc_fill_style := a_fill_style;
			end;
		end;

	set_background_gc_color (a_color: COLOR) is
			-- Set background color of current GC to `pixel_value'.
		require
			valid_color: a_color /= Void 
		local
			a_color_id: POINTER;
			color_imp: COLOR_IMP
		do
			color_imp ?= a_color.implementation;
			color_imp.allocate_pixel;
			a_color_id := color_imp.identifier;
			if a_color_id /= gc_bg_color then
				mel_set_gc_background (color_imp);
				gc_bg_color := a_color_id;
			end
		end;

	set_foreground_gc_color (a_color: COLOR) is
			-- Set foreground color of current GC to `a_color'.
		require
			valid_color: a_color /= Void 
		local
			a_color_id: POINTER;
			color_imp: COLOR_IMP
		do
			color_imp ?= a_color.implementation;
			color_imp.allocate_pixel;
			a_color_id := color_imp.identifier;
			if a_color_id /= gc_fg_color then
				mel_set_gc_foreground (color_imp);
				gc_fg_color := a_color_id;
			end
		end; 

	set_drawing_font (font: FONT) is
			-- Set a font.
		require
			font_exists: not (font = Void)
		local
			font_implementation: FONT_IMP;
			drawing_font: POINTER
		do
			font_implementation ?= font.implementation;
			font_implementation.allocate_font;
			drawing_font := font_implementation.handle;
			if drawing_font /= gc_font then
				set_gc_font (font_implementation);
				gc_font := drawing_font
			end
		end;
	
	set_join_style (join_style: INTEGER) is
			-- Specifies type appearance of joints between consecutive lines.
		do
			if join_style /= gc_join_style then
				mel_set_join_style (join_style);
				gc_join_style := join_style
			end;
		end;

	set_line_style (line_style: INTEGER) is
			-- Set line style.
		do
			if line_style /= gc_line_style then
				mel_set_line_style (line_style);
				gc_line_style := line_style
			end;
		end;
	
	set_line_width (new_width: INTEGER) is
			-- Set line to be displayed with width of `new_width'.
		do
			if new_width /= gc_line_width then
				mel_set_line_width (new_width);
				gc_line_width := new_width
			end;
		end;
	
	set_logical_mode (a_mode: INTEGER) is
			-- Set drawing logical function to `a_mode'.
		do
			if a_mode /= gc_logical_mode then
				set_function (a_mode);
				gc_logical_mode := a_mode
			end;
		end; 

	set_no_clip is
			-- Remove all clip area.
		do
			if is_drawable then
				set_clip_mask (Void)
			end
		end;

	set_stipple (a_stipple: PIXMAP) is
			-- Set stipple used to fill figures
		require
			a_stipple_exists: not (a_stipple = Void);
			a_stipple_valid: a_stipple.is_valid
		local
			stipple_implementation: PIXMAP_IMP;
			id: POINTER
		do
			stipple_implementation ?= a_stipple.implementation;
			stipple_implementation.allocate_bitmap;
			id := stipple_implementation.bitmap.identifier;
			if id /= gc_stipple then	
				mel_set_stipple (stipple_implementation.bitmap)
				gc_stipple := id
			end
		end; 
	
	set_subwindow_mode (mode: INTEGER) is
			-- Set the subwindow mode.
		do
			if gc_subwindow_mode /= mode then
				mel_set_subwindow_mode (mode);
				gc_subwindow_mode := mode
			end;
		end;
	
	set_tile (a_tile: PIXMAP) is
			-- Set tile used to fill figures
		require
			a_tile_exists: not (a_tile = Void);
			a_tile_valid: a_tile.is_valid
		local
			tile_implementation: PIXMAP_IMP;
			id: POINTER
		do
			tile_implementation ?= a_tile.implementation;
			id := tile_implementation.identifier;
			if id /= gc_tile then	
				mel_set_tile (tile_implementation)
				gc_tile := id
			end
		end;

feature {NONE} -- Implementation

	set_gc_values is
		local
			def_screen: MEL_SCREEN
		do
			gc_arc_style 		:= -1;
			gc_cap_style 		:= -1;
			gc_fill_style 		:= -1;
			gc_join_style 		:= -1;
			gc_line_style 		:= -1;
			gc_line_width 		:= -1;
			gc_logical_mode 	:= -1;
			gc_subwindow_mode 	:= -1;
	
			def_screen := display.default_screen;
				-- Set the default background color of the GC to white
			gc_bg_color	:= def_screen.white_pixel.identifier;
			x_set_background (display_handle, graphic_context, gc_bg_color)
				-- Set the default foreground color of the GC to black
			gc_fg_color	:= def_screen.black_pixel.identifier;
			x_set_foreground (display_handle, graphic_context, gc_fg_color)
		end;

		-- Saved Gc values
	gc_arc_style: INTEGER;
	gc_subwindow_mode: INTEGER;
	gc_cap_style: INTEGER;
	gc_fill_style: INTEGER;
	gc_join_style: INTEGER;
	gc_line_style: INTEGER;
	gc_line_width: INTEGER;
	gc_logical_mode: INTEGER;
	gc_bg_color: POINTER;
	gc_fg_color: POINTER;
	gc_stipple: POINTER;
	gc_tile: POINTER;
	gc_font: POINTER;

end -- G_CONTEXT_X


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

