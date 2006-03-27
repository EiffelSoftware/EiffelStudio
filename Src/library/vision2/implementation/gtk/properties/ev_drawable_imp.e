indexing
	description: "EiffelVision drawable. GTK implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	DISPOSABLE
		undefine
			copy,
			default_create
		end

	PLATFORM
		undefine
			copy,
			default_create
		end

	MATH_CONST

feature {NONE} -- Initialization

	init_default_values is
			-- Set default values. Call during initialization.
		local
			l_mem: INTEGER_16
		do
			l_mem := {INTEGER_16} 3 | ({INTEGER_16} 3 |<< integer_8_bits)
			set_dashes_pattern (gc, $l_mem)
			line_style := {EV_GTK_EXTERNALS}.Gdk_line_solid_enum
			set_drawing_mode (drawing_mode_copy)
			set_line_width (1)
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

	mask: POINTER is
			-- Pointer to the mask used by `Current'
		deferred
		end

	line_style: INTEGER
			-- Dash-style used when drawing lines.

	cap_style: INTEGER is
			-- Style used for drawing end of lines.
		do
			Result := {EV_GTK_EXTERNALS}.gdk_cap_round_enum
		end

	join_style: INTEGER is
			-- Way in which lines are joined together.				
		do
			Result := {EV_GTK_EXTERNALS}.Gdk_join_bevel_enum
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

	font: EV_FONT is
			-- Font used for drawing text.
		do
			if internal_font_imp /= Void then
				Result := internal_font_imp.interface.twin
			else
				create Result
			end
		end

	foreground_color: EV_COLOR is
			-- Color used to draw primitives.
		do
			if internal_foreground_color /= Void then
				Result := internal_foreground_color
			else
				create Result.make_with_rgb (0, 0, 0)
			end
		end

	background_color: EV_COLOR is
			-- Color used for erasing of canvas.
			-- Default: white.
		do
			if internal_background_color /= Void then
				Result := internal_background_color
			else
				create Result.make_with_rgb (1.0, 1.0, 1.0)
			end
		end

	line_width: INTEGER is
			-- Line thickness.
		do
			gcvalues := {EV_GTK_EXTERNALS}.c_gdk_gcvalues_struct_allocate
			{EV_GTK_EXTERNALS}.gdk_gc_get_values (gc, gcvalues)
			Result := {EV_GTK_EXTERNALS}.gdk_gcvalues_struct_line_width (gcvalues)
			gcvalues.memory_free
		end

	drawing_mode: INTEGER is
			-- Logical operation on pixels when drawing.
		local
			gdk_drawing_mode: INTEGER
		do
			gcvalues := {EV_GTK_EXTERNALS}.c_gdk_gcvalues_struct_allocate
			{EV_GTK_EXTERNALS}.gdk_gc_get_values (gc, gcvalues)
			gdk_drawing_mode := {EV_GTK_EXTERNALS}.gdk_gcvalues_struct_function (gcvalues)
			gcvalues.memory_free

			if gdk_drawing_mode = {EV_GTK_EXTERNALS}.Gdk_copy_enum then
				Result := drawing_mode_copy
			elseif gdk_drawing_mode = {EV_GTK_EXTERNALS}.Gdk_xor_enum then
				Result := drawing_mode_xor
			elseif gdk_drawing_mode = {EV_GTK_EXTERNALS}.Gdk_invert_enum then
				Result := drawing_mode_invert
			elseif gdk_drawing_mode = {EV_GTK_EXTERNALS}.Gdk_and_enum then
				Result := drawing_mode_and
			elseif gdk_drawing_mode = {EV_GTK_EXTERNALS}.Gdk_or_enum then
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
			if gc_clip_area /= Void then
				Result := gc_clip_area.twin
			end
		end

	tile: EV_PIXMAP
			-- Pixmap that is used to fill instead of background_color.
			-- If set to Void, `background_color' is used to fill.

	dashed_line_style: BOOLEAN is
			-- Are lines drawn dashed?
		local
			style: INTEGER
		do
			gcvalues := {EV_GTK_EXTERNALS}.c_gdk_gcvalues_struct_allocate
			{EV_GTK_EXTERNALS}.gdk_gc_get_values (gc, gcvalues)
			style := {EV_GTK_EXTERNALS}.gdk_gcvalues_struct_line_style (gcvalues)
			gcvalues.memory_free
			Result := style = {EV_GTK_EXTERNALS}.Gdk_line_on_off_dash_enum
		end

