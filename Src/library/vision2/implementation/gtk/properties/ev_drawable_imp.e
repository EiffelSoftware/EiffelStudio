indexing
	description: "EiffelVision drawable. GTK implementation."
	status: "See notice at end of class"
	keywords: "figures, primitives, drawing, line, point, ellipse" 
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_DRAWABLE_IMP

inherit
	EV_DRAWABLE_I
		redefine
			interface
		end

	EV_DRAWABLE_CONSTANTS

	EV_C_UTIL

	PLATFORM

feature {NONE} -- Initialization

	init_default_values is
			-- Set default values. Call during initialization.
		do
			create background_color
			create foreground_color
			set_foreground_color (create {EV_COLOR}.make_with_rgb (0, 0, 0))
			set_background_color (create {EV_COLOR}.make_with_rgb (1, 1, 1))
			line_style := C.Gdk_line_solid_enum
			set_drawing_mode (Ev_drawing_mode_copy)
			set_line_width (1)
			create font
			internal_font_ascent := font.ascent
			internal_font_imp ?= font.implementation
		end

feature {EV_DRAWABLE_IMP} -- Implementation

	gc: POINTER
			-- Pointer to GdkGC struct.
			-- The graphics context applied to the primitives.
			-- Line style, width, colors, etc. are defined in here.
	
	gcvalues: POINTER
			-- Pointer to GdkGCValues struct.
			-- Is allocated during creation but has to be updated
			-- every time it is accessed.

	drawable: POINTER is
			-- Pointer to the GdkWindow of `c_object'.
		deferred
		end

	line_style: INTEGER
			-- Dash-style used when drawing lines.

	cap_style: INTEGER is
			-- Style used for drawing end of lines.
		do
			Result := C.Gdk_cap_butt_enum
		end

	join_style: INTEGER is
			-- Way in which lines are joined together.				
		do
			Result := C.Gdk_join_bevel_enum
		end

	gc_clip_area: EV_RECTANGLE
			-- Clip area currently used by `gc'.

	height: INTEGER is
			-- Needed by `draw_straight_line'.
		deferred
		end

	width: INTEGER is
			-- Needed by `draw_straight_line'.
		deferred
		end

