note
	description: "EiffelVision drawable. GTK implementation."
	implementation_details: "[
			In Cairo, the coordinate system is not based on square pixels, but on the line
			between pixels (aka sample points).
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: figures, primitives, drawing, line, point, ellipse
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_DRAWABLE_IMP

inherit
	EV_DRAWABLE_I
		redefine
			interface
		end

feature {NONE} -- Initialization

	init_default_values
			-- Set default values. Call during initialization.
		local
			cr: like cairo_context
		do
			disable_dashed_line_style
			set_line_width (1)
			set_drawing_mode (drawing_mode_copy)
			cr := cairo_context
			if cr /= default_pointer then
				{CAIRO}.set_antialias (cr, {CAIRO}.antialias_none)
				{CAIRO}.set_line_cap (cr, {CAIRO}.line_cap_butt)
			end
			aliasing_mode := {CAIRO}.antialias_none
			line_cap_mode := {CAIRO}.line_cap_butt
		end

feature {EV_ANY_I} -- Implementation

	get_drawable: like cairo_context
			-- Bridge to `cairo_context` for backward compatibility.
		do
			Result := cairo_context
		end

	cairo_context: POINTER
			-- Pointer to the current Cairo context for `Current'.

	get_new_cairo_context
		local
			cr: like cairo_context
		do
			cr := cairo_context
			if not cr.is_default_pointer then
				release_cairo_context (cr)
				cr := default_pointer
				cairo_context := cr
			end
			get_cairo_context
		end

	get_cairo_context
		deferred
		end

	pre_drawing
		local
			cr: like cairo_context
		do
			cr := cairo_context
			{CAIRO}.save (cr)
		end

	post_drawing
		local
			cr: like cairo_context
		do
			cr := cairo_context
			if not cr.is_default_pointer then
				{CAIRO}.restore (cr)
				release_cairo_context (cr)
			end
		end

feature {EV_DRAWABLE_IMP} -- Implementation

	gc_clip_area: detachable EV_RECTANGLE
			-- Clip area currently used by `gc'.

	height: INTEGER
			-- Needed by `draw_straight_line'.
		deferred
		end

	width: INTEGER
			-- Needed by `draw_straight_line'.
		deferred
		end