feature -- Element change

	set_font (a_font: EV_FONT) is
			-- Set `font' to `a_font'.
		do
			if internal_font_imp /= a_font.implementation then
				internal_font_imp ?= a_font.implementation
			end
		end

	set_background_color (a_color: EV_COLOR) is
			-- Assign `a_color' to `background_color'.
		local
			color_struct: POINTER
		do
			if internal_background_color /= a_color then
				internal_background_color := a_color
				color_struct := App_implementation.reusable_color_struct
				{EV_GTK_EXTERNALS}.set_gdk_color_struct_red (color_struct, a_color.red_16_bit)
				{EV_GTK_EXTERNALS}.set_gdk_color_struct_green (color_struct, a_color.green_16_bit)
				{EV_GTK_EXTERNALS}.set_gdk_color_struct_blue (color_struct, a_color.blue_16_bit)
				{EV_GTK_EXTERNALS}.gdk_gc_set_rgb_bg_color (gc, color_struct)
			end
		end

	set_foreground_color (a_color: EV_COLOR) is
			-- Assign `a_color' to `foreground_color'
		local
			color_struct: POINTER
		do
			if internal_foreground_color /= a_color then
				internal_foreground_color := a_color
				color_struct := App_implementation.reusable_color_struct
				{EV_GTK_EXTERNALS}.set_gdk_color_struct_red (color_struct, a_color.red_16_bit)
				{EV_GTK_EXTERNALS}.set_gdk_color_struct_green (color_struct, a_color.green_16_bit)
				{EV_GTK_EXTERNALS}.set_gdk_color_struct_blue (color_struct, a_color.blue_16_bit)
				{EV_GTK_EXTERNALS}.gdk_gc_set_rgb_fg_color (gc, color_struct)
			end
		end

	set_line_width (a_width: INTEGER) is
			-- Assign `a_width' to `line_width'.
		do
			{EV_GTK_EXTERNALS}.gdk_gc_set_line_attributes (gc, a_width,
				line_style, cap_style, join_style)
		end

	set_drawing_mode (a_mode: INTEGER) is
			-- Set drawing mode to `a_mode'.
		local
			l_gc: like gc
		do
			l_gc := gc
			inspect
				a_mode
			when drawing_mode_copy then
				{EV_GTK_EXTERNALS}.gdk_gc_set_function (l_gc, {EV_GTK_EXTERNALS}.Gdk_copy_enum)
			when drawing_mode_xor then
				{EV_GTK_EXTERNALS}.gdk_gc_set_function (l_gc, {EV_GTK_EXTERNALS}.Gdk_xor_enum)
			when drawing_mode_invert then
				{EV_GTK_EXTERNALS}.gdk_gc_set_function (l_gc, {EV_GTK_EXTERNALS}.Gdk_invert_enum)
			when drawing_mode_and then
				{EV_GTK_EXTERNALS}.gdk_gc_set_function (l_gc, {EV_GTK_EXTERNALS}.Gdk_and_enum)
			when drawing_mode_or then
				{EV_GTK_EXTERNALS}.gdk_gc_set_function (l_gc, {EV_GTK_EXTERNALS}.Gdk_or_enum)
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
			gc_clip_area := an_area.twin
			rectangle_struct := {EV_GTK_EXTERNALS}.c_gdk_rectangle_struct_allocate
			{EV_GTK_DEPENDENT_EXTERNALS}.set_gdk_rectangle_struct_x (rectangle_struct, an_area.x)
			{EV_GTK_DEPENDENT_EXTERNALS}.set_gdk_rectangle_struct_y (rectangle_struct, an_area.y)
			{EV_GTK_DEPENDENT_EXTERNALS}.set_gdk_rectangle_struct_width (rectangle_struct, an_area.width)
			{EV_GTK_DEPENDENT_EXTERNALS}.set_gdk_rectangle_struct_height (rectangle_struct, an_area.height)
			{EV_GTK_EXTERNALS}.gdk_gc_set_clip_rectangle (gc, rectangle_struct)
			rectangle_struct.memory_free
		end

	remove_clip_area is
			-- Do not apply any clipping.
		do
			gc_clip_area := Void
			{EV_GTK_EXTERNALS}.gdk_gc_set_clip_rectangle (gc, default_pointer)
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
			{EV_GTK_EXTERNALS}.gdk_gc_set_tile (gc, tile_imp.drawable)
		end

	remove_tile is
			-- Do not apply a tile when filling.
		do
			tile := Void
		end

	enable_dashed_line_style is
			-- Draw lines dashed.
		do
			line_style := {EV_GTK_EXTERNALS}.Gdk_line_on_off_dash_enum
			{EV_GTK_EXTERNALS}.gdk_gc_set_line_attributes (gc, line_width,
				line_style, cap_style, join_style)
		end

	disable_dashed_line_style is
			-- Draw lines solid.
		do
			line_style := {EV_GTK_EXTERNALS}.Gdk_line_solid_enum
			{EV_GTK_EXTERNALS}.gdk_gc_set_line_attributes (gc, line_width,
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
			if drawable /= default_pointer then
				tmp_fg_color := foreground_color
				set_foreground_color (background_color)
				{EV_GTK_EXTERNALS}.gdk_draw_rectangle (drawable, gc, 1,
					x,
					y,
					a_width,
					a_height)
				set_foreground_color (tmp_fg_color)
				update_if_needed
			end
		end

feature -- Drawing operations

	draw_point (x, y: INTEGER) is
			-- Draw point at (`x', `y').
		do
			if drawable /= default_pointer then
	 			{EV_GTK_EXTERNALS}.gdk_draw_point (drawable, gc, x, y)
	 			update_if_needed
			end
		end

	draw_text (x, y: INTEGER; a_text: STRING_GENERAL) is
			-- Draw `a_text' with left of baseline at (`x', `y') using `font'.
		do
			draw_text_internal (x, y, a_text, True, -1, 0)
		end

	draw_rotated_text (x, y: INTEGER; angle: REAL; a_text: STRING_GENERAL) is
			-- Draw rotated text `a_text' with left of baseline at (`x', `y') using `font'.
			-- Rotation is number of degrees counter-clockwise from horizontal plane.
		do
			draw_text_internal (x, y, a_text, True, -1, angle)
		end

	draw_ellipsed_text (x, y: INTEGER; a_text: STRING_GENERAL; clipping_width: INTEGER) is
			-- Draw `a_text' with left of baseline at (`x', `y') using `font'.
			-- Text is clipped to `clipping_width' in pixels and ellipses are displayed
			-- to show truncated characters if any.
		do
			draw_text_internal (x, y, a_text, True, clipping_width, 0)
		end

	draw_ellipsed_text_top_left (x, y: INTEGER; a_text: STRING_GENERAL; clipping_width: INTEGER) is
			-- Draw `a_text' with top left corner at (`x', `y') using `font'.
			-- Text is clipped to `clipping_width' in pixels and ellipses are displayed
			-- to show truncated characters if any.
		do
			draw_text_internal (x, y, a_text, False, clipping_width, 0)
		end

	draw_text_top_left (x, y: INTEGER; a_text: STRING_GENERAL) is
			-- Draw `a_text' with top left corner at (`x', `y') using `font'.
		do
			draw_text_internal (x, y, a_text, False, -1, 0)
		end

	draw_text_internal (x, y: INTEGER; a_text: STRING_GENERAL; draw_from_baseline: BOOLEAN; a_width: INTEGER; a_angle: REAL) is
			-- Draw `a_text' at (`x', `y') using `font'.
		local
			a_cs: EV_GTK_C_STRING
			a_pango_layout: POINTER
			a_x, a_y: INTEGER
			a_clip_area: EV_RECTANGLE
			a_pango_matrix, a_pango_context: POINTER
			l_app_imp: like App_implementation
			l_pango_renderer: POINTER
		do
			if drawable /= default_pointer then
				a_x := x
				if draw_from_baseline then
					if internal_font_imp /= Void then
						a_y := y - internal_font_imp.ascent
					else
						a_y := y - app_implementation.default_font_ascent
					end
				else
					a_y := y
				end
				l_app_imp := App_implementation
				a_cs := l_app_imp.c_string_from_eiffel_string (a_text)
					-- Replace when we have UTF16 support
				a_pango_layout := l_app_imp.pango_layout

				{EV_GTK_EXTERNALS}.pango_layout_set_text (a_pango_layout, a_cs.item, a_cs.string_length)
				if internal_font_imp /= Void then
					{EV_GTK_DEPENDENT_EXTERNALS}.pango_layout_set_font_description (a_pango_layout, internal_font_imp.font_description)
				end

				if a_width /= -1 then
						-- We need to perform ellipsizing on text