feature -- Access

	font: EV_FONT
			-- Font used for drawing text.

	foreground_color: EV_COLOR
			-- Color used to draw primitives.
		
	background_color: EV_COLOR
			-- Color used for erasing of canvas.
			-- Default: white.

	line_width: INTEGER is
			-- Line thickness.
		do
			C.gdk_gc_get_values (gc, gcvalues)
			Result := C.gdk_gcvalues_struct_line_width (gcvalues)
		end

	drawing_mode: INTEGER is
			-- Logical operation on pixels when drawing.
		local
			gdk_drawing_mode: INTEGER
		do
			C.gdk_gc_get_values (gc, gcvalues)
			gdk_drawing_mode := C.gdk_gcvalues_struct_function (gcvalues)

			if gdk_drawing_mode = C.Gdk_copy_enum then
				Result := Ev_drawing_mode_copy
			elseif gdk_drawing_mode = C.Gdk_xor_enum then
				Result := Ev_drawing_mode_xor
			elseif gdk_drawing_mode = C.Gdk_invert_enum then
				Result := Ev_drawing_mode_invert
			elseif gdk_drawing_mode = C.Gdk_and_enum then
				Result := Ev_drawing_mode_and
			elseif gdk_drawing_mode = C.Gdk_or_enum then
				Result := Ev_drawing_mode_or
			else
				check
					drawing_mode_existent: False
				end
			end
		end

	clip_area: EV_RECTANGLE is
			-- Clip area used to clip drawing.
			-- If set to Void, no clipping is applied.
		do
			Result := clone (gc_clip_area)
		end

	tile: EV_PIXMAP
			-- Pixmap that is used to fill instead of background_color.
			-- If set to Void, `background_color' is used to fill.

	dashed_line_style: BOOLEAN is
			-- Are lines drawn dashed?
		local
			style: INTEGER
		do
			C.gdk_gc_get_values (gc, gcvalues)
			style := C.gdk_gcvalues_struct_line_style (gcvalues)
			Result := style = C.Gdk_line_on_off_dash_enum
		end

feature -- Status report

	is_drawable: BOOLEAN is
			-- Is the device drawable?
		do
			Result := drawable /= NULL
		end

feature -- Element change

	set_font (a_font: EV_FONT) is
			-- Set `font' to `a_font'.
		do
			font := clone (a_font)
			internal_font_ascent := font.ascent
			internal_font_imp ?= font.implementation
		end

	set_background_color (a_color: EV_COLOR) is
			-- Assign `a_color' to `background_color'.
		do
			background_color.copy (a_color)
		end

	set_foreground_color (a_color: EV_COLOR) is
			-- Assign `a_color' to `foreground_color'
		local
			color_struct: POINTER
			tempbool: BOOLEAN
		do
			foreground_color.copy (a_color)
			color_struct := C.c_gdk_color_struct_allocate
			C.set_gdk_color_struct_red (color_struct, a_color.red_16_bit)
			C.set_gdk_color_struct_green (color_struct, a_color.green_16_bit)
			C.set_gdk_color_struct_blue (color_struct, a_color.blue_16_bit)
			tempbool := C.gdk_colormap_alloc_color (system_colormap, color_struct, False, True)
			check
				color_has_been_allocated: tempbool
			end
			C.gdk_gc_set_foreground (gc, color_struct)
			C.c_gdk_color_struct_free (color_struct)
		end

	set_line_width (a_width: INTEGER) is
			-- Assign `a_width' to `line_width'.
		do
			C.gdk_gc_set_line_attributes (gc, a_width,
				line_style, cap_style, join_style)				
		end

	set_drawing_mode (a_mode: INTEGER) is
			-- Set drawing mode to `a_mode'.
		do
			check valid_drawing_mode (a_mode) end
			inspect
				a_mode
			when Ev_drawing_mode_copy then
				C.gdk_gc_set_function (gc, C.Gdk_copy_enum)
			when Ev_drawing_mode_xor then
				C.gdk_gc_set_function (gc, C.Gdk_xor_enum)
			when Ev_drawing_mode_invert then
				C.gdk_gc_set_function (gc, C.Gdk_invert_enum)
			when Ev_drawing_mode_and then
				C.gdk_gc_set_function (gc, C.Gdk_and_enum)
			when Ev_drawing_mode_or then
				C.gdk_gc_set_function (gc, C.Gdk_or_enum)
			else
				check
					drawing_mode_existent: False
				end
			end
		end

	set_clip_area (an_area: EV_RECTANGLE) is
			-- Set an area to clip to.
			-- Set to Void when no clipping should be applied.
		local
			rectangle_struct: POINTER
		do
			gc_clip_area := clone (an_area)
			rectangle_struct := C.c_gdk_rectangle_struct_allocate
			C.set_gdk_rectangle_struct_x (rectangle_struct, an_area.x)
			C.set_gdk_rectangle_struct_y (rectangle_struct, an_area.y)
			C.set_gdk_rectangle_struct_width (rectangle_struct, an_area.width)
			C.set_gdk_rectangle_struct_height (rectangle_struct, an_area.height)
			C.gdk_gc_set_clip_rectangle (gc, rectangle_struct)
			C.c_gdk_rectangle_struct_free (rectangle_struct)
		end

	remove_clip_area is
			-- Do not apply any clipping.
		do
			gc_clip_area := Void
			C.gdk_gc_set_clip_rectangle (gc, NULL)
		end

	set_tile (a_pixmap: EV_PIXMAP) is
			-- Set tile used to fill figures.
			-- Set to Void to use `background_color' to fill.
		local
			tile_imp: EV_PIXMAP_IMP
		do
			create tile
			tile.copy (a_pixmap)
			tile_imp ?= tile.implementation
			C.gdk_gc_set_tile (gc, tile_imp.drawable)
		end

	remove_tile is
			-- Do not apply a tile when filling.
		do
			tile := Void
		end

	enable_dashed_line_style is
			-- Draw lines dashed.
		do
			line_style := C.Gdk_line_on_off_dash_enum
			C.gdk_gc_set_line_attributes (gc, line_width,
				line_style, cap_style, join_style)
		end

	disable_dashed_line_style is
			-- Draw lines solid.
		do
			line_style := C.Gdk_line_solid_enum
			C.gdk_gc_set_line_attributes (gc, line_width,
				line_style, cap_style, join_style)
		end