feature -- Access

	font: EV_FONT
			-- Font used for drawing text.
		do
			if attached internal_font_imp as l_internal_font_imp then
				Result := l_internal_font_imp.attached_interface.twin
			else
				create Result
			end
		end

	foreground_color_internal: EV_COLOR
			-- Color used to draw primitives.
		local
			l_red, l_green, l_blue: INTEGER
		do
			if attached internal_foreground_color as l_internal_foreground_color then
				l_red := l_internal_foreground_color.red_8_bit
				l_green := l_internal_foreground_color.green_8_bit
				l_blue := l_internal_foreground_color.blue_8_bit
			else
					-- We default to black
			end
			create Result.make_with_8_bit_rgb (l_red, l_green, l_blue)
		end

	background_color_internal: EV_COLOR
			-- Color used for erasing of canvas.
			-- Default: white.
		local
			l_red, l_green, l_blue: INTEGER
		do
			if attached internal_background_color as l_internal_background_color then
				l_red := l_internal_background_color.red_8_bit
				l_green := l_internal_background_color.green_8_bit
				l_blue := l_internal_background_color.blue_8_bit
			else
					-- We default to white
				l_red := 255
				l_green := 255
				l_blue := 255
			end
			create Result.make_with_8_bit_rgb (l_red, l_green, l_blue)
		end

	line_width: INTEGER
			-- Line thickness.

	drawing_mode: INTEGER
			-- Logical operation on pixels when drawing.

	aliasing_mode: INTEGER_8
			-- Aliasing mode. Default: None

	line_cap_mode: INTEGER_8
			-- Line cap mode. Default: Butt

	clip_area: detachable EV_RECTANGLE
			-- Clip area used to clip drawing.
			-- If set to Void, no clipping is applied.
		do
			if attached gc_clip_area as l_gc_clip_area then
				Result := l_gc_clip_area.twin
			end
		end

	tile: detachable EV_PIXMAP
			-- Pixmap that is used to fill instead of background_color.
			-- If set to Void, `background_color' is used to fill.

	dashed_line_style: BOOLEAN
			-- <Precursor>

feature -- Element change

	set_font (a_font: EV_FONT)
			-- Set `font' to `a_font'.
		do
			if attached {EV_FONT_IMP} a_font.implementation as l_font_imp then
				internal_font_imp := l_font_imp
			else
				check False end
			end
		end

	set_background_color (a_color: EV_COLOR)
			-- Assign `a_color' to `background_color'.
		local
			l_internal_background_color: detachable like internal_background_color
		do
			l_internal_background_color := internal_background_color
			if l_internal_background_color = Void then
				create l_internal_background_color.make_with_8_bit_rgb (255, 255, 255)
				internal_background_color := l_internal_background_color
			end
			if not l_internal_background_color.is_equal (a_color) then
				l_internal_background_color.set_red_with_8_bit (a_color.red_8_bit)
				l_internal_background_color.set_green_with_8_bit (a_color.green_8_bit)
				l_internal_background_color.set_blue_with_8_bit (a_color.blue_8_bit)
				-- TODO check the following.
				-- internal_set_color (False, a_color.red_16_bit, a_color.green_16_bit, a_color.blue_16_bit)
				internal_set_color (False, a_color.red, a_color.green, a_color.blue)
			end
		end

	set_foreground_color (a_color: EV_COLOR)
			-- Assign `a_color' to `foreground_color'
		local
			l_internal_foreground_color: detachable like internal_foreground_color
		do
			l_internal_foreground_color := internal_foreground_color
			if l_internal_foreground_color = Void then
				create l_internal_foreground_color
				internal_foreground_color := l_internal_foreground_color
			end
			if not l_internal_foreground_color.is_equal (a_color) then
				l_internal_foreground_color.set_red_with_8_bit (a_color.red_8_bit)
				l_internal_foreground_color.set_green_with_8_bit (a_color.green_8_bit)
				l_internal_foreground_color.set_blue_with_8_bit (a_color.blue_8_bit)
				-- TODO cehck the following.
				-- internal_set_color (True, a_color.red_16_bit, a_color.green_16_bit, a_color.blue_16_bit)
				internal_set_color (True, a_color.red, a_color.green, a_color.blue)
			end
		end

	set_line_width (a_width: INTEGER)
			-- Assign `a_width' to `line_width'.
		do
			if cairo_context /= default_pointer then
				{CAIRO}.set_line_width (cairo_context, a_width)
			end
			line_width := a_width
		end

	set_drawing_mode (a_mode: INTEGER)
			-- Set drawing mode to `a_mode'.
		do
			if cairo_context /= default_pointer then
				{CAIRO}.set_operator (cairo_context, cairo_drawing_mode (a_mode))
			end
				-- Store set drawing mode.
			drawing_mode := a_mode
		end

	cairo_drawing_mode (a_drawing_mode: INTEGER): INTEGER_8
			-- Convert a vision drawing mode into the best cairo one.
		do
				-- Unfortunately there is no one to one mapping except for
				-- {EV_DRAWABLE_CONSTANTS}.drawing_mode_copy and
				-- {EV_DRAWABLE_CONSTANTS}.drawing_mode_and. All the other
				-- modes are approximation.
			inspect
				a_drawing_mode
			when {EV_DRAWABLE_CONSTANTS}.drawing_mode_copy then
				Result := {CAIRO}.operator_over
			when {EV_DRAWABLE_CONSTANTS}.drawing_mode_and then
				Result := {CAIRO}.operator_multiply
			when {EV_DRAWABLE_CONSTANTS}.drawing_mode_xor then
				Result := {CAIRO}.operator_xor
			when {EV_DRAWABLE_CONSTANTS}.drawing_mode_invert then
				Result := {CAIRO}.operator_exclusion
			when {EV_DRAWABLE_CONSTANTS}.drawing_mode_or then
				Result := {CAIRO}.operator_atop
			else
				check
					drawing_mode_exists: False
				end
			end
		end

	set_clip_area (an_area: EV_RECTANGLE)
			-- Set an area to clip to.
		local
			l_drawable: POINTER
		do
			get_cairo_context
			l_drawable := cairo_context
			if l_drawable /= default_pointer then
				gc_clip_area := an_area.twin
				{CAIRO}.rectangle (l_drawable,
					an_area.x + device_x_offset + 0.5,
					an_area.y + device_y_offset + 0.5,
					an_area.width,
					an_area.height)
				{CAIRO}.clip (l_drawable)
				release_cairo_context (l_drawable)
			else
				check has_drawable: False end
			end
		end

	set_clip_region (a_region: EV_REGION)
			-- Set a region to clip to.
		do
			check Implemented: False end
		end

	remove_clipping
			-- Do not apply any clipping.
		local
			l_drawable: POINTER
		do
			gc_clip_area := Void
			get_cairo_context
			l_drawable := cairo_context
			if l_drawable /= default_pointer then
				{CAIRO}.reset_clip (l_drawable)
				release_cairo_context (l_drawable)
			else
				check has_drawble: False end
			end
		end

	set_tile (a_pixmap: EV_PIXMAP)
			-- Set tile used to fill figures.
			-- Set to Void to use `background_color' to fill.
		local
			tile_imp: detachable EV_PIXMAP_IMP
			l_tile: like tile
		do
			create l_tile
			tile := l_tile
			l_tile.copy (a_pixmap)
			tile_imp ?= l_tile.implementation
			check tile_imp /= Void end
		end

	remove_tile
			-- Do not apply a tile when filling.
		do
			tile := Void
		end

	enable_dashed_line_style
			-- Draw lines dashed.
		do
			dashed_line_style := True
			if cairo_context /= default_pointer then
				{CAIRO}.set_dashed_line_style (cairo_context, True)
			end
		end

	disable_dashed_line_style
			-- Draw lines solid.
		do
			dashed_line_style := False
			if cairo_context /= default_pointer then
				{CAIRO}.set_dashed_line_style (cairo_context, False)
			end
		end

	set_anti_aliasing (value: BOOLEAN)
			-- <Precursor>
		do
				-- TODO: provide implementation.
		end