--					{EV_GTK_EXTERNALS}.pango_layout_set_ellipsize (a_pango_layout, 3) -- PangoEllipsizeEnd

					-- Previous code for gtk 2.4 that set a clip area for text rendering.
					a_clip_area := gc_clip_area
					set_clip_area (create {EV_RECTANGLE}.make (x, y, a_width, 10000))
--					{EV_GTK_EXTERNALS}.pango_layout_set_width (a_pango_layout, a_width * {EV_GTK_EXTERNALS}.pango_scale)
				end

				if a_angle /= 0 then
--					l_pango_renderer := {EV_GTK_EXTERNALS}.gdk_pango_renderer_get_default ({EV_GTK_EXTERNALS}.gdk_screen_get_default)
--						-- This is reusable so do not free the renderer.
--						-- Renderer is needed to rotate text without a bounding box
--					{EV_GTK_EXTERNALS}.gdk_pango_renderer_set_drawable (l_pango_renderer, drawable)
--					{EV_GTK_EXTERNALS}.gdk_pango_renderer_set_gc (l_pango_renderer, gc)
--					
--					a_pango_context := {EV_GTK_EXTERNALS}.pango_layout_get_context (a_pango_layout)
--					
--					{EV_GTK_EXTERNALS}.pango_matrix_init ($a_pango_matrix)
--					
--					{EV_GTK_EXTERNALS}.pango_matrix_translate (a_pango_matrix, x, y)
--					{EV_GTK_EXTERNALS}.pango_matrix_rotate (a_pango_matrix, a_angle / Pi * 180)
--					{EV_GTK_EXTERNALS}.pango_matrix_translate (a_pango_matrix, 0, -(y - a_y))
--					
--					{EV_GTK_EXTERNALS}.pango_context_set_matrix (a_pango_context, a_pango_matrix)
--
--					{EV_GTK_EXTERNALS}.pango_renderer_draw_layout (l_pango_renderer, a_pango_layout, 0, 0)
--					
--						-- Clean up Pango renderer.
--					{EV_GTK_EXTERNALS}.gdk_pango_renderer_set_drawable (l_pango_renderer, default_pointer)
--					{EV_GTK_EXTERNALS}.gdk_pango_renderer_set_gc (l_pango_renderer, default_pointer)
				else
					{EV_GTK_EXTERNALS}.gdk_draw_layout (drawable, gc, a_x, a_y, a_pango_layout)
				end

					-- Reset all changed values.
				if a_width /= -1 then
						-- Restore clip area (used for gtk 2.4)
					if a_clip_area /= Void then
						set_clip_area (a_clip_area)
					else
						remove_clip_area
					end
	--				{EV_GTK_EXTERNALS}.pango_layout_set_ellipsize (a_pango_layout, 0) -- PangoEllipsizeNone
				end

				{EV_GTK_EXTERNALS}.pango_layout_set_width (a_pango_layout, -1)
				{EV_GTK_EXTERNALS}.pango_layout_set_font_description (a_pango_layout, default_pointer)