feature -- Clearing operations

	clear is
			-- Erase `Current' with `background_color'.
		do
			clear_rectangle (0, 0, width, height)
		end

	clear_rectangle (x, y, a_width, a_height: INTEGER) is
			-- Erase rectangle specified with `background_color'.
		local
			tmp_fg_color: EV_COLOR
		do
			create tmp_fg_color
			tmp_fg_color.copy (foreground_color)
			set_foreground_color (background_color)
			C.gdk_draw_rectangle (drawable, gc, 1,
				x,
				y,
				a_width,
				a_height)
			set_foreground_color (tmp_fg_color)
		end

feature -- Drawing operations

	draw_point (x, y: INTEGER) is
			-- Draw point at (`x', `y').
		do
			if drawable /= NULL then
	 			C.gdk_draw_point (drawable, gc, x, y)
			end
		end

	draw_text (x, y: INTEGER; a_text: STRING) is
			-- Draw `a_text' with left of baseline at (`x', `y') using `font'.
		do
			if drawable /= NULL then
				C.gdk_draw_string (
					drawable,
					internal_font_imp.c_object,
					gc,
					x,
					y,
					eiffel_to_c (a_text)
				)
			end
		end

	draw_text_top_left (x, y: INTEGER; a_text: STRING) is
			-- Draw `a_text' with top left corner at (`x', `y') using `font'.
		do
			if drawable /= NULL then
				C.gdk_draw_string (
					drawable,
					internal_font_imp.c_object,
					gc,
					x,
					y + internal_font_ascent,
					eiffel_to_c (a_text)
				)
			end
		end

	draw_segment (x1, y1, x2, y2: INTEGER) is
			-- Draw line segment from (`x1', 'y1') to (`x2', 'y2').
		do
			if drawable /= NULL then
				C.gdk_draw_line (drawable, gc, x1, y1, x2, y2)
			end
		end

	draw_straight_line (x1, y1, x2, y2: INTEGER) is
			-- Draw infinite straight line through (`x1', 'y1') and (`x2', 'y2').
		local
			ax1, ax2, ay1, ay2, dx, dy: INTEGER
		do
			--| VB: Should work now. Draws lines that are too big.
			--| Catch worst cases like when `dy' approaches zero.
			--| This implementation is the same for Mswindows.
			dx := (x2 - x1)
			dy := (y2 - y1)
			if dy /= 0 then
				ax1 := x1 - ((dx / dy) * y2).rounded
				ax2 := x1 - ((dx / dy) * (y1 - height)).rounded
				ay1 := 0
				ay2 := height
			else
				ay1 := y1
				ay2 := y2
				ax1 := 0
				ax2 := width
			end
			draw_segment (ax1, ay1, ax2, ay2)
		end

	draw_arc (x, y, a_width, a_height: INTEGER; a_start_angle, an_aperture: REAL) is
			-- Draw a part of an ellipse bounded by top left (`x', `y') with
			-- size `a_width' and `a_height'.
			-- Start at `a_start_angle' and stop at `a_start_angle' + `an_aperture'.
			-- Angles are measured in radians.
		do
			if drawable /= NULL then
				C.gdk_draw_arc (drawable, gc, 0, x,
					y, a_width,
					a_height, (radians_to_gdk_angle * a_start_angle).truncated_to_integer,
					(radians_to_gdk_angle * an_aperture).truncated_to_integer)
			end
		end

	draw_pixmap (x, y: INTEGER; a_pixmap: EV_PIXMAP) is
			-- Draw `a_pixmap' with upper-left corner on (`x', `y').
		do
			draw_full_pixmap (x, y, a_pixmap, 0, 0, -1, -1)
		end

	draw_full_pixmap (x, y: INTEGER; a_pixmap: EV_PIXMAP; x_src, y_src, src_width, src_height: INTEGER) is
		local
			pixmap_imp: EV_PIXMAP_IMP
		do
			if drawable /= NULL then
				pixmap_imp ?= a_pixmap.implementation
				if pixmap_imp.mask /= NULL then
					C.gdk_gc_set_clip_mask (gc, pixmap_imp.mask)
					C.gdk_gc_set_clip_origin (gc, x, y)
				end
				C.gdk_draw_pixmap (drawable, gc,
					pixmap_imp.drawable,
					x_src, y_src, x, y, src_width, src_height)
				if pixmap_imp.mask /= NULL then
					C.gdk_gc_set_clip_mask (gc, NULL)
					C.gdk_gc_set_clip_origin (gc, 0, 0)
				end
			end
		end

	draw_sub_pixmap (x, y: INTEGER; a_pixmap: EV_PIXMAP; area: EV_RECTANGLE) is
			-- Draw `area' of `a_pixmap' with upper-left corner on (`x', `y').
		do
			draw_full_pixmap (x, y, a_pixmap, area.x, area.y, area.width, area.height)	
		end

	draw_rectangle (x, y, a_width, a_height: INTEGER) is
			-- Draw rectangle with upper-left corner on (`x', `y')
			-- with size `a_width' and `a_height'.
		do
			if drawable /= NULL then
				C.gdk_draw_rectangle (drawable, gc, 0, x, y, a_width, a_height)
			end
		end

	draw_ellipse (x, y, a_width, a_height: INTEGER) is
			-- Draw an ellipse bounded by top left (`x', `y') with
			-- size `a_width' and `a_height'.
		do
			if drawable /= NULL then
				C.gdk_draw_arc (drawable, gc, 0, x,
					y, a_width,
					a_height, 0, whole_circle)
			end
		end

	draw_polyline (points: ARRAY [EV_COORDINATES]; is_closed: BOOLEAN) is
			-- Draw line segments between subsequent points in
			-- `points'. If `is_closed' draw line segment between first
			-- and last point in `points'.
		local
			tmp: SPECIAL [INTEGER]
		do
			if drawable /= NULL then
				tmp := coord_array_to_gdkpoint_array (points).area
				if is_closed then
					C.gdk_draw_polygon (drawable, gc, 0, $tmp, points.count)
				else
					C.gdk_draw_lines (drawable, gc, $tmp, points.count)
				end
			end
		end

	draw_pie_slice (x, y, a_width, a_height: INTEGER; a_start_angle, an_aperture: REAL) is
			-- Draw a part of an ellipse bounded by top left (`x', `y') with
			-- size `a_width' and `a_height'.
			-- Start at `a_start_angle' and stop at `a_start_angle' + `an_aperture'.
			-- The arc is then closed by two segments through (`x', `y').
			-- Angles are measured in radians
		local
			x_start_arc, y_start_arc, x_end_arc, y_end_arc: INTEGER
		do
			x_start_arc := x + (a_width // 2) + (a_width // 2 * cosine (a_start_angle)).rounded
			y_start_arc := y + (a_height // 2) - (a_height // 2 * sine (a_start_angle)).rounded
			x_end_arc := x + (a_width // 2) + (a_width // 2 * cosine ((a_start_angle + an_aperture))).rounded
			y_end_arc := y + (a_height // 2) - (a_height // 2 * sine ((a_start_angle + an_aperture))).rounded
			draw_arc (x, y, a_width, a_height, a_start_angle, an_aperture)
			draw_segment (x + (a_width // 2), y + (a_height // 2), x_start_arc, y_start_arc)
			draw_segment (x + (a_width // 2), y + (a_height // 2), x_end_arc, y_end_arc)
		end

feature -- filling operations

	fill_rectangle (x, y, a_width, a_height: INTEGER) is
			-- Draw rectangle with upper-left corner on (`x', `y')
			-- with size `a_width' and `a_height'. Fill with `background_color'.
		do
			if drawable /= NULL then
				if tile /= Void then
					C.gdk_gc_set_fill (gc, C.Gdk_tiled_enum)
				end
				C.gdk_draw_rectangle (drawable, gc, 1, x, y, a_width, a_height)
				C.gdk_gc_set_fill (gc, C.Gdk_solid_enum)
			end
		end

	fill_ellipse (x, y, a_width, a_height: INTEGER) is
			-- Draw an ellipse bounded by top left (`x', `y') with
			-- size `a_width' and `a_height'.
			-- Fill with `background_color'.
		do
			if drawable /= NULL then
				if tile /= Void then
					C.gdk_gc_set_fill (gc, C.Gdk_tiled_enum)
				end
				C.gdk_draw_arc (drawable, gc, 1, x,
					y, a_width,
					a_height, 0, whole_circle)
				C.gdk_gc_set_fill (gc, C.Gdk_solid_enum)
			end
		end

	fill_polygon (points: ARRAY [EV_COORDINATES]) is
			-- Draw line segments between subsequent points in `points'.
			-- Fill all enclosed area's with `background_color'.
		local
			tmp: SPECIAL [INTEGER]
		do
			if drawable /= NULL then
				tmp := coord_array_to_gdkpoint_array (points).area
				if tile /= Void then
					C.gdk_gc_set_fill (gc, C.Gdk_tiled_enum)
				end
				C.gdk_draw_polygon (drawable, gc, 1, $tmp, points.count)
				C.gdk_gc_set_fill (gc, C.Gdk_solid_enum)
			end
		end

	fill_pie_slice (x, y, a_width, a_height: INTEGER; a_start_angle, an_aperture: REAL) is
			-- Draw a part of an ellipse bounded by top left (`x', `y') with
			-- size `a_width' and `a_height'.
			-- Start at `a_start_angle' and stop at `a_start_angle' + `an_aperture'.
			-- The arc is then closed by two segments through (`x', `y').
			-- Angles are measured in radians.
		do
			if drawable /= NULL then
				if tile /= Void then
					C.gdk_gc_set_fill (gc, C.Gdk_tiled_enum)
				end
				C.gdk_draw_arc (drawable, gc, 1, x,
					y, a_width,
					a_height, (a_start_angle * radians_to_gdk_angle).rounded,
					(an_aperture * radians_to_gdk_angle).rounded)
				C.gdk_gc_set_fill (gc, C.Gdk_solid_enum)
			end
		end

feature {NONE} -- Implemention

	coord_array_to_gdkpoint_array (pts: ARRAY [EV_COORDINATES]): ARRAY [INTEGER] is
			-- Low-level conversion.
		require
			pts_exists: pts /= Void
			equal_size: C.c_gdk_point_struct_size = integer_bits // 8
		local
			i, x, y: INTEGER
		do
			from
				create Result.make (0, pts.count - 1)
				i := 0
			until
				i >= pts.count
			loop
				x := pts.item (i + pts.lower).x \\ 32767
				y := pts.item (i + pts.lower).y \\ 32767
				Result.force (y * 65536 + x, i)				
				i := i + 1
			end
		ensure
			Result_exists: Result /= Void
			same_size: pts.count = Result.count
		end

	radians_to_gdk (ang: REAL): INTEGER is
			-- Converts `ang' (radians) to degrees * 64.
		do
			Result := ((ang / Pi) * 180 * 64).rounded
		end

feature {NONE} -- Implementation

	whole_circle: INTEGER is 23040
		-- Number of 1/64 th degrees in a full circle (360 * 64)
		
	radians_to_gdk_angle: INTEGER is 3667 -- 
			-- Multiply radian by this to get no of (1/64) degree segments.
		
	internal_font_ascent: INTEGER

	internal_font_imp: EV_FONT_IMP

	C: EV_C_EXTERNALS is
		once
			create Result
		end

	interface: EV_DRAWABLE

	system_colormap: POINTER is
			-- Default system color map used for allocating colors.
		once
			Result := C.gdk_colormap_get_system
		end

invariant
	gc_not_void: gc /= NULL
	gcvalues_not_void: gcvalues /= NULL

end -- class EV_DRAWABLE_IMP

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.15  2001/06/07 23:08:04  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.7.2.25  2001/06/05 22:42:47  king
--| Using clone instead of copy
--|
--| Revision 1.7.2.24  2001/06/04 17:21:23  rogers
--| We now use copy instead of ev_clone.
--|
--| Revision 1.7.2.23  2001/05/29 21:54:21  andrew
--| Corrected pie slice drawing routine to reflect the new bounding box implementation.
--|
--| Revision 1.7.2.22  2001/05/24 00:31:01  king
--| Accounted for ellipse changes
--|
--| Revision 1.7.2.21  2001/05/10 21:38:05  king
--| Updated clear_rectangle
--|
--| Revision 1.7.2.20  2001/04/23 22:13:23  king
--| Corrected clear_rectangle
--|
--| Revision 1.7.2.19  2001/04/11 17:51:12  xavier
--| `ev_clone' seems better suited than a simple clone (thanks Arnaud :)
--|
--| Revision 1.7.2.18  2001/04/11 16:12:02  xavier
--| When using descendants of EV_FONT, a precondition was violated in base, because we used to invoke `copy' on objects of different types.
--|
--| Revision 1.7.2.17  2000/11/30 19:28:03  king
--| Removed unused local variable
--|
--| Revision 1.7.2.16  2000/11/28 01:05:37  king
--| Implemented draw_sub_pixmap
--|
--| Revision 1.7.2.15  2000/10/27 16:54:39  manus
--| Removed undefinition of `set_default_colors' since now the one from EV_COLORIZABLE_IMP is
--| deferred.
--| However, there might be a problem with the definition of `set_default_colors' in the following
--| classes:
--| - EV_TITLED_WINDOW_IMP
--| - EV_WINDOW_IMP
--| - EV_TEXT_COMPONENT_IMP
--| - EV_LIST_ITEM_LIST_IMP
--| - EV_SPIN_BUTTON_IMP
--|
--| Revision 1.7.2.14  2000/09/12 19:03:55  king
--| Moved gtk_window up to ev_any_imp
--|
--| Revision 1.7.2.13  2000/09/06 18:54:32  oconnor
--| default_gdk_window:
--|  Commented out ref of GDK window and destroy of GTK window.
--|  This seems to destroy both.
--|  Since this is a once the extra window dosn't matter too much anyway.
--|
--| Revision 1.7.2.11  2000/09/06 18:08:37  oconnor
--| Fixed call to C function that ignored return value.
--|
--| Revision 1.7.2.10  2000/09/06 17:48:43  oconnor
--| Use new default_gdk_window feature instead of gdk_root_parent to try
--| to get a basis for visuals that will work better on workstations that
--| have different color depths for diverent windows.
--|
--| Revision 1.7.2.9  2000/08/23 00:32:27  king
--| Removed unused local
--|
--| Revision 1.7.2.8  2000/08/18 22:54:35  king
--| Now incrementing y instead of x, doh
--|
--| Revision 1.7.2.7  2000/08/18 19:04:13  king
--| Optimized draw_text routines
--|
--| Revision 1.7.2.6  2000/08/18 17:42:20  king
--| Corrected draw_text_at_top_left
--|
--| Revision 1.7.2.5  2000/08/16 15:10:01  brendel
--| Corrected error + cosmetic.
--|
--| Revision 1.7.2.4  2000/08/15 23:06:46  brendel
--| Added `draw_text_top_left'.
--|
--| Revision 1.7.2.3  2000/08/08 00:03:11  oconnor
--| Redefined set_default_colors to do nothing in EV_COLORIZABLE_IMP.
--|
--| Revision 1.7.2.2  2000/05/03 19:08:41  oconnor
--| mergred from HEAD
--|
--| Revision 1.14  2000/05/02 18:55:23  oconnor
--| Use NULL instread of Defualt_pointer in C code.
--| Use eiffel_to_c (a) instead of a.to_c.
--|
--| Revision 1.13  2000/04/14 16:36:50  oconnor
--| added clip mask to draw_pixmap
--|
--| Revision 1.12  2000/03/09 23:25:14  oconnor
--| inherit platform
--|
--| Revision 1.11  2000/02/22 18:39:36  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.10  2000/02/19 20:24:43  brendel
--| Updated copyright to 1986-2000.
--|
--| Revision 1.9  2000/02/16 23:01:21  king
--| Corrected name of clear_rect 2 clear_rectangle
--|
--| Revision 1.8  2000/02/14 11:40:28  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.7.2.1.2.43  2000/02/04 04:25:36  oconnor
--| released
--|
--| Revision 1.7.2.1.2.42  2000/01/27 19:29:31  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.7.2.1.2.41  2000/01/25 22:19:42  brendel
--| Removed _enum from drawing mode constants.
--|
--| Revision 1.7.2.1.2.40  2000/01/25 20:29:25  brendel
--| Fixed bug in drawing mode features.
--|
--| Revision 1.7.2.1.2.39  2000/01/24 23:54:19  oconnor
--| renamed EV_CLIP -> EV_RECTANGLE
--|
--| Revision 1.7.2.1.2.38  2000/01/22 00:59:08  brendel
--| Fixed bug in clear.
--| foreground_color is now an attribute.
--|
--| Revision 1.7.2.1.2.37  2000/01/21 20:12:12  brendel
--| Fixed bug in clear/clear_rect.
--| Fixed bug in set_font.
--|
--| Revision 1.7.2.1.2.36  2000/01/20 23:04:17  brendel
--| Fixed bug in non-filled features.
--| Formatting.
--|
--| Revision 1.7.2.1.2.35  2000/01/20 22:18:28  brendel
--| Implemented remove_tile and remove_clip_area.
--|
--| Revision 1.7.2.1.2.34  2000/01/20 21:38:44  brendel
--| Added features remove_tile and remove_clip_area.
--|
--| Revision 1.7.2.1.2.33  2000/01/20 00:13:03  brendel
--| Fixed bug in clear and clear_rect.
--|
--| Revision 1.7.2.1.2.32  2000/01/19 17:42:10  brendel
--| Restored color setting in filled figures.
--| Renamed fill_color to background_color.
--| Renamed line_color to foreground_color.
--|
--| Revision 1.7.2.1.2.31  2000/01/19 01:46:35  brendel
--| Fixed bug with color of filled figures.
--|
--| Revision 1.7.2.1.2.30  2000/01/18 18:08:45  brendel
--| Changed default values.
--|
--| Revision 1.7.2.1.2.29  2000/01/18 01:06:32  king
--| Undeferred feature C
--|
--| Revision 1.7.2.1.2.28  2000/01/17 23:33:58  brendel
--| Modified implementation so that nothing bad will happen, since
--| precondition `is_drawable' is removed from all features.
--|
--| Revision 1.7.2.1.2.27  2000/01/17 19:52:45  brendel
--| Removed useless put_string in draw_text.
--|
--| Revision 1.7.2.1.2.26  2000/01/17 17:42:13  brendel
--| Removed inheritance from EV_ANY_IMP.
--|
--| Revision 1.7.2.1.2.25  2000/01/17 17:36:49  brendel
--| Removed CVS conflict.
--|
--| Revision 1.7.2.1.2.24  2000/01/17 17:10:11  brendel
--| Moved signals to realize and unrealize from drawable to drawing area.
--|
--| Revision 1.7.2.1.2.23  2000/01/17 00:41:53  oconnor
--| Previous log message in error.
--| Added inheritance on EV_ANY_IMP.
--| reinstated maping agents.
--|
--| Revision 1.7.2.1.2.22  2000/01/17 00:25:44  oconnor
--| comments and formattinginterface/widgets/ev_widget.e
--|
--| Revision 1.7.2.1.2.21  2000/01/13 01:18:37  brendel
--| Changed 'y' with `y'.
--|
--| Revision 1.7.2.1.2.20  2000/01/11 19:24:54  king
--| Removed inheritence from ev_fontable_imp
--|
--| Revision 1.7.2.1.2.19  1999/12/22 20:18:07  king
--| Corrected assignment attempt to implementation
--|
--| Revision 1.7.2.1.2.18  1999/12/18 02:15:26  king
--| Implemented draw_text routine
--|
--| Revision 1.7.2.1.2.17  1999/12/17 23:15:00  oconnor
--| update for new names from EV_COLOR
--|
--| Revision 1.7.2.1.2.16  1999/12/15 19:23:28  king
--| Commented out realize_agents (not applicable with ev_screen)
--| Corrected set_fill/line color so they now allocate color from colormap
--|
--| Revision 1.7.2.1.2.15  1999/12/15 00:24:35  oconnor
--| c_gdk_color_struct_malloc is now c_gdk_rectangle_struct_allocate
--|
--| Revision 1.7.2.1.2.14  1999/12/13 19:48:48  oconnor
--| hack, commented out refs to height/width to compile
--|
--| Revision 1.7.2.1.2.13  1999/12/09 23:20:42  brendel
--| Added deferred features `width' and `height' needed by `draw_straight_line'.
--|
--| Revision 1.7.2.1.2.12  1999/12/09 19:05:00  oconnor
--| commented error regarding clip_area
--|
--| Revision 1.7.2.1.2.11  1999/12/09 18:23:57  brendel
--| Implemented `draw_stright_line' and `draw_pie_slice'.
--|
--| Revision 1.7.2.1.2.9  1999/12/09 00:16:08  brendel
--| Removed inheritance of GTK_ENUMS. We decided that no class inherits
--| anything from GEL.
--|
--| Revision 1.7.2.1.2.8  1999/12/08 19:44:12  brendel
--| Changed and implemented features to comply with EV_DRAWABLE_I.
--|
--| Revision 1.7.2.1.2.7  1999/12/08 01:29:04  brendel
--| Improved comments.
--|
--| Revision 1.7.2.1.2.6  1999/12/07 23:17:34  brendel
--| Changed EV_COORDINATES arg to x, y.
--| Changes EV_ANGLE to REAL (in radians).
--| Added draw_pie_slice and fill_pie_slice.
--| Removed `style' from *_arc.
--| Removed orientation from draw/fill_rectangle and draw/fill_ellipse.
--| Remaining to be implemented:
--|  - draw_figure_picture
--|  - draw_figure_picture
--|
--| in EV_DRAWABLE_IMP (GTK):
--|  - draw_text (because of font)
--|  - draw_straight_line
--|  - draw_pie_slice
--|
--| Revision 1.7.2.1.2.5  1999/12/07 18:32:26  brendel
--| Improved contracts on on_realize and on_unrealize.
--| Changed background_color to background_color.
--| Changed foreground_color to foreground_color.
--|
--| Revision 1.7.2.1.2.4  1999/12/06 17:53:56  brendel
--| Inherits from EV_FONTABLE_IMP.
--| Added realize and unrealize agents to control `gc'.
--| Modified creation sequence.
--|
--| Revision 1.7.2.1.2.3  1999/12/04 18:59:13  oconnor
--| moved externals into EV_C_EXTERNALS, accessed through EV_ANY_IMP.C
--|
--| Revision 1.7.2.1.2.2  1999/12/03 23:54:58  brendel
--| Changed signatures and comments to those in EV_DRAWABLE_I.
--| Started implementing some functions. Remaining to be implemented:
--|  - font
--|  - set_font
--|  - draw_text
--|  - draw_straight_line
--|  - draw_rectangle
--|  - draw_arc
--|  - fill_rectangle
--|  - fill_arc
--|
--| Revision 1.7.2.1.2.1  1999/11/24 17:29:46  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.6.2.2  1999/11/02 17:20:03  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