feature -- Clearing operations

	clear
			-- Erase `Current' with `background_color'.
		do
			clear_rectangle (0, 0, width, height)
		end

	clear_rectangle (x, y, a_width, a_height: INTEGER)
			-- Erase rectangle specified with `background_color'.
		local
			l_drawable: POINTER
		do
			pre_drawing
			l_drawable := cairo_context
			if l_drawable /= default_pointer then
				if attached internal_background_color as l_bg_color then
					{CAIRO}.set_source_rgb (l_drawable, l_bg_color.red, l_bg_color.green, l_bg_color.blue)
				else
						-- White
					{CAIRO}.set_source_rgb (l_drawable, 1.0, 1.0, 1.0)
				end
				{CAIRO}.rectangle (l_drawable, x + device_x_offset + 0.5, y + device_y_offset + 0.5, a_width, a_height)
				{CAIRO}.fill (l_drawable)
			end
			post_drawing
		end

feature -- Drawing operations

	draw_point (x, y: INTEGER)
			-- Draw point at (`x', `y').
		do
			draw_segment (x, y, x + 1, y + 1)
		end

	draw_text (x, y: INTEGER; a_text: READABLE_STRING_GENERAL)
			-- Draw `a_text' with left of baseline at (`x', `y') using `font'.
		do
			draw_text_internal (x, y, a_text, True, -1, 0)
		end

	draw_rotated_text (x, y: INTEGER; angle: REAL; a_text: READABLE_STRING_GENERAL)
			-- Draw rotated text `a_text' with left of baseline at (`x', `y') using `font'.
			-- Rotation is number of radians counter-clockwise from horizontal plane.
		do
			draw_text_internal (x, y, a_text, True, -1, angle)
		end

	draw_ellipsed_text (x, y: INTEGER; a_text: READABLE_STRING_GENERAL; clipping_width: INTEGER)
			-- Draw `a_text' with left of baseline at (`x', `y') using `font'.
			-- Text is clipped to `clipping_width' in pixels and ellipses are displayed
			-- to show truncated characters if any.
		do
			draw_text_internal (x, y, a_text, True, clipping_width, 0.0)
		end

	draw_ellipsed_text_top_left (x, y: INTEGER; a_text: READABLE_STRING_GENERAL; clipping_width: INTEGER)
			-- Draw `a_text' with top left corner at (`x', `y') using `font'.
			-- Text is clipped to `clipping_width' in pixels and ellipses are displayed
			-- to show truncated characters if any.
		do
			draw_text_internal (x, y, a_text, False, clipping_width, 0.0)
		end

	draw_text_top_left (x, y: INTEGER; a_text: READABLE_STRING_GENERAL)
			-- Draw `a_text' with top left corner at (`x', `y') using `font'.
		do
			draw_text_internal (x, y, a_text, False, -1, 0.0)
		end

	draw_text_internal (x, y: INTEGER; a_text: READABLE_STRING_GENERAL; draw_from_baseline: BOOLEAN; a_width: INTEGER; a_angle: REAL)
			-- Draw `a_text' at (`x', `y') using `font' at an `a_angle' expressed in radians counter-clockwise from horizontal plane.
			-- If `draw_from_baseline' then (`x', `y') is the baseline coordinates, otherwise it is the top-left coordinates.
			-- If `a_width' is non-negative, then `a_text' is clipped at `a_width' units.
		local
			a_cs: EV_GTK_C_STRING
			a_pango_layout, l_pango_iter: POINTER
			l_x, l_y: REAL_64
			l_ellipsize_symbol: POINTER
			l_drawable: POINTER
		do
			pre_drawing
			l_drawable := cairo_context
			if l_drawable /= default_pointer then
					-- Set x_orig and y_orig to be the device translated values which must be used for the rest of the routine.
				l_x := x + device_x_offset
				l_y := y + device_y_offset

				a_pango_layout := {PANGO}.cairo_create_layout (l_drawable)

				a_cs := App_implementation.c_string_from_eiffel_string (a_text)
				{PANGO}.layout_set_text (a_pango_layout, a_cs.item, a_cs.string_length)
				if internal_font_imp /= Void then
					{PANGO}.layout_set_font_description (a_pango_layout, internal_font_imp.font_description)
				end

				if a_width >= 0 then
						-- We need to perform ellipsizing on text if available, otherwise we clip.
					l_ellipsize_symbol := pango_layout_set_ellipsize_symbol
					{PANGO}.layout_set_ellipsize_call (l_ellipsize_symbol, a_pango_layout, 3)
					{PANGO}.layout_set_width (a_pango_layout, a_width * {PANGO}.scale)
				end

				if a_angle /= 0.0 then
					{CAIRO}.translate (l_drawable, l_x, l_y)

						-- Minus angle because Vision is counter-clockwise, and Cairo clockwise.
					{CAIRO}.rotate (l_drawable, -a_angle)

					if draw_from_baseline  then
						l_pango_iter := {PANGO}.layout_get_iter (a_pango_layout)
						{CAIRO}.move_to (l_drawable, 0, -({PANGO}.layout_iter_get_baseline (l_pango_iter) / {PANGO}.scale))
						{PANGO}.layout_iter_free (l_pango_iter)
					end
				else
					if draw_from_baseline  then
						l_pango_iter := {PANGO}.layout_get_iter (a_pango_layout)
						l_y := l_y -({PANGO}.layout_iter_get_baseline (l_pango_iter) / {PANGO}.scale)
						{PANGO}.layout_iter_free (l_pango_iter)
					end
					{CAIRO}.translate (l_drawable, l_x, l_y)
				end

				{PANGO}.cairo_show_layout (l_drawable, a_pango_layout)

					-- Free allocated resources
				{GTK2}.g_object_unref (a_pango_layout)

			end
			post_drawing
		end

	pango_layout_set_ellipsize_symbol: POINTER
			-- Symbol for `pango_layout_set_ellipsize'.
		once
			Result := app_implementation.symbol_from_symbol_name ("pango_layout_set_ellipsize")
		end

	draw_segment (x1, y1, x2, y2: INTEGER)
			-- Draw line segment from (`x1', 'y1') to (`x2', 'y2').
		local
			l_drawable: POINTER
		do
			pre_drawing
			l_drawable := cairo_context
			if l_drawable /= default_pointer then
				{CAIRO}.move_to (l_drawable, x1 + device_x_offset + 0.5, y1 + device_y_offset + 0.5)
				{CAIRO}.line_to (l_drawable, x2 + device_x_offset + 0.5, y2 + device_y_offset + 0.5)
				{CAIRO}.stroke (l_drawable)
			end
			post_drawing
		end

	draw_arc (x, y, a_width, a_height: INTEGER; a_start_angle, an_aperture: REAL)
			-- Draw a part of an ellipse bounded by top left (`x', `y') with
			-- size `a_width' and `a_height'.
			-- Start at `a_start_angle' and stop at `a_start_angle' + `an_aperture'.
			-- Angles are measured in radians.
		do
			draw_ellipse_internal (x, y, a_width, a_height, a_start_angle, an_aperture, False, False)
		end


	draw_sub_pixel_buffer (a_x, a_y: INTEGER; a_pixel_buffer: EV_PIXEL_BUFFER; area: EV_RECTANGLE)
			-- Draw `area' of `a_pixel_buffer' with upper-left corner on (`a_x', `a_y').
		local
			l_drawable: POINTER
		do
			pre_drawing
			l_drawable := cairo_context
			if l_drawable /= default_pointer and then attached {EV_PIXEL_BUFFER_IMP} a_pixel_buffer.implementation as l_pixel_buffer_imp then
				{GDK_CAIRO}.set_source_pixbuf (l_drawable, l_pixel_buffer_imp.gdk_pixbuf, area.x, area.y)
				{CAIRO}.rectangle (l_drawable, a_x + device_x_offset + 0.5, a_y + device_y_offset + 0.5, area.width, area.height)
				{CAIRO}.fill (l_drawable)

			end
			post_drawing
		end

	supports_pixbuf_alpha: BOOLEAN
			-- Does drawable support direct GdkPixbuf alpha blending?
		do
				-- For the moment EV_SCREEN doesn't support direct alpha blending.
			Result := True
		end

	draw_pixmap (x, y: INTEGER; a_pixmap: EV_PIXMAP)
			-- Draw `a_pixmap' with upper-left corner on (`x', `y').
		do
			draw_full_pixmap (x, y, a_pixmap, 0, 0, a_pixmap.width, a_pixmap.height)
		end

	draw_full_pixmap (x, y: INTEGER; a_pixmap: EV_PIXMAP; x_src, y_src, src_width, src_height: INTEGER)
		local
			l_drawable: POINTER
		do
			if attached {EV_PIXMAP_IMP} a_pixmap.implementation as l_pixmap_imp then
				pre_drawing
				l_drawable := cairo_context
				if l_drawable /= default_pointer then
					{CAIRO}.set_source_surface (l_drawable, l_pixmap_imp.cairo_surface, x - x_src, y - y_src)
					{CAIRO}.rectangle (l_drawable, x + device_x_offset + 0.5, y + device_y_offset + 0.5, src_width, src_height)
					{CAIRO}.fill (l_drawable)

				end
				post_drawing
			end
		end

	sub_pixmap (area: EV_RECTANGLE): EV_PIXMAP
			-- Pixmap region of `Current' represented by rectangle `area'
		local
			pix_imp: detachable EV_PIXMAP_IMP
			a_pix: POINTER
		do
			create Result
			pix_imp ?= Result.implementation
			check pix_imp /= Void then end
			a_pix := pixbuf_from_drawable_at_position (area.x, area.y, 0, 0, area.width, area.height)
			pix_imp.set_pixmap_from_pixbuf (a_pix)
			{GTK2}.g_object_unref (a_pix)
		end

	draw_sub_pixmap (x, y: INTEGER; a_pixmap: EV_PIXMAP; area: EV_RECTANGLE)
			-- Draw `area' of `a_pixmap' with upper-left corner on (`x', `y').
		do
			draw_full_pixmap (x, y, a_pixmap, area.x, area.y, area.width, area.height)
		end

	draw_rectangle (x, y, a_width, a_height: INTEGER)
			-- Draw rectangle with upper-left corner on (`x', `y')
			-- with size `a_width' and `a_height'.
		do
			draw_rectangle_internal (x, y, a_width, a_height, False)
		end

	draw_ellipse (x, y, a_width, a_height: INTEGER)
			-- Draw an ellipse bounded by top left (`x', `y') with
			-- size `a_width' and `a_height'.
		do
			draw_ellipse_internal (x, y, a_width, a_height, 0, 2 * {DOUBLE_MATH}.pi, True, False)
		end

	draw_ellipse_internal (x, y, a_width, a_height: INTEGER; a_start_angle, an_aperture: REAL_64; a_close, a_fill: BOOLEAN)
			-- Draw an ellipse bounded by top left (`x', `y') with
			-- size `a_width' and `a_height'.
			-- Fill ellipse if `a_fill'.
		local
			l_xc, l_yc, l_radius, l_y_scale: REAL_64
			l_close: BOOLEAN
			l_drawable: POINTER
		do
			if (a_width > 0 and a_height > 0 ) then
				pre_drawing
--				get_cairo_context
				l_drawable := cairo_context
				if l_drawable /= default_pointer then
--					pre_drawing_operation (l_drawable)

					l_close := a_close and then an_aperture /= (2 * {DOUBLE_MATH}.Pi)

					l_xc := x + (a_width / 2) + device_x_offset
					l_yc := y + (a_height / 2) + device_y_offset

					l_radius := a_width / 2
					if a_width /= a_height then
						l_y_scale := a_height / a_width
						{CAIRO}.scale (l_drawable, 1.0, l_y_scale)
						l_yc := (l_yc - device_y_offset) / l_y_scale + device_y_offset
					end

					if l_close then
						{CAIRO}.move_to (l_drawable, l_xc, l_yc)
					end

					{CAIRO}.arc_negative (l_drawable, l_xc, l_yc, a_height / 2, -a_start_angle, - (a_start_angle + an_aperture))
					if a_fill then
						{CAIRO}.stroke_preserve (l_drawable)
						{CAIRO}.fill (l_drawable)
					end

					if l_close then
						{CAIRO}.close_path (l_drawable)
					end
					{CAIRO}.stroke (l_drawable)

					if a_width /= a_height then
						{CAIRO}.scale (l_drawable, 1.0, 1.0)
					end
				end
				post_drawing
			end
		end

	draw_polyline (points: ARRAY [EV_COORDINATE]; is_closed: BOOLEAN)
			-- Draw line segments between subsequent points in
			-- `points'. If `is_closed' draw line segment between first
			-- and last point in `points'.
		do
			draw_polyline_internal (points, is_closed, False)
		end

	draw_polyline_internal (points: ARRAY [EV_COORDINATE]; is_closed, is_filled: BOOLEAN)
			-- Draw line segments between subsequent points in
			-- `points'. If `is_closed' draw line segment between first
			-- and last point in `points'.
		local
			i, l_count: INTEGER
			l_drawable: POINTER
		do
			if not points.is_empty then
				pre_drawing
				l_drawable := cairo_context
				if l_drawable /= default_pointer then
					from
						l_count := points.count
						{CAIRO}.move_to (l_drawable, points [1].x_precise + 0.5, points [1].y_precise + 0.5)
						i := 2
					until
						i > l_count
					loop
						{CAIRO}.line_to (l_drawable, points [i].x_precise + 0.5, points [i].y_precise + 0.5)
						i := i + 1
					end
					if is_closed then
						{CAIRO}.close_path (l_drawable)
					end
					{CAIRO}.stroke (l_drawable)

				end
				post_drawing
			end
		end

	draw_pie_slice (x, y, a_width, a_height: INTEGER; a_start_angle, an_aperture: REAL)
			-- Draw a part of an ellipse bounded by top left (`x', `y') with
			-- size `a_width' and `a_height'.
			-- Start at `a_start_angle' and stop at `a_start_angle' + `an_aperture'.
			-- The arc is then closed by two segments through (`x', `y').
			-- Angles are measured in radians
		do
			draw_ellipse_internal (x, y, a_width, a_height, a_start_angle, an_aperture, True, False)
		end

feature -- filling operations

	fill_rectangle (x, y, a_width, a_height: INTEGER)
			-- Draw rectangle with upper-left corner on (`x', `y')
		do
			draw_rectangle_internal (x, y, a_width, a_height, True)
		end

	draw_rectangle_internal (x, y, a_width, a_height: INTEGER; a_fill: BOOLEAN)
			-- Draw rectangle with upper-left corner on (`x', `y')
		local
			l_drawable: POINTER
		do
			if a_width > 0 and then a_height > 0 then
				pre_drawing
				l_drawable := cairo_context
				if l_drawable /= default_pointer then
						-- If width or height are zero then nothing will be rendered.
					{CAIRO}.rectangle (l_drawable, x + device_x_offset + 0.5, y + device_y_offset + 0.5, a_width - line_width, a_height - line_width)
					if a_fill then
						{CAIRO}.stroke_preserve (l_drawable)
						{CAIRO}.fill (l_drawable)
					end
					{CAIRO}.stroke (l_drawable)

				end
				post_drawing
			end
		end

	fill_ellipse (x, y, a_width, a_height: INTEGER)
			-- Draw an ellipse bounded by top left (`x', `y') with
			-- size `a_width' and `a_height'.
			-- Fill with `background_color'.
		do
			draw_ellipse_internal (x, y, a_width, a_height, 0, 2 * {DOUBLE_MATH}.pi, True, True)
		end

	fill_polygon (points: ARRAY [EV_COORDINATE])
			-- Draw line segments between subsequent points in `points'.
			-- Fill all enclosed area's with `background_color'.
		do
			draw_polyline_internal (points, True, True)
		end

	fill_pie_slice (x, y, a_width, a_height: INTEGER; a_start_angle, an_aperture: REAL)
			-- Draw a part of an ellipse bounded by top left (`x', `y') with
			-- size `a_width' and `a_height'.
			-- Start at `a_start_angle' and stop at `a_start_angle' + `an_aperture'.
			-- The arc is then closed by two segments through (`x', `y').
			-- Angles are measured in radians.
		do
			draw_ellipse_internal (x, y, a_width, a_height, a_start_angle, an_aperture, True, True)
		end

feature {EV_ANY_I} -- Implementation

	release_drawable (a_drawable: POINTER)
			--| Kept for backward compatibility.
		do
			release_cairo_context (a_drawable)
		end

	release_cairo_context (cr: POINTER)
			-- Release resources of cairo context `cr'.
		require
			not cr.is_default_pointer
		do
			--| By default do nothing, redefined in descendents
		end

feature {NONE} -- Implemention

	coord_array_to_gdkpoint_array (pts: ARRAY [EV_COORDINATE]): ARRAY [INTEGER]
			-- Low-level conversion.
		require
			pts_exists: pts /= Void
		local
			i, j, array_count: INTEGER
			l_area: SPECIAL [INTEGER]
			l_coord_area: SPECIAL [EV_COORDINATE]
		do
			from
				array_count := pts.count
				create Result.make_filled (0, 1, array_count * 2)
				l_coord_area := pts.area
				l_area := Result.area
				i := array_count - 1
				j := array_count * 2 - 1
					-- Iterate backwards as comparing against zero generates faster C code.
			until
				i < 0
			loop
				l_area [j] := (l_coord_area @ i).y + device_y_offset
				j := j - 1
				l_area [j] := (l_coord_area @ i).x + device_x_offset
				i := i - 1
				j := j - 1
			end
		ensure
			Result_exists: Result /= Void
			same_size: pts.count = Result.count / 2
		end

feature {EV_GTK_DEPENDENT_APPLICATION_IMP, EV_ANY_I} -- Implementation

	pixbuf_from_drawable: POINTER
			-- Return a GdkPixbuf object from the current Gdkpixbuf structure
		do
			Result := pixbuf_from_drawable_at_position (0, 0, 0, 0, width, height)
		end

	pixbuf_from_drawable_at_position (src_x, src_y, dest_x, dest_y, a_width, a_height: INTEGER): POINTER
			-- Return a GdkPixbuf object from the current Gdkpixbuf structure
		do
			Result := {GTK}.gdk_pixbuf_new (0, True, 8, a_width, a_height)
		end

	pixbuf_from_drawable_with_size (a_width, a_height: INTEGER): POINTER
			-- Return a GdkPixbuf object from the current Gdkpixbuf structure with dimensions `a_width' * `a_height'
		local
			a_pixbuf: POINTER
		do
			a_pixbuf := pixbuf_from_drawable
			Result := {GTK2}.gdk_pixbuf_scale_simple (a_pixbuf, a_width, a_height, {GTK2}.gdk_interp_bilinear)
			{GTK2}.g_object_unref (a_pixbuf)
		end

feature {NONE} -- Implementation

	device_x_offset: INTEGER
			-- Number of pixels to offset the x coord to get correct device placement
		do
		end

	device_y_offset: INTEGER
			-- Number of pixels to offset to y coord to get correct device placement.
		do
		end

	internal_set_color (a_foreground: BOOLEAN; a_red, a_green, a_blue: REAL_64)
			-- Set `gc' color to (a_red, a_green, a_blue), `a_foreground' sets foreground color, otherwise background is set.
		do
			if cairo_context /= default_pointer and then a_foreground then
				{CAIRO}.set_source_rgb (cairo_context, a_red, a_green, a_blue)
			end
		end

	draw_mask_on_pixbuf (a_pixbuf_ptr, a_mask_ptr: POINTER)
		require
			a_pixbuf_ptr_has_alpha: {GTK2}.gdk_pixbuf_get_has_alpha (a_pixbuf_ptr)
			a_mask_ptr_has_alpha: {GTK2}.gdk_pixbuf_get_has_alpha (a_mask_ptr)
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
			{
				guint32 x, y;
				guint32 l_pix_height,l_pix_width;
				guint32 l_pix_row_stride;
				guint32 l_mask_row_stride;
				GdkPixbuf *pixbuf, *mask;
				guchar *l_mask_pixels, *l_pixbuf_pixels;
				pixbuf = (GdkPixbuf*) arg1;
				mask = (GdkPixbuf*) arg2;
				l_pix_height = gdk_pixbuf_get_height (pixbuf);
				l_pix_width = gdk_pixbuf_get_width (pixbuf);
				l_pix_row_stride = gdk_pixbuf_get_rowstride(pixbuf);
				l_mask_row_stride = gdk_pixbuf_get_rowstride(mask);
				l_mask_pixels = gdk_pixbuf_get_pixels (mask);
				l_pixbuf_pixels = gdk_pixbuf_get_pixels (pixbuf);
				for (y = 0; y < l_pix_height; y++) {
					guchar *src, *dest;
					src = (l_mask_pixels + (y * l_mask_row_stride));
					dest = (l_pixbuf_pixels + (y * l_pix_row_stride));
					for (x = 0; x < l_pix_width; x++) {
						if (src [0] == (guchar)0) {
							dest [3] = (guchar)0;
						}
						src += 4;
						dest += 4;
					}
				}
			}
			]"
		end

	app_implementation: EV_APPLICATION_IMP
			-- Return the instance of EV_APPLICATION_IMP.
		deferred
		end

	internal_foreground_color: detachable EV_COLOR
			-- Color used to draw primitives.

	internal_background_color: detachable EV_COLOR
			-- Color used for erasing of canvas.
			-- Default: white.

	flush
			-- Force all queued expose events to be called.
		deferred
		end

	whole_circle: INTEGER = 23040
		-- Number of 1/64 th degrees in a full circle (360 * 64)

	radians_to_gdk_angle: INTEGER = 3667 --
			-- Multiply radian by this to get no of (1/64) degree segments.

	internal_font_imp: detachable EV_FONT_IMP
		note
			option: stable
		attribute
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_DRAWABLE note option: stable attribute end

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