--				if a_pango_context /= default_pointer then
--					{EV_GTK_EXTERNALS}.pango_context_set_matrix (a_pango_context, default_pointer)
--					{EV_GTK_EXTERNALS}.pango_matrix_free (a_pango_matrix)
--				end			
			end
		end

	draw_segment (x1, y1, x2, y2: INTEGER) is
			-- Draw line segment from (`x1', 'y1') to (`x2', 'y2').
		do
			if drawable /= default_pointer then
				{EV_GTK_EXTERNALS}.gdk_draw_line (drawable, gc, x1, y1, x2, y2)
				update_if_needed
			end
		end

	draw_arc (x, y, a_width, a_height: INTEGER; a_start_angle, an_aperture: REAL) is
			-- Draw a part of an ellipse bounded by top left (`x', `y') with
			-- size `a_width' and `a_height'.
			-- Start at `a_start_angle' and stop at `a_start_angle' + `an_aperture'.
			-- Angles are measured in radians.
		local
			a_radians: INTEGER
		do
			if drawable /= default_pointer then
				a_radians := radians_to_gdk_angle
				{EV_GTK_EXTERNALS}.gdk_draw_arc (
					drawable,
					gc,
					0,
					x,
					y,
					a_width,
					a_height,
					(a_start_angle * a_radians + 0.5).truncated_to_integer ,
					(an_aperture * a_radians + 0.5).truncated_to_integer
				)
				update_if_needed
			end
		end

	draw_pixmap (x, y: INTEGER; a_pixmap: EV_PIXMAP) is
			-- Draw `a_pixmap' with upper-left corner on (`x', `y').
		do
			draw_full_pixmap (x, y, a_pixmap, 0, 0, a_pixmap.width, a_pixmap.height)
		end

	draw_full_pixmap (x, y: INTEGER; a_pixmap: EV_PIXMAP; x_src, y_src, src_width, src_height: INTEGER) is
		local
			pixmap_imp: EV_PIXMAP_IMP
		do
			if drawable /= default_pointer then
				pixmap_imp ?= a_pixmap.implementation
				if pixmap_imp.mask /= default_pointer then
					{EV_GTK_EXTERNALS}.gdk_gc_set_clip_mask (gc, pixmap_imp.mask)
					{EV_GTK_EXTERNALS}.gdk_gc_set_clip_origin (gc, x - x_src, y - y_src)
				end
				{EV_GTK_DEPENDENT_EXTERNALS}.gdk_draw_drawable (drawable, gc,
					pixmap_imp.drawable,
					x_src, y_src, x, y, src_width, src_height)
				update_if_needed
				if pixmap_imp.mask /= default_pointer then
					{EV_GTK_EXTERNALS}.gdk_gc_set_clip_mask (gc, default_pointer)
					{EV_GTK_EXTERNALS}.gdk_gc_set_clip_origin (gc, 0, 0)
				end
			end
		end

	sub_pixmap (area: EV_RECTANGLE): EV_PIXMAP is
			-- Pixmap region of `Current' represented by rectangle `area'
		local
			pix_imp: EV_PIXMAP_IMP
			a_pix: POINTER
		do
			create Result
			pix_imp ?= Result.implementation
			a_pix := pixbuf_from_drawable_at_position (area.x, area.y, 0, 0, area.width, area.height)
			pix_imp.set_pixmap_from_pixbuf (a_pix)
			{EV_GTK_EXTERNALS}.object_unref (a_pix)
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
			if drawable /= default_pointer then
				{EV_GTK_EXTERNALS}.gdk_draw_rectangle (drawable, gc, 0, x, y, a_width - 1, a_height - 1)
				update_if_needed
			end
		end

	draw_ellipse (x, y, a_width, a_height: INTEGER) is
			-- Draw an ellipse bounded by top left (`x', `y') with
			-- size `a_width' and `a_height'.
		do
			if drawable /= default_pointer then
				if (a_width > 0 and a_height > 0 ) then
					{EV_GTK_EXTERNALS}.gdk_draw_arc (drawable, gc, 0, x,
						y, (a_width - 1),
						(a_height - 1), 0, whole_circle)
					update_if_needed
				end
			end
		end

	draw_polyline (points: ARRAY [EV_COORDINATE]; is_closed: BOOLEAN) is
			-- Draw line segments between subsequent points in
			-- `points'. If `is_closed' draw line segment between first
			-- and last point in `points'.
		local
			tmp: SPECIAL [INTEGER]
		do
			if drawable /= default_pointer then
				tmp := coord_array_to_gdkpoint_array (points).area
				if is_closed then
					{EV_GTK_EXTERNALS}.gdk_draw_polygon (drawable, gc, 0, $tmp, points.count)
					update_if_needed
				else
					{EV_GTK_EXTERNALS}.gdk_draw_lines (drawable, gc, $tmp, points.count)
					update_if_needed
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
			update_if_needed
		end

feature -- filling operations

	fill_rectangle (x, y, a_width, a_height: INTEGER) is
			-- Draw rectangle with upper-left corner on (`x', `y')
			-- with size `a_width' and `a_height'. Fill with `background_color'.
		do
			if drawable /= default_pointer then
				if tile /= Void then
					{EV_GTK_EXTERNALS}.gdk_gc_set_fill (gc, {EV_GTK_EXTERNALS}.Gdk_tiled_enum)
				end
				{EV_GTK_EXTERNALS}.gdk_draw_rectangle (drawable, gc, 1, x, y, a_width, a_height)
				{EV_GTK_EXTERNALS}.gdk_gc_set_fill (gc, {EV_GTK_EXTERNALS}.Gdk_solid_enum)
				update_if_needed
			end
		end

	fill_ellipse (x, y, a_width, a_height: INTEGER) is
			-- Draw an ellipse bounded by top left (`x', `y') with
			-- size `a_width' and `a_height'.
			-- Fill with `background_color'.
		do
			if drawable /= default_pointer then
				if tile /= Void then
					{EV_GTK_EXTERNALS}.gdk_gc_set_fill (gc, {EV_GTK_EXTERNALS}.Gdk_tiled_enum)
				end
				{EV_GTK_EXTERNALS}.gdk_draw_arc (drawable, gc, 1, x,
					y, a_width,
					a_height, 0, whole_circle)
				update_if_needed
				{EV_GTK_EXTERNALS}.gdk_gc_set_fill (gc, {EV_GTK_EXTERNALS}.Gdk_solid_enum)
			end
		end

	fill_polygon (points: ARRAY [EV_COORDINATE]) is
			-- Draw line segments between subsequent points in `points'.
			-- Fill all enclosed area's with `background_color'.
		local
			tmp: SPECIAL [INTEGER]
		do
			if drawable /= default_pointer then
				tmp := coord_array_to_gdkpoint_array (points).area
				if tile /= Void then
					{EV_GTK_EXTERNALS}.gdk_gc_set_fill (gc, {EV_GTK_EXTERNALS}.Gdk_tiled_enum)
				end
				{EV_GTK_EXTERNALS}.gdk_draw_polygon (drawable, gc, 1, $tmp, points.count)
				{EV_GTK_EXTERNALS}.gdk_gc_set_fill (gc, {EV_GTK_EXTERNALS}.Gdk_solid_enum)
				update_if_needed
			end
		end

	fill_pie_slice (x, y, a_width, a_height: INTEGER; a_start_angle, an_aperture: REAL) is
			-- Draw a part of an ellipse bounded by top left (`x', `y') with
			-- size `a_width' and `a_height'.
			-- Start at `a_start_angle' and stop at `a_start_angle' + `an_aperture'.
			-- The arc is then closed by two segments through (`x', `y').
			-- Angles are measured in radians.
		do
			if drawable /= default_pointer then
				if tile /= Void then
					{EV_GTK_EXTERNALS}.gdk_gc_set_fill (gc, {EV_GTK_EXTERNALS}.Gdk_tiled_enum)
				end
				{EV_GTK_EXTERNALS}.gdk_draw_arc (
					drawable,
					gc,
					1,
					x,
					y,
					a_width,
					a_height,
					(a_start_angle * radians_to_gdk_angle).truncated_to_integer ,
					(an_aperture * radians_to_gdk_angle).truncated_to_integer
				)
				{EV_GTK_EXTERNALS}.gdk_gc_set_fill (gc, {EV_GTK_EXTERNALS}.Gdk_solid_enum)
				update_if_needed
			end
		end

feature {NONE} -- Implemention

	coord_array_to_gdkpoint_array (pts: ARRAY [EV_COORDINATE]): ARRAY [INTEGER] is
			-- Low-level conversion.
		require
			pts_exists: pts /= Void
		local
			i, array_count: INTEGER
			a_pts: ARRAY [EV_COORDINATE]
			a_coord: EV_COORDINATE
		do
			from
				a_pts := pts
				array_count := a_pts.count * 2
				create Result.make (1, array_count)
				i := 2
			until
				i > array_count + 1
			loop
				a_coord := a_pts.item (i // 2)
				Result.force (a_coord.x, i - 1)
				Result.force (a_coord.y, i)
				i := i + 2
			end
		ensure
			Result_exists: Result /= Void
			same_size: pts.count = Result.count / 2
		end

feature {EV_GTK_DEPENDENT_APPLICATION_IMP, EV_ANY_I} -- Implementation

	pixbuf_from_drawable: POINTER is
			-- Return a GdkPixbuf object from the current Gdkpixbuf structure
		do
			Result := pixbuf_from_drawable_at_position (0, 0, 0, 0, width, height)
		end

	pixbuf_from_drawable_at_position (src_x, src_y, dest_x, dest_y, a_width, a_height: INTEGER): POINTER is
			-- Return a GdkPixbuf object from the current Gdkpixbuf structure
		local
			new_pix, new_mask_pix, l_image, l_mask_image, a_pix, a_mask_pix, l_temp_pix: POINTER
		do
			new_pix := {EV_GTK_EXTERNALS}.gdk_pixbuf_new (0, True, 8, a_width, a_height)
			l_image := {EV_GTK_EXTERNALS}.gdk_drawable_copy_to_image (drawable, default_pointer, src_x, src_y, dest_x, dest_y, a_width, a_height)


			a_pix := {EV_GTK_EXTERNALS}.gdk_pixbuf_get_from_image (new_pix, l_image, default_pointer, 0, 0, 0, 0, a_width, a_height)
				-- We do not unref new_pix as it is being reused

			{EV_GTK_EXTERNALS}.object_unref (l_image)
			l_image := default_pointer

			if mask /= default_pointer then
				new_mask_pix := {EV_GTK_EXTERNALS}.gdk_pixbuf_new (0, True, 8, a_width, a_height)
				l_mask_image := {EV_GTK_EXTERNALS}.gdk_drawable_copy_to_image (mask, default_pointer, src_x, src_y, dest_x, dest_y, a_width, a_height)
				a_mask_pix := {EV_GTK_EXTERNALS}.gdk_pixbuf_get_from_image (new_mask_pix, l_mask_image, default_pointer, 0, 0, 0, 0, a_width, a_height)
				{EV_GTK_EXTERNALS}.object_unref (l_mask_image)
				l_mask_image := default_pointer

				l_temp_pix := a_mask_pix
				a_mask_pix := {EV_GTK_DEPENDENT_EXTERNALS}.gdk_pixbuf_add_alpha (l_temp_pix, True, 255, 255, 255)
				{EV_GTK_EXTERNALS}.object_unref (l_temp_pix)
					-- Draw mask on top of pixbuf.
				{EV_GTK_DEPENDENT_EXTERNALS}.gdk_pixbuf_composite (a_mask_pix, a_pix, 0, 0, a_width, a_height, 0, 0, 1, 1, {EV_GTK_DEPENDENT_EXTERNALS}.gdk_interp_bilinear, 255)
				draw_mask_on_pixbuf (a_pix, a_mask_pix)

				 -- Clean up
				{EV_GTK_EXTERNALS}.object_unref (a_mask_pix)

				Result := a_pix
			else
				Result := a_pix
			end
		end

	pixbuf_from_drawable_with_size (a_width, a_height: INTEGER): POINTER is
			-- Return a GdkPixbuf object from the current Gdkpixbuf structure with dimensions `a_width' * `a_height'
		local
			a_pixbuf: POINTER
		do
			a_pixbuf := pixbuf_from_drawable
			Result := {EV_GTK_DEPENDENT_EXTERNALS}.gdk_pixbuf_scale_simple (a_pixbuf, a_width, a_height, {EV_GTK_DEPENDENT_EXTERNALS}.gdk_interp_bilinear)
			{EV_GTK_EXTERNALS}.object_unref (a_pixbuf)
		end

feature {NONE} -- Implementation

	draw_mask_on_pixbuf (a_pixbuf_ptr, a_mask_ptr: POINTER) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"[
				{
				int x, y;

				GdkPixbuf *pixbuf, *mask;

				pixbuf = (GdkPixbuf*) $a_pixbuf_ptr;
				mask = (GdkPixbuf*) $a_mask_ptr;

				for (y = 0; y < gdk_pixbuf_get_height (pixbuf); y++)
				{
					guchar *src, *dest;

					src = gdk_pixbuf_get_pixels (mask) + y * gdk_pixbuf_get_rowstride (mask);
					dest = gdk_pixbuf_get_pixels (pixbuf) + y * gdk_pixbuf_get_rowstride (pixbuf);

					for (x = 0; x < gdk_pixbuf_get_width (pixbuf); x++)
					{
						if (src [0] == 0)
							dest [3] = 0;

						src += 4;
						dest += 4;
					}

				}
				}
			]"
		end

	app_implementation: EV_APPLICATION_IMP is
			-- Return the instance of EV_APPLICATION_IMP.
		deferred
		end

	internal_foreground_color: EV_COLOR
			-- Color used to draw primitives.

	internal_background_color: EV_COLOR
			-- Color used for erasing of canvas.
			-- Default: white.

	flush is
			-- Force all queued expose events to be called.
		deferred
		end

	update_if_needed is
			-- Force update of `Current' if needed
		deferred
		end

	whole_circle: INTEGER is 23040
		-- Number of 1/64 th degrees in a full circle (360 * 64)

	radians_to_gdk_angle: INTEGER is 3667 --
			-- Multiply radian by this to get no of (1/64) degree segments.

	internal_font_imp: EV_FONT_IMP

	interface: EV_DRAWABLE

	gdk_gc_unref (a_gc: POINTER) is
			-- void   gdk_gc_unref		  (GdkGC	    *gc);
		external
			"C (GdkGC*) | <gtk/gtk.h>"
		end

	set_dashes_pattern (a_gc, dash_pattern: POINTER) is
			-- Set the dashes pattern for gc `a_gc', `dash_pattern' is a pointer to a two count gint8[]] denoting the pattern.
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gdk_gc_set_dashes ((GdkGC*) $a_gc, 0, (gint8*) $dash_pattern, 2)"
		end

invariant
	gc_not_void: is_usable implies gc /= default_pointer

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_DRAWABLE_IMP

