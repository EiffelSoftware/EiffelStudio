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
			set_drawing_mode (drawing_mode_copy)
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
			gcvalues := C.c_gdk_gcvalues_struct_allocate
			C.gdk_gc_get_values (gc, gcvalues)
			Result := C.gdk_gcvalues_struct_line_width (gcvalues)
			c_free (gcvalues)
		end

	drawing_mode: INTEGER is
			-- Logical operation on pixels when drawing.
		local
			gdk_drawing_mode: INTEGER
		do
			gcvalues := C.c_gdk_gcvalues_struct_allocate
			C.gdk_gc_get_values (gc, gcvalues)
			gdk_drawing_mode := C.gdk_gcvalues_struct_function (gcvalues)
			c_free (gcvalues)

			if gdk_drawing_mode = C.Gdk_copy_enum then
				Result := drawing_mode_copy
			elseif gdk_drawing_mode = C.Gdk_xor_enum then
				Result := drawing_mode_xor
			elseif gdk_drawing_mode = C.Gdk_invert_enum then
				Result := drawing_mode_invert
			elseif gdk_drawing_mode = C.Gdk_and_enum then
				Result := drawing_mode_and
			elseif gdk_drawing_mode = C.Gdk_or_enum then
				Result := drawing_mode_or
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
			gcvalues := C.c_gdk_gcvalues_struct_allocate
			C.gdk_gc_get_values (gc, gcvalues)
			style := C.gdk_gcvalues_struct_line_style (gcvalues)
			c_free (gcvalues)
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
			c_free (color_struct)
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
			when drawing_mode_copy then
				C.gdk_gc_set_function (gc, C.Gdk_copy_enum)
			when drawing_mode_xor then
				C.gdk_gc_set_function (gc, C.Gdk_xor_enum)
			when drawing_mode_invert then
				C.gdk_gc_set_function (gc, C.Gdk_invert_enum)
			when drawing_mode_and then
				C.gdk_gc_set_function (gc, C.Gdk_and_enum)
			when drawing_mode_or then
				C.gdk_gc_set_function (gc, C.Gdk_or_enum)
			else
				check
					drawing_mode_existent: False
				end
			end
		end

	set_clip_area (an_area: EV_RECTANGLE) is
			-- Set an area to clip to.
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
			if drawable /= NULL then
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
		local
			temp_string: ANY
		do
			if drawable /= NULL then
				temp_string := a_text.to_c
				C.gdk_draw_string (
					drawable,
					internal_font_imp.c_object,
					gc,
					x,
					y,
					$temp_string
				)
			end
		end

	draw_text_top_left (x, y: INTEGER; a_text: STRING) is
			-- Draw `a_text' with top left corner at (`x', `y') using `font'.
		local
			temp_string: ANY
		do
			if drawable /= NULL then
				temp_string := a_text.to_c
				C.gdk_draw_string (
					drawable,
					internal_font_imp.c_object,
					gc,
					x,
					y + internal_font_ascent,
					$temp_string
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

	draw_arc (x, y, a_width, a_height: INTEGER; a_start_angle, an_aperture: REAL) is
			-- Draw a part of an ellipse bounded by top left (`x', `y') with
			-- size `a_width' and `a_height'.
			-- Start at `a_start_angle' and stop at `a_start_angle' + `an_aperture'.
			-- Angles are measured in radians.
		local
			corrected_start, corrected_aperture: REAL
			pi_nb: INTEGER
		do
			if drawable /= NULL then
				if a_height /= 0 then
					pi_nb := ((a_start_angle + Pi / 2) / Pi).floor
					corrected_start := a_start_angle - pi_nb * Pi
					if (math.modulo (a_start_angle, Pi)) /= Pi/2 then
						corrected_start := arc_tangent ((a_width * tangent (corrected_start))/a_height)
					end
					corrected_start := corrected_start + pi_nb * Pi
					corrected_aperture := an_aperture + a_start_angle
					pi_nb := ((corrected_aperture + Pi / 2) / Pi).floor
					corrected_aperture := corrected_aperture - pi_nb * Pi
					if (math.modulo (corrected_aperture, Pi)) /= Pi/2 then
						corrected_aperture := arc_tangent ((a_width * tangent (corrected_aperture))/a_height)
					end
					corrected_aperture := corrected_aperture - corrected_start + pi_nb * Pi
				end

				C.gdk_draw_arc (drawable, gc, 0, x,
					y, a_width,
					a_height, (radians_to_gdk_angle * corrected_start).truncated_to_integer,
					(radians_to_gdk_angle * corrected_aperture).truncated_to_integer)
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
				C.gdk_draw_rectangle (drawable, gc, 0, x, y, a_width - 1, a_height - 1)
			end
		end

	draw_ellipse (x, y, a_width, a_height: INTEGER) is
			-- Draw an ellipse bounded by top left (`x', `y') with
			-- size `a_width' and `a_height'.
		do
			if drawable /= NULL then
				C.gdk_draw_arc (drawable, gc, 0, x,
					y, a_width - 1,
					a_height - 1, 0, whole_circle)
			end
		end

	draw_polyline (points: ARRAY [EV_COORDINATE]; is_closed: BOOLEAN) is
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
			left, top, right, bottom: INTEGER
			x_start_arc, y_start_arc, x_end_arc, y_end_arc: INTEGER
			semi_width, semi_height: DOUBLE
			tang_start, tang_end: DOUBLE
			x_tmp, y_tmp: DOUBLE
		do
			left := x
			top := y
			right := left + a_width
			bottom := top + a_height
			                     
			semi_width := a_width / 2
			semi_height := a_height / 2
			tang_start := tangent (a_start_angle)
			tang_end := tangent (a_start_angle + an_aperture)
			                        
			x_tmp := semi_height / (sqrt (tang_start^2 + semi_height^2 / semi_width^2))
			y_tmp := semi_height / (sqrt (1 + semi_height^2 / (semi_width^2 * tang_start^2)))
			if sine (a_start_angle) > 0 then
				y_tmp := -y_tmp
			end
			if cosine (a_start_angle) < 0 then
				x_tmp := -x_tmp
			end
			x_start_arc := (x_tmp + left + semi_width).rounded
			y_start_arc := (y_tmp + top + semi_height).rounded
			
			x_tmp := semi_height / (sqrt (tang_end^2 + semi_height^2 / semi_width^2))
			y_tmp := semi_height / (sqrt (1 + semi_height^2 / (semi_width^2 * tang_end^2)))
			if sine (a_start_angle + an_aperture) > 0 then
				y_tmp := -y_tmp
			end
			if cosine (a_start_angle + an_aperture) < 0 then
				x_tmp := -x_tmp
			end
			x_end_arc := (x_tmp + left + semi_width).rounded
			y_end_arc := (y_tmp + top + semi_height).rounded
                        		
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

	fill_polygon (points: ARRAY [EV_COORDINATE]) is
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
		local
			corrected_start, corrected_aperture: REAL
			pi_nb: INTEGER
		do
			if drawable /= NULL then
				if height /= 0 then
					pi_nb := ((a_start_angle + Pi / 2) / Pi).floor
					corrected_start := a_start_angle - pi_nb * Pi
					if (math.modulo (a_start_angle, Pi)) /= Pi/2 then
						corrected_start := arc_tangent ((a_width * tangent (corrected_start))/a_height)
					end
					corrected_start := corrected_start + pi_nb * Pi
					corrected_aperture := an_aperture + a_start_angle
					pi_nb := ((corrected_aperture + Pi / 2) / Pi).floor
					corrected_aperture := corrected_aperture - pi_nb * Pi
					if (math.modulo (corrected_aperture, Pi)) /= Pi/2 then
						corrected_aperture := arc_tangent ((a_width * tangent (corrected_aperture))/a_height)
					end
					corrected_aperture := corrected_aperture - corrected_start + pi_nb * Pi
				end
				if tile /= Void then
					C.gdk_gc_set_fill (gc, C.Gdk_tiled_enum)
				end
				C.gdk_draw_arc (drawable, gc, 1, x,
					y, a_width,
					a_height, (corrected_start * radians_to_gdk_angle).rounded,
					(corrected_aperture * radians_to_gdk_angle).rounded)
				C.gdk_gc_set_fill (gc, C.Gdk_solid_enum)
			end
		end

feature {NONE} -- Implemention

	coord_array_to_gdkpoint_array (pts: ARRAY [EV_COORDINATE]): ARRAY [INTEGER] is
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
	
	interface: EV_DRAWABLE
	
	math: EV_FIGURE_MATH is
		once
			create Result
		end
		
	system_colormap: POINTER is
			-- Default system color map used for allocating colors.
		once
			Result := C.gdk_rgb_get_cmap
		end

invariant
	gc_not_void: is_usable implies gc /= NULL

end -- class EV_DRAWABLE_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
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

