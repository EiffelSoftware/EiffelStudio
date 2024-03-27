note
	description: "EiffelVision drawable. GTK implementation."
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

	init_default_values
			-- Set default values. Call during initialization.
		local
			l_mem: INTEGER_16
		do
			l_mem := {INTEGER_16} 3 | ({INTEGER_16} 3 |<< integer_8_bits)
			set_dashes_pattern (gc, $l_mem)
			line_style := {GTK}.Gdk_line_solid_enum
			set_drawing_mode (drawing_mode_copy)
			set_line_width (1)
		end

feature {EV_ANY_I} -- Implementation

	gc: POINTER
			-- Pointer to GdkGC struct.
			-- The graphics context applied to the primitives.
			-- Line style, width, colors, etc. are defined in here.

	gcvalues: POINTER
			-- Pointer to GdkGCValues struct.
			-- Is allocated during creation but has to be updated
			-- every time it is accessed.

	drawable: POINTER
			-- Pointer to the GdkWindow of `c_object'.
		deferred
		end

	mask: POINTER
			-- Pointer to the mask used by `Current'
		deferred
		end

feature {EV_DRAWABLE_IMP} -- Implementation

	line_style: INTEGER
			-- Dash-style used when drawing lines.

	cap_style: INTEGER
			-- Style used for drawing end of lines.
		do
			Result := {GTK}.gdk_cap_round_enum
		end

	join_style: INTEGER
			-- Way in which lines are joined together.				
		do
			Result := {GTK}.Gdk_join_bevel_enum
		end

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
				-- Default to black if `internal_foreground_color` is not set.
			if attached internal_foreground_color as l_internal_foreground_color then
				l_red := l_internal_foreground_color.red_8_bit
				l_green := l_internal_foreground_color.green_8_bit
				l_blue := l_internal_foreground_color.blue_8_bit
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
		do
			gcvalues := {GTK}.c_gdk_gcvalues_struct_allocate
			{GTK}.gdk_gc_get_values (gc, gcvalues)
			Result := {GTK}.gdk_gcvalues_struct_line_width (gcvalues)
			gcvalues.memory_free
		end

	drawing_mode: INTEGER
			-- Logical operation on pixels when drawing.
		local
			gdk_drawing_mode: INTEGER
		do
			gcvalues := {GTK}.c_gdk_gcvalues_struct_allocate
			{GTK}.gdk_gc_get_values (gc, gcvalues)
			gdk_drawing_mode := {GTK}.gdk_gcvalues_struct_function (gcvalues)
			gcvalues.memory_free

			if gdk_drawing_mode = {GTK}.Gdk_copy_enum then
				Result := drawing_mode_copy
			elseif gdk_drawing_mode = {GTK}.Gdk_xor_enum then
				Result := drawing_mode_xor
			elseif gdk_drawing_mode = {GTK}.Gdk_invert_enum then
				Result := drawing_mode_invert
			elseif gdk_drawing_mode = {GTK}.Gdk_and_enum then
				Result := drawing_mode_and
			elseif gdk_drawing_mode = {GTK}.Gdk_or_enum then
				Result := drawing_mode_or
			else
				check
					drawing_mode_existent: False
				end
			end
		end

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
			-- Are lines drawn dashed?
		local
			style: INTEGER
		do
			gcvalues := {GTK}.c_gdk_gcvalues_struct_allocate
			{GTK}.gdk_gc_get_values (gc, gcvalues)
			style := {GTK}.gdk_gcvalues_struct_line_style (gcvalues)
			gcvalues.memory_free
			Result := style = {GTK}.Gdk_line_on_off_dash_enum
		end

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
				internal_set_color (False, a_color.red_16_bit, a_color.green_16_bit, a_color.blue_16_bit)
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
				internal_set_color (True, a_color.red_16_bit, a_color.green_16_bit, a_color.blue_16_bit)
			end
		end

	set_line_width (a_width: INTEGER)
			-- Assign `a_width' to `line_width'.
		do
			{GTK}.gdk_gc_set_line_attributes (gc, a_width,
				line_style, cap_style, join_style)
		end

	set_drawing_mode (a_mode: INTEGER)
			-- Set drawing mode to `a_mode'.
		local
			l_gc: like gc
		do
			l_gc := gc
			inspect
				a_mode
			when drawing_mode_copy then
				{GTK}.gdk_gc_set_function (l_gc, {GTK}.Gdk_copy_enum)
			when drawing_mode_xor then
				{GTK}.gdk_gc_set_function (l_gc, {GTK}.Gdk_xor_enum)
			when drawing_mode_invert then
				{GTK}.gdk_gc_set_function (l_gc, {GTK}.Gdk_invert_enum)
			when drawing_mode_and then
				{GTK}.gdk_gc_set_function (l_gc, {GTK}.Gdk_and_enum)
			when drawing_mode_or then
				{GTK}.gdk_gc_set_function (l_gc, {GTK}.Gdk_or_enum)
			else
				check
					drawing_mode_existent: False
				end
			end
		end

	set_clip_area (an_area: EV_RECTANGLE)
			-- Set an area to clip to.
		local
			rectangle_struct: POINTER
		do
			gc_clip_area := an_area.twin
			rectangle_struct := {GTK}.c_gdk_rectangle_struct_allocate
			{GTK2}.set_gdk_rectangle_struct_x (rectangle_struct, an_area.x + device_x_offset)
			{GTK2}.set_gdk_rectangle_struct_y (rectangle_struct, an_area.y + device_y_offset)
			{GTK2}.set_gdk_rectangle_struct_width (rectangle_struct, an_area.width)
			{GTK2}.set_gdk_rectangle_struct_height (rectangle_struct, an_area.height)
			{GTK}.gdk_gc_set_clip_region (gc, default_pointer)
			{GTK}.gdk_gc_set_clip_rectangle (gc, rectangle_struct)
			rectangle_struct.memory_free
		end

	set_clip_region (a_region: EV_REGION)
			-- Set a region to clip to.
		local
			a_region_imp: detachable EV_REGION_IMP
			rectangle_struct: POINTER
		do
			rectangle_struct := {GTK}.c_gdk_rectangle_struct_allocate
			a_region_imp ?= a_region.implementation
			check a_region_imp /= Void then end
			{GTK}.gdk_region_get_clipbox (a_region_imp.gdk_region, rectangle_struct)
				-- Set the gc clip area.
			create gc_clip_area.make (
				{GTK}.gdk_rectangle_struct_x (rectangle_struct) + device_x_offset,
				{GTK}.gdk_rectangle_struct_y (rectangle_struct) + device_y_offset,
				{GTK}.gdk_rectangle_struct_width (rectangle_struct),
				{GTK}.gdk_rectangle_struct_height (rectangle_struct)
			)
			{GTK}.gdk_gc_set_clip_rectangle (gc, default_pointer)
			{GTK}.gdk_gc_set_clip_region (gc, a_region_imp.gdk_region)
			rectangle_struct.memory_free
		end

	remove_clipping
			-- Do not apply any clipping.
		do
			gc_clip_area := Void
			{GTK}.gdk_gc_set_clip_rectangle (gc, default_pointer)
			{GTK}.gdk_gc_set_clip_region (gc, default_pointer)
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
			check tile_imp /= Void then end
			{GTK}.gdk_gc_set_tile (gc, tile_imp.drawable)
		end

	remove_tile
			-- Do not apply a tile when filling.
		do
			tile := Void
		end

	enable_dashed_line_style
			-- Draw lines dashed.
		do
			line_style := {GTK}.Gdk_line_on_off_dash_enum
			{GTK}.gdk_gc_set_line_attributes (gc, line_width,
				line_style, cap_style, join_style)
		end

	disable_dashed_line_style
			-- Draw lines solid.
		do
			line_style := {GTK}.Gdk_line_solid_enum
			{GTK}.gdk_gc_set_line_attributes (gc, line_width,
				line_style, cap_style, join_style)
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
			tmp_fg_color, tmp_bg_color: detachable EV_COLOR
		do
			if drawable /= default_pointer then
				tmp_fg_color := internal_foreground_color
				if tmp_fg_color = Void then
					tmp_fg_color := foreground_color
				end
				tmp_bg_color := internal_background_color
				if tmp_bg_color = Void then
					tmp_bg_color := background_color
				end
				internal_set_color (True, tmp_bg_color.red_16_bit, tmp_bg_color.green_16_bit, tmp_bg_color.blue_16_bit)
				{GTK}.gdk_draw_rectangle (drawable, gc, 1,
					(x + device_x_offset).max ({INTEGER_16}.min_value).min ({INTEGER_16}.max_value),
					(y + device_y_offset).max ({INTEGER_16}.min_value).min ({INTEGER_16}.max_value),
					a_width,
					a_height)
				internal_set_color (True, tmp_fg_color.red_16_bit, tmp_fg_color.green_16_bit, tmp_fg_color.blue_16_bit)
				update_if_needed
			end
		end

feature -- Drawing operations

	draw_point (x, y: INTEGER)
			-- Draw point at (`x', `y').
		do
			if drawable /= default_pointer then
	 			{GTK}.gdk_draw_point (
	 				drawable,
	 				gc,
	 				(x + device_x_offset).max ({INTEGER_16}.min_value).min ({INTEGER_16}.max_value),
	 				(y + device_y_offset).max ({INTEGER_16}.min_value).min ({INTEGER_16}.max_value)
	 			)
	 			update_if_needed
			end
		end

	draw_text (x, y: INTEGER; a_text: READABLE_STRING_GENERAL)
			-- Draw `a_text' with left of baseline at (`x', `y') using `font'.
		do
			draw_text_internal (
				x.max ({INTEGER_16}.min_value).min ({INTEGER_16}.max_value),
				y.max ({INTEGER_16}.min_value).min ({INTEGER_16}.max_value),
				a_text,
				True,
				-1,
				0
			)
		end

	draw_rotated_text (x, y: INTEGER; angle: REAL; a_text: READABLE_STRING_GENERAL)
			-- Draw rotated text `a_text' with left of baseline at (`x', `y') using `font'.
			-- Rotation is number of radians counter-clockwise from horizontal plane.
		do
			draw_text_internal (
				x.max ({INTEGER_16}.min_value).min ({INTEGER_16}.max_value),
				y.max ({INTEGER_16}.min_value).min ({INTEGER_16}.max_value),
				a_text,
				True,
				-1,
				angle
			)
		end

	draw_ellipsed_text (x, y: INTEGER; a_text: READABLE_STRING_GENERAL; clipping_width: INTEGER)
			-- Draw `a_text' with left of baseline at (`x', `y') using `font'.
			-- Text is clipped to `clipping_width' in pixels and ellipses are displayed
			-- to show truncated characters if any.
		do
			draw_text_internal (
				x.max ({INTEGER_16}.min_value).min ({INTEGER_16}.max_value),
				y.max ({INTEGER_16}.min_value).min ({INTEGER_16}.max_value),
				a_text,
				True,
				clipping_width,
				0
			)
		end

	draw_ellipsed_text_top_left (x, y: INTEGER; a_text: READABLE_STRING_GENERAL; clipping_width: INTEGER)
			-- Draw `a_text' with top left corner at (`x', `y') using `font'.
			-- Text is clipped to `clipping_width' in pixels and ellipses are displayed
			-- to show truncated characters if any.
		do
			draw_text_internal (
				x.max ({INTEGER_16}.min_value).min ({INTEGER_16}.max_value),
				y.max ({INTEGER_16}.min_value).min ({INTEGER_16}.max_value),
				a_text,
				False,
				clipping_width,
				0
			)
		end

	draw_text_top_left (x, y: INTEGER; a_text: READABLE_STRING_GENERAL)
			-- Draw `a_text' with top left corner at (`x', `y') using `font'.
		do
			draw_text_internal (
				x.max ({INTEGER_16}.min_value).min ({INTEGER_16}.max_value),
				y.max ({INTEGER_16}.min_value).min ({INTEGER_16}.max_value),
				a_text,
				False,
				-1,
				0
			)
		end

	draw_text_internal (x, y: INTEGER; a_text: READABLE_STRING_GENERAL; draw_from_baseline: BOOLEAN; a_width: INTEGER; a_angle: REAL)
			-- Draw `a_text' at (`x', `y') using `font'.
		local
			a_cs: EV_GTK_C_STRING
			a_pango_layout: POINTER
			x_orig, y_orig, a_x, a_y: INTEGER
			a_clip_area: detachable EV_RECTANGLE
			a_pango_matrix, a_pango_context: POINTER
			l_app_imp: like App_implementation
			l_pango_renderer: POINTER
			l_ellipsize_symbol: POINTER
		do
			if drawable /= default_pointer then
				l_app_imp := App_implementation

					-- Set x_orig and y_orig to be the device translated values which must be used for the rest of the routine.
				x_orig := x + device_x_offset
				y_orig := y + device_y_offset

				a_x := x_orig
				if draw_from_baseline then
					if internal_font_imp /= Void then
						a_y := y_orig - internal_font_imp.ascent
					else
						a_y := y_orig - l_app_imp.default_font_ascent
					end
				else
					a_y := y_orig
				end

				a_cs := l_app_imp.c_string_from_eiffel_string (a_text)
					-- Replace when we have UTF16 support
				a_pango_layout := l_app_imp.pango_layout

				{GTK2}.pango_layout_set_text (a_pango_layout, a_cs.item, a_cs.string_length)
				if internal_font_imp /= Void then
					{GTK2}.pango_layout_set_font_description (a_pango_layout, internal_font_imp.font_description)
				end

				if a_width /= -1 then
						-- We need to perform ellipsizing on text if available, otherwise we clip.
					l_ellipsize_symbol := pango_layout_set_ellipsize_symbol
					if l_ellipsize_symbol = default_pointer then
							-- Previous code for gtk 2.4 that set a clip area for text rendering.						
						a_clip_area := gc_clip_area
						set_clip_area (create {EV_RECTANGLE}.make (x_orig, y_orig, a_width, 10000))
						{GTK2}.pango_layout_set_width (a_pango_layout, 10000 * {GTK2}.pango_scale)
					else
						pango_layout_set_ellipsize_call (l_ellipsize_symbol, a_pango_layout, 3)
						{GTK2}.pango_layout_set_width (a_pango_layout, a_width * {GTK2}.pango_scale)
					end
				end

				if a_angle = 0 then
					{GTK2}.gdk_draw_layout (
						drawable,
						gc,
						a_x.max ({INTEGER_16}.min_value).min ({INTEGER_16}.max_value),
						a_y.max ({INTEGER_16}.min_value).min ({INTEGER_16}.max_value),
						a_pango_layout
					)
				else
					l_pango_renderer := {GTK2}.gdk_pango_renderer_get_default ({GTK2}.gdk_screen_get_default)
						-- This is reusable so do not free the renderer.
						-- Renderer is needed to rotate text without a bounding box
					{GTK2}.gdk_pango_renderer_set_drawable (l_pango_renderer, drawable)
					{GTK2}.gdk_pango_renderer_set_gc (l_pango_renderer, gc)

					a_pango_context := {GTK2}.pango_layout_get_context (a_pango_layout)

					{GTK2}.pango_matrix_init ($a_pango_matrix)

					{GTK2}.pango_matrix_translate (
						a_pango_matrix,
						x_orig.max ({INTEGER_16}.min_value).min ({INTEGER_16}.max_value),
						y_orig.max ({INTEGER_16}.min_value).min ({INTEGER_16}.max_value)
					)
					{GTK2}.pango_matrix_rotate (a_pango_matrix, a_angle / Pi.truncated_to_real * 180)
					{GTK2}.pango_matrix_translate (a_pango_matrix, 0, -(y_orig - a_y))

					{GTK2}.pango_context_set_matrix (a_pango_context, a_pango_matrix)

					{GTK2}.pango_renderer_draw_layout (l_pango_renderer, a_pango_layout, 0, 0)

						-- Clean up Pango renderer.
					{GTK2}.gdk_pango_renderer_set_drawable (l_pango_renderer, default_pointer)
					{GTK2}.gdk_pango_renderer_set_gc (l_pango_renderer, default_pointer)
				end

					-- Reset all changed values.
				if a_width /= -1 then
					if l_ellipsize_symbol /= default_pointer then
						pango_layout_set_ellipsize_call (l_ellipsize_symbol, a_pango_layout, 0)
					elseif attached a_clip_area then
							-- Restore clip area (used for gtk 2.4 implementation)
						set_clip_area (a_clip_area)
					else
						remove_clipping
					end
				end

				{GTK2}.pango_layout_set_width (a_pango_layout, -1)
				{GTK2}.pango_layout_set_font_description (a_pango_layout, default_pointer)

				if a_pango_context /= default_pointer then
					{GTK2}.pango_context_set_matrix (a_pango_context, default_pointer)
					{GTK2}.pango_matrix_free (a_pango_matrix)
				end
			end
		end

	pango_layout_set_ellipsize_symbol: POINTER
			-- Symbol for `pango_layout_set_ellipsize'.
		once
			Result := app_implementation.symbol_from_symbol_name ("pango_layout_set_ellipsize")
		end

	pango_layout_set_ellipsize_call (a_function: POINTER; a_layout: POINTER; a_ellipsize_mode: INTEGER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"(FUNCTION_CAST(void, (PangoLayout*, gint)) $a_function)((PangoLayout*) $a_layout, (gint) $a_ellipsize_mode);"
		end

	draw_segment (x1, y1, x2, y2: INTEGER)
			-- Draw line segment from (`x1', 'y1') to (`x2', 'y2').
		do
			if drawable /= default_pointer then
				{GTK}.gdk_draw_line (
					drawable,
					gc,
					(x1 + device_x_offset).max ({INTEGER_16}.min_value).min ({INTEGER_16}.max_value),
					(y1 + device_y_offset).max ({INTEGER_16}.min_value).min ({INTEGER_16}.max_value),
					(x2 + device_x_offset).max ({INTEGER_16}.min_value).min ({INTEGER_16}.max_value),
					(y2 + device_y_offset).max ({INTEGER_16}.min_value).min ({INTEGER_16}.max_value)
				)
				update_if_needed
			end
		end

	draw_arc (x, y, a_width, a_height: INTEGER; a_start_angle, an_aperture: REAL)
			-- Draw a part of an ellipse bounded by top left (`x', `y') with
			-- size `a_width' and `a_height'.
			-- Start at `a_start_angle' and stop at `a_start_angle' + `an_aperture'.
			-- Angles are measured in radians.
		local
			a_radians: INTEGER
		do
			if drawable /= default_pointer then
				a_radians := radians_to_gdk_angle
				{GTK}.gdk_draw_arc (
					drawable,
					gc,
					0,
					(x + device_x_offset).max ({INTEGER_16}.min_value).min ({INTEGER_16}.max_value),
					(y + device_y_offset).max ({INTEGER_16}.min_value).min ({INTEGER_16}.max_value),
					a_width,
					a_height,
					(a_start_angle * a_radians + 0.5).truncated_to_integer,
					(an_aperture * a_radians + 0.5).truncated_to_integer
				)
				update_if_needed
			end
		end

	draw_sub_pixel_buffer (a_x, a_y: INTEGER; a_pixel_buffer: EV_PIXEL_BUFFER; area: EV_RECTANGLE)
			-- Draw `area' of `a_pixel_buffer' with upper-left corner on (`a_x', `a_y').
		local
			a_pixbuf_imp: detachable EV_PIXEL_BUFFER_IMP
			l_pixels: POINTER
			l_rowstride: NATURAL
			l_back_buffer: POINTER
			l_x, l_y: INTEGER
			l_rect: EV_RECTANGLE
		do
				-- We can only draw the visible area of `a_pixel_buffer' in `area'.
			l_rect := area.intersection (a_pixel_buffer.area)
			if l_rect.width > 0 and l_rect.height > 0 then
					-- Shift the destination (x,y) where `a_pixel_buffer' will be drawn in
					-- case the source `area' is not entirely within `a_pixel_buffer'.
				l_x := a_x + l_rect.x - area.x
				l_y := a_y + l_rect.y - area.y
				a_pixbuf_imp ?= a_pixel_buffer.implementation
				check a_pixbuf_imp /= Void then end
				if supports_pixbuf_alpha then
					{GTK2}.gdk_draw_pixbuf (drawable, gc, a_pixbuf_imp.gdk_pixbuf, l_rect.x, l_rect.y, l_x + device_x_offset, l_y + device_y_offset, l_rect.width, l_rect.height, 0, 0, 0)
				else
						-- We need to retrieve the source pixmap, composite and then reblit to the same area.
					l_back_buffer := pixbuf_from_drawable_at_position (l_x, l_y, 0, 0, l_rect.width, l_rect.height)
					{GTK2}.gdk_pixbuf_composite (a_pixbuf_imp.gdk_pixbuf, l_back_buffer, 0, 0, l_rect.width, l_rect.height, 0, 0, 1, 1, 0, 255)
					l_pixels := {GTK}.gdk_pixbuf_get_pixels (l_back_buffer)
					l_rowstride := {GTK}.gdk_pixbuf_get_rowstride (l_back_buffer)
					{GTK}.gdk_draw_rgb_32_image (drawable, gc, l_x + device_x_offset, l_y + device_y_offset, l_rect.width, l_rect.height, 0, l_pixels, l_rowstride.as_integer_32)
					{GOBJECT}.g_object_unref (l_back_buffer)
				end
			end
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
			l_source_full, l_source_clip, l_source_intersection: EV_RECTANGLE
			l_dest_full, l_dest_clip, l_dest_intersection: EV_RECTANGLE
			pixmap_imp: detachable EV_PIXMAP_IMP
--			l_visible_region, l_visible_rectangle: POINTER
		do
			if drawable /= default_pointer then

					-- Get visible region of drawable
				--| FIXME IEK Optimize for visible regions with corruptable data.
--				l_visible_rectangle := {EV_GTK_EXTERNALS}.c_gdk_rectangle_struct_allocate
--				l_visible_region := {EV_GTK_EXTERNALS}.gdk_drawable_get_visible_region (drawable)
--				if corruptable_onscreen and l_visible_region /= default_pointer then
--					{EV_GTK_EXTERNALS}.gdk_region_get_clipbox (l_visible_region, l_visible_rectangle)
--					{EV_GTK_EXTERNALS}.gdk_region_destroy (l_visible_region)
--					l_visible_region := default_pointer
--					create l_source_full.make (
--						{EV_GTK_EXTERNALS}.gdk_rectangle_struct_x (l_visible_rectangle),
--						{EV_GTK_EXTERNALS}.gdk_rectangle_struct_y (l_visible_rectangle),
--						{EV_GTK_EXTERNALS}.gdk_rectangle_struct_width (l_visible_rectangle),
--						{EV_GTK_EXTERNALS}.gdk_rectangle_struct_height (l_visible_rectangle)
--					)
--				else
					create l_source_full.make (0, 0, a_pixmap.width, a_pixmap.height)
--				end

--				l_visible_rectangle.memory_free

				create l_source_clip.make (x_src, y_src, src_width, src_height)

				l_source_intersection := l_source_full.intersection (l_source_clip)
					-- The source intersection dimensions are used as the initial size of the clip
					-- The source intersection origin is used as the initial origin of the clip

				if l_source_intersection.width > 0 and then l_source_intersection.height > 0 then

					create l_dest_full.make (0, 0, width, height)
						-- Account for any source clipping in the destination
					create l_dest_clip.make (x + l_source_intersection.x - l_source_clip.x, y + l_source_intersection.y - l_source_clip.y, l_source_intersection.width, l_source_intersection.height)

						-- Move the source clip to the intersection position and dimensions
					l_source_clip.move (l_source_intersection.x, l_source_intersection.y)
					l_source_clip.resize (l_source_intersection.width, l_source_intersection.height)

					l_dest_intersection := l_dest_full.intersection (l_dest_clip)

					if l_dest_intersection.width > 0 and then l_dest_intersection.height > 0 then

						l_source_clip.resize (l_dest_intersection.width, l_dest_intersection.height)

							-- We need to account for any destination position clipping by updating the source clip accordingly.
						l_source_clip.set_x (l_source_clip.x + (l_dest_intersection.x - l_dest_clip.x))
						l_source_clip.set_y (l_source_clip.y + (l_dest_intersection.y - l_dest_clip.y))

							-- The dimensions of the destination intersection are now the new dimensions of the source clip.
						l_dest_clip.move (l_dest_intersection.x, l_dest_intersection.y)
						l_dest_clip.resize (l_dest_intersection.width, l_dest_intersection.y)

						pixmap_imp ?= a_pixmap.implementation
						check pixmap_imp /= Void then end

						if pixmap_imp.mask /= default_pointer then
							{GTK}.gdk_gc_set_clip_mask (gc, pixmap_imp.mask)
							{GTK}.gdk_gc_set_clip_origin (gc, l_dest_clip.x + device_x_offset - l_source_clip.x, l_dest_clip.y + device_y_offset - l_source_clip.y)
						end
						{GTK2}.gdk_draw_drawable (
							drawable,
							gc,
							pixmap_imp.drawable,
							l_source_clip.x,
							l_source_clip.y,
							l_dest_clip.x + device_x_offset,
							l_dest_clip.y + device_y_offset,
							l_source_clip.width,
							l_source_clip.height
						)
						update_if_needed
						if pixmap_imp.mask /= default_pointer then
							{GTK}.gdk_gc_set_clip_mask (gc, default_pointer)
							{GTK}.gdk_gc_set_clip_origin (gc, 0, 0)
						end
					end
				end
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
			{GOBJECT}.g_object_unref (a_pix)
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
			if
				drawable /= default_pointer and then
				a_width > 0 and then a_height > 0
			then
					-- If width or height are zero then nothing will be rendered.
				{GTK}.gdk_draw_rectangle (
					drawable,
					gc,
					0,
					(x + device_x_offset).max ({INTEGER_16}.min_value).min ({INTEGER_16}.max_value),
					(y + device_y_offset).max ({INTEGER_16}.min_value).min ({INTEGER_16}.max_value),
					a_width - 1,
					a_height - 1
				)
				update_if_needed
			end
		end

	draw_ellipse (x, y, a_width, a_height: INTEGER)
			-- Draw an ellipse bounded by top left (`x', `y') with
			-- size `a_width' and `a_height'.
		do
			if
				drawable /= default_pointer and then
				a_width > 0 and a_height > 0
			then
				{GTK}.gdk_draw_arc (
					drawable,
					gc,
					0,
					(x + device_x_offset).max ({INTEGER_16}.min_value).min ({INTEGER_16}.max_value),
					(y + device_y_offset).max ({INTEGER_16}.min_value).min ({INTEGER_16}.max_value),
					a_width - 1,
					a_height - 1,
					0,
					whole_circle
				)
				update_if_needed
			end
		end

	draw_polyline (points: ARRAY [EV_COORDINATE]; is_closed: BOOLEAN)
			-- Draw line segments between subsequent points in
			-- `points'. If `is_closed' draw line segment between first
			-- and last point in `points'.
		local
			tmp: SPECIAL [INTEGER]
		do
			if drawable /= default_pointer then
				tmp := coord_array_to_gdkpoint_array (points).area
				if is_closed then
					{GTK}.gdk_draw_polygon (drawable, gc, 0, $tmp, points.count)
					update_if_needed
				else
					{GTK}.gdk_draw_lines (drawable, gc, $tmp, points.count)
					update_if_needed
				end
			end
		end

	draw_pie_slice (x, y, a_width, a_height: INTEGER; a_start_angle, an_aperture: REAL)
			-- Draw a part of an ellipse bounded by top left (`x', `y') with
			-- size `a_width' and `a_height'.
			-- Start at `a_start_angle' and stop at `a_start_angle' + `an_aperture'.
			-- The arc is then closed by two segments through (`x', `y').
			-- Angles are measured in radians
		local
			left, top: INTEGER
			x_start_arc, y_start_arc, x_end_arc, y_end_arc: INTEGER
			semi_width, semi_height: REAL
			tang_start, tang_end: REAL
			x_tmp, y_tmp: REAL
		do
			left := x.max ({INTEGER_16}.min_value).min ({INTEGER_16}.max_value)
			top := y.max ({INTEGER_16}.min_value).min ({INTEGER_16}.max_value)

			semi_width := (a_width / 2).truncated_to_real
			semi_height := (a_height / 2).truncated_to_real
			tang_start := tangent (a_start_angle)
			tang_end := tangent (a_start_angle + an_aperture)

			x_tmp := semi_height / sqrt (tang_start * tang_start + (semi_height * semi_height) / (semi_width * semi_width))
			y_tmp := semi_height / sqrt (1 + (semi_height * semi_height) / (semi_width * semi_width * tang_start * tang_start))
			if sine (a_start_angle) > 0 then
				y_tmp := -y_tmp
			end
			if cosine (a_start_angle) < 0 then
				x_tmp := -x_tmp
			end
			x_start_arc := (x_tmp + left + semi_width).rounded
			y_start_arc := (y_tmp + top + semi_height).rounded

			x_tmp := semi_height / sqrt (tang_end * tang_end + (semi_height * semi_height) / (semi_width * semi_width))
			y_tmp := semi_height / sqrt (1 + (semi_height * semi_height) / (semi_width * semi_width * tang_end * tang_end))
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

	fill_rectangle (x, y, a_width, a_height: INTEGER)
			-- Draw rectangle with upper-left corner on (`x', `y')
			-- with size `a_width' and `a_height'. Fill with `background_color'.
		do
			if drawable /= default_pointer then
				if tile /= Void then
					{GTK}.gdk_gc_set_fill (gc, {GTK}.Gdk_tiled_enum)
				end
				{GTK}.gdk_draw_rectangle (
					drawable,
					gc,
					1,
					(x + device_x_offset).max ({INTEGER_16}.min_value).min ({INTEGER_16}.max_value),
					(y + device_y_offset).max ({INTEGER_16}.min_value).min ({INTEGER_16}.max_value),
					a_width,
					a_height
				)
				{GTK}.gdk_gc_set_fill (gc, {GTK}.Gdk_solid_enum)
				update_if_needed
			end
		end

	fill_ellipse (x, y, a_width, a_height: INTEGER)
			-- Draw an ellipse bounded by top left (`x', `y') with
			-- size `a_width' and `a_height'.
			-- Fill with `background_color'.
		do
			if drawable /= default_pointer then
				if tile /= Void then
					{GTK}.gdk_gc_set_fill (gc, {GTK}.Gdk_tiled_enum)
				end
				{GTK}.gdk_draw_arc (drawable, gc, 1, (x + device_x_offset).max ({INTEGER_16}.min_value).min ({INTEGER_16}.max_value),
					(y + device_y_offset).max ({INTEGER_16}.min_value).min ({INTEGER_16}.max_value), a_width,
					a_height, 0, whole_circle)
				update_if_needed
				{GTK}.gdk_gc_set_fill (gc, {GTK}.Gdk_solid_enum)
			end
		end

	fill_polygon (points: ARRAY [EV_COORDINATE])
			-- Draw line segments between subsequent points in `points'.
			-- Fill all enclosed area's with `background_color'.
		local
			tmp: SPECIAL [INTEGER]
		do
			if drawable /= default_pointer then
				tmp := coord_array_to_gdkpoint_array (points).area
				if tile /= Void then
					{GTK}.gdk_gc_set_fill (gc, {GTK}.Gdk_tiled_enum)
				end
				{GTK}.gdk_draw_polygon (drawable, gc, 1, $tmp, points.count)
				{GTK}.gdk_gc_set_fill (gc, {GTK}.Gdk_solid_enum)
				update_if_needed
			end
		end

	fill_pie_slice (x, y, a_width, a_height: INTEGER; a_start_angle, an_aperture: REAL)
			-- Draw a part of an ellipse bounded by top left (`x', `y') with
			-- size `a_width' and `a_height'.
			-- Start at `a_start_angle' and stop at `a_start_angle' + `an_aperture'.
			-- The arc is then closed by two segments through (`x', `y').
			-- Angles are measured in radians.
		do
			if drawable /= default_pointer then
				if tile /= Void then
					{GTK}.gdk_gc_set_fill (gc, {GTK}.Gdk_tiled_enum)
				end
				{GTK}.gdk_draw_arc (
					drawable,
					gc,
					1,
					(x + device_x_offset).max ({INTEGER_16}.min_value).min ({INTEGER_16}.max_value),
					(y + device_y_offset).max ({INTEGER_16}.min_value).min ({INTEGER_16}.max_value),
					a_width,
					a_height,
					(a_start_angle * radians_to_gdk_angle).truncated_to_integer,
					(an_aperture * radians_to_gdk_angle).truncated_to_integer
				)
				{GTK}.gdk_gc_set_fill (gc, {GTK}.Gdk_solid_enum)
				update_if_needed
			end
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
		local
			l_mask_pix, l_temp_pix: POINTER
			l_null: POINTER
		do
			Result := {GTK2}.gdk_pixbuf_get_from_drawable (l_null, drawable, l_null, src_x + device_x_offset, src_y + device_y_offset, dest_x, dest_y, a_width, a_height)

			if Result = l_null then
					-- Cannot get pixbuf from `drawable', just create an empty one
					-- to ensure that there is no failure, just a bad display.
				Result := {GTK}.gdk_pixbuf_new (0, True, 8, a_width, a_height)
			elseif mask /= l_null then
				l_mask_pix := {GTK2}.gdk_pixbuf_get_from_drawable (l_null, mask, l_null, src_x, src_y, dest_x, dest_y, a_width, a_height)
						-- If mask could not be allocated, keep `Result` without masking.
				if l_mask_pix /= l_null then
						-- Add alpha channel to `l_mask_pix' as required by
						-- `draw_mask_on_pixbuf' since the creation of `l_mask_pix'
						-- above will only create a RGB image without alpha channel
					l_temp_pix := l_mask_pix
					l_mask_pix := {GTK2}.gdk_pixbuf_add_alpha (l_mask_pix, True, 255, 255, 255)
						-- Free the original `l_mask_pix' as it was replaced by a new
						-- one with alpha channel.
					{GOBJECT}.g_object_unref (l_temp_pix)

						-- Add alpha channel to Result as required by
						-- `draw_mask_on_pixbuf' since the creation of `Result'
						-- above will only create a RGB image without alpha channel
					l_temp_pix := Result
					Result := {GTK2}.gdk_pixbuf_add_alpha (Result, False, 0, 0, 0)
						-- Free the original `Result' as it was replaced by a new
						-- one with alpha channel.
					{GOBJECT}.g_object_unref (l_temp_pix)

						-- Draw mask on top of pixbuf.
					{GTK2}.gdk_pixbuf_composite (l_mask_pix, Result, 0, 0, a_width, a_height, 0.0, 0.0, 1.0, 1.0, {GTK2}.gdk_interp_bilinear, 255)

					draw_mask_on_pixbuf (Result, l_mask_pix)

						-- Clean up
					{GOBJECT}.g_object_unref (l_mask_pix)
				end
			end
		end

	pixbuf_from_drawable_with_size (a_width, a_height: INTEGER): POINTER
			-- Return a GdkPixbuf object from the current Gdkpixbuf structure with dimensions `a_width' * `a_height'
		local
			a_pixbuf: POINTER
		do
			a_pixbuf := pixbuf_from_drawable
			Result := {GTK2}.gdk_pixbuf_scale_simple (a_pixbuf, a_width, a_height, {GTK2}.gdk_interp_bilinear)
			{GOBJECT}.g_object_unref (a_pixbuf)
		end

feature {NONE} -- Implementation

	device_x_offset: INTEGER_16
			-- Number of pixels to offset the x coord to get correct device placement

	device_y_offset: INTEGER_16
			-- Number of pixels to offset to y coord to get correct device placement.

	internal_set_color (a_foreground: BOOLEAN; a_red, a_green, a_blue: INTEGER_32)
			-- Set `gc' color to (a_red, a_green, a_blue), `a_foreground' sets foreground color, otherwise background is set.
		local
			l_color_struct: POINTER
		do
			l_color_struct := App_implementation.reusable_color_struct
			{GTK}.set_gdk_color_struct_red (l_color_struct, a_red)
			{GTK}.set_gdk_color_struct_green (l_color_struct, a_green)
			{GTK}.set_gdk_color_struct_blue (l_color_struct, a_blue)
			if a_foreground then
				{GTK2}.gdk_gc_set_rgb_fg_color (gc, l_color_struct)
			else
				{GTK2}.gdk_gc_set_rgb_bg_color (gc, l_color_struct)
			end
		end

	fg_color: POINTER
			-- Default allocated background color.
		once
			Result := {GTK}.c_gdk_color_struct_allocate
			{GTK}.gdk_colormap_alloc_color ({GTK2}.gdk_screen_get_rgb_colormap ({GTK2}.gdk_screen_get_default), Result, False, True).do_nothing
		end

	bg_color: POINTER
			-- Default allocate foreground color.
		once
			Result := {GTK}.c_gdk_color_struct_allocate
			{GTK}.set_gdk_color_struct_red (Result, 65535)
			{GTK}.set_gdk_color_struct_green (Result, 65535)
			{GTK}.set_gdk_color_struct_blue (Result, 65535)
			{GTK}.gdk_colormap_alloc_color ({GTK2}.gdk_screen_get_rgb_colormap ({GTK2}.gdk_screen_get_default), Result, False, True).do_nothing
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

	corruptable_onscreen: BOOLEAN
			-- Is pixel data corruptable if displayed on screen.
			-- True if drawing area or screen.
		do
			Result := True
		end

	flush
			-- Force all queued expose events to be called.
		deferred
		end

	update_if_needed
			-- Force update of `Current' if needed
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

	gdk_gc_unref (a_gc: POINTER)
			-- void   gdk_gc_unref		  (GdkGC	    *gc);
		external
			"C (GdkGC*) | <ev_gtk.h>"
		end

	set_dashes_pattern (a_gc, dash_pattern: POINTER)
			-- Set the dashes pattern for gc `a_gc', `dash_pattern' is a pointer to a two count gint8[]] denoting the pattern.
		external
			"C inline use <ev_gtk.h>"
		alias
			"gdk_gc_set_dashes ((GdkGC*) $a_gc, 0, (gint8*) $dash_pattern, 2)"
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_DRAWABLE note option: stable attribute end;

invariant
	gc_not_void: is_usable implies gc /= default_pointer

note
	copyright:	"Copyright (c) 1984-2019, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
