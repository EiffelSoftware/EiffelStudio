note
	description: "Wrappers around the Cairo drawing API."
	date: "$Date$"
	revision: "$Revision$"

class
	CAIRO

feature -- Constants

    FORMAT_INVALID: INTEGER_8 = -1
    FORMAT_ARGB32: INTEGER_8  = 0
    FORMAT_RGB24: INTEGER_8   = 1
    FORMAT_A8: INTEGER_8        = 2
    FORMAT_A1: INTEGER_8        = 3
    FORMAT_RGB16_565: INTEGER_8 = 4
    FORMAT_RGB30: INTEGER_8     = 5

    ANTIALIAS_DEFAULT: INTEGER_8 = 0
    ANTIALIAS_NONE: INTEGER_8 = 1
    ANTIALIAS_GRAY: INTEGER_8 = 2
    ANTIALIAS_SUBPIXEL: INTEGER_8 = 3
    ANTIALIAS_FAST: INTEGER_8 = 4
    ANTIALIAS_GOOD: INTEGER_8 = 5
    ANTIALIAS_BEST: INTEGER_8 = 6

    LINE_CAP_BUTT: INTEGER_8 = 0
    LINE_CAP_ROUND: INTEGER_8 = 1
    LINE_CAP_SQUARE: INTEGER_8 = 2

	OPERATOR_SOURCE: INTEGER_8
		external
			"C macro use <cairo.h>"
		alias
			"CAIRO_OPERATOR_SOURCE"
		end

	OPERATOR_OVER: INTEGER_8
		external
			"C macro use <cairo.h>"
		alias
			"CAIRO_OPERATOR_OVER"
		end

	OPERATOR_IN: INTEGER_8
		external
			"C macro use <cairo.h>"
		alias
			"CAIRO_OPERATOR_IN"
		end

	OPERATOR_OUT: INTEGER_8
		external
			"C macro use <cairo.h>"
		alias
			"CAIRO_OPERATOR_OUT"
		end

	OPERATOR_XOR: INTEGER_8
		external
			"C macro use <cairo.h>"
		alias
			"CAIRO_OPERATOR_XOR"
		end

	OPERATOR_ADD: INTEGER_8
		external
			"C macro use <cairo.h>"
		alias
			"CAIRO_OPERATOR_ADD"
		end

	OPERATOR_ATOP: INTEGER_8
		external
			"C macro use <cairo.h>"
		alias
			"CAIRO_OPERATOR_ATOP"
		end

	OPERATOR_DEST: INTEGER_8
		external
			"C macro use <cairo.h>"
		alias
			"CAIRO_OPERATOR_DEST"
		end

	OPERATOR_DEST_OVER: INTEGER_8
		external
			"C macro use <cairo.h>"
		alias
			"CAIRO_OPERATOR_DEST_OVER"
		end

	OPERATOR_DEST_IN: INTEGER_8
		external
			"C macro use <cairo.h>"
		alias
			"CAIRO_OPERATOR_DEST_IN"
		end

	OPERATOR_DEST_OUT: INTEGER_8
		external
			"C macro use <cairo.h>"
		alias
			"CAIRO_OPERATOR_DEST_OUT"
		end

	OPERATOR_DEST_ATOP: INTEGER_8
		external
			"C macro use <cairo.h>"
		alias
			"CAIRO_OPERATOR_DEST_ATOP"
		end

	OPERATOR_DIFFERENCE: INTEGER_8
		external
			"C macro use <cairo.h>"
		alias
			"CAIRO_OPERATOR_DIFFERENCE"
		end

	OPERATOR_EXCLUSION: INTEGER_8
		external
			"C macro use <cairo.h>"
		alias
			"CAIRO_OPERATOR_EXCLUSION"
		end

	OPERATOR_MULTIPLY: INTEGER_8
		external
			"C macro use <cairo.h>"
		alias
			"CAIRO_OPERATOR_MULTIPLY"
		end

feature -- Externals

	clip (cr: POINTER)
		external
			"C signature (cairo_t*) use <cairo.h>"
		alias
			"cairo_clip"
		end

	reset_clip (cr: POINTER)
		external
			"C signature (cairo_t*) use <cairo.h>"
		alias
			"cairo_reset_clip"
		end

	clip_extents (cr: POINTER; a_x1, a_y1, a_x2, a_y2: TYPED_POINTER [REAL_64])
		external
			"C signature (cairo_t*, double*, double*, double*, double*) use <cairo.h>"
		alias
			"cairo_clip_extents"
		end

	copy_clip_rectangle_list (cr: POINTER): POINTER
		external
			"C signature (cairo_t*): cairo_rectangle_list_t* use <cairo.h>"
		alias
			"cairo_copy_clip_rectangle_list"
		end

	region_get_extents (a_region: POINTER; a_rectangle: POINTER)
		external
			"C signature (cairo_region_t*, cairo_rectangle_int_t*) use <cairo.h>"
		alias
			"cairo_region_get_extents"
		end

	rectangle_int_struct_size: INTEGER
		external
			"C macro use <cairo.h>"
		alias
			"sizeof(cairo_rectangle_int_t)"
		end

	rectangle_struct_size: INTEGER
		external
			"C macro use <cairo.h>"
		alias
			"sizeof(cairo_rectangle_t)"
		end

	set_source (cr: POINTER; source: POINTER)
		external
			"C signature (cairo_t*, cairo_pattern_t*) use <cairo.h>"
		alias
			"cairo_set_source"
		end

	paint_with_alpha (cr: POINTER; alpha: REAL_64)
		external
			"C signature (cairo_t*, double) use <cairo.h>"
		alias
			"cairo_paint_with_alpha"
		end

	mask (cr: POINTER; pattern: POINTER)
		external
			"C signature (cairo_t*, cairo_pattern_t*) use <cairo.h>"
		alias
			"cairo_mask"
		end

	mask_surface (cr: POINTER; surface: POINTER; surface_x: REAL_64; surface_y: REAL_64)
		external
			"C signature (cairo_t*, cairo_surface_t*, double, double) use <cairo.h>"
		alias
			"cairo_mask_surface"
		end

	set_source_surface (cr: POINTER; surface: POINTER; x: REAL_64; y: REAL_64)
		external
			"C signature (cairo_t*, cairo_surface_t*, double, double) use <cairo.h>"
		alias
			"cairo_set_source_surface"
		end

	create_context (target: POINTER): POINTER
		external
			"C signature (cairo_surface_t*): cairo_t* use <cairo.h>"
		alias
			"cairo_create"
		end

	add_reference (cr: POINTER): POINTER
		external
			"C signature (cairo_t*): cairo_t* use <cairo.h>"
		alias
			"cairo_reference"
		end

	destroy (cr: POINTER)
		external
			"C signature (cairo_t*) use <cairo.h>"
		alias
			"cairo_destroy"
		end

	status (cr: POINTER): INTEGER
		external
			"C signature (cairo_t*): cairo_status_t use <cairo.h>"
		alias
			"cairo_status"
		end

	surface_destroy (cr: POINTER)
		external
			"C signature (cairo_surface_t*) use <cairo.h>"
		alias
			"cairo_surface_destroy"
		end

	get_reference_count (cr: POINTER): NATURAL_32
		external
			"C signature (cairo_t*): unsigned int use <cairo.h>"
		alias
			"cairo_get_reference_count"
		end

	surface_flush (surface: POINTER)
		external
			"C signature (cairo_surface_t*) use <cairo.h>"
		alias
			"cairo_surface_flush"
		end

	surface_mark_dirty (surface: POINTER)
		external
			"C signature (cairo_surface_t*) use <cairo.h>"
		alias
			"cairo_surface_mark_dirty"
		end

	surface_mark_dirty_rectangle (surface: POINTER; x: INTEGER_32; y: INTEGER_32; width: INTEGER_32; height: INTEGER_32)
		external
			"C signature (cairo_surface_t*, int, int, int, int) use <cairo.h>"
		alias
			"cairo_surface_mark_dirty_rectangle"
		end

	surface_set_device_offset (surface: POINTER; x_offset: REAL_64; y_offset: REAL_64)
		external
			"C signature (cairo_surface_t*, double, double) use <cairo.h>"
		alias
			"cairo_surface_set_device_offset"
		end

	surface_get_device_offset (surface: POINTER; x_offset: TYPED_POINTER [REAL_64]; y_offset: TYPED_POINTER [REAL_64])
		external
			"C signature (cairo_surface_t*, double*, double*) use <cairo.h>"
		alias
			"cairo_surface_get_device_offset"
		end

	surface_set_fallback_resolution (surface: POINTER; x_pixels_per_inch: REAL_64; y_pixels_per_inch: REAL_64)
		external
			"C signature (cairo_surface_t*, double, double) use <cairo.h>"
		alias
			"cairo_surface_set_fallback_resolution"
		end

	surface_get_fallback_resolution (surface: POINTER; x_pixels_per_inch: TYPED_POINTER [REAL_64]; y_pixels_per_inch: TYPED_POINTER [REAL_64])
		external
			"C signature (cairo_surface_t*, double*, double*) use <cairo.h>"
		alias
			"cairo_surface_get_fallback_resolution"
		end

	surface_copy_page (surface: POINTER)
		external
			"C signature (cairo_surface_t*) use <cairo.h>"
		alias
			"cairo_surface_copy_page"
		end

	surface_show_page (surface: POINTER)
		external
			"C signature (cairo_surface_t*) use <cairo.h>"
		alias
			"cairo_surface_show_page"
		end

	surface_has_show_text_glyphs (surface: POINTER): BOOLEAN
		external
			"C signature (cairo_surface_t*): cairo_bool_t use <cairo.h>"
		alias
			"cairo_surface_has_show_text_glyphs"
		end

	surface_get_type (surface: POINTER): INTEGER_8
		external
			"C signature (cairo_surface_t*): cairo_surface_type_t use <cairo.h>"
		alias
			"cairo_surface_get_type"
		end

	surface_get_content (surface: POINTER): INTEGER_8
		external
			"C signature (cairo_surface_t*): cairo_content_t use <cairo.h>"
		alias
			"cairo_surface_get_content"
		end

	surface_write_to_png (surface: POINTER; filename: POINTER): INTEGER_8
		external
			"C signature (cairo_surface_t*, char*): cairo_status_t use <cairo.h>"
		alias
			"cairo_surface_write_to_png"
		end

	image_surface_create (format: INTEGER_8; width: INTEGER_32; height: INTEGER_32): POINTER
		external
			"C signature (cairo_format_t, int, int): cairo_surface_t* use <cairo.h>"
		alias
			"cairo_image_surface_create"
		end

	format_stride_for_width (format: INTEGER_8; width: INTEGER_32): INTEGER_32
		external
			"C signature (cairo_format_t, int): int use <cairo.h>"
		alias
			"cairo_format_stride_for_width"
		end

	image_surface_create_for_data (data: TYPED_POINTER [NATURAL_8]; format: INTEGER_8; width: INTEGER_32; height: INTEGER_32; stride: INTEGER_32): POINTER
		external
			"C signature (unsigned char*, cairo_format_t, int, int, int): cairo_surface_t* use <cairo.h>"
		alias
			"cairo_image_surface_create_for_data"
		end

	image_surface_get_data (surface: POINTER): TYPED_POINTER [NATURAL_8]
		external
			"C signature (cairo_surface_t*): unsigned char* use <cairo.h>"
		alias
			"cairo_image_surface_get_data"
		end

	image_surface_get_format (surface: POINTER): INTEGER_8
		external
			"C signature (cairo_surface_t*): cairo_format_t use <cairo.h>"
		alias
			"cairo_image_surface_get_format"
		end

	image_surface_get_width (surface: POINTER): INTEGER_32
		external
			"C signature (cairo_surface_t*): int use <cairo.h>"
		alias
			"cairo_image_surface_get_width"
		end

	image_surface_get_height (surface: POINTER): INTEGER_32
		external
			"C signature (cairo_surface_t*): int use <cairo.h>"
		alias
			"cairo_image_surface_get_height"
		end

	new_path (cr: POINTER)
		external
			"C signature (cairo_t*) use <cairo.h>"
		alias
			"cairo_new_path"
		end

	save (cr: POINTER)
		external
			"C signature (cairo_t*) use <cairo.h>"
		alias
			"cairo_save"
		end

	restore (cr: POINTER)
		external
			"C signature (cairo_t*) use <cairo.h>"
		alias
			"cairo_restore"
		end

	push_group (cr: POINTER)
		external
			"C signature (cairo_t*) use <cairo.h>"
		alias
			"cairo_push_group"
		end

	push_group_with_content (cr: POINTER; content: INTEGER_8)
		external
			"C signature (cairo_t*, cairo_content_t) use <cairo.h>"
		alias
			"cairo_push_group_with_content"
		end

	pop_group (cr: POINTER): POINTER
		external
			"C signature (cairo_t*): cairo_pattern_t* use <cairo.h>"
		alias
			"cairo_pop_group"
		end

	pop_group_to_source (cr: POINTER)
		external
			"C signature (cairo_t*) use <cairo.h>"
		alias
			"cairo_pop_group_to_source"
		end

	set_operator (cr: POINTER; op: INTEGER_8)
		external
			"C signature (cairo_t*, cairo_operator_t) use <cairo.h>"
		alias
			"cairo_set_operator"
		end

	set_antialias (cr: POINTER; op: INTEGER_8)
		external
			"C signature (cairo_t*, cairo_antialias_t) use <cairo.h>"
		alias
			"cairo_set_antialias"
		end

	 set_dashed_line_style (cr: POINTER; is_enabled: BOOLEAN)
		external
			"C inline use <cairo.h>"
		alias
			"[
				double len = 2.0;
				if ($is_enabled) {
					cairo_set_dash ((cairo_t *) $cr, &len, 1, 0.0);
				} else {
					cairo_set_dash ((cairo_t *) $cr, NULL, 0, 0.0);
				}
			]"
		end

	font_options_set_antialias (cr: POINTER; op: INTEGER_8)
		external
			"C signature (cairo_font_options_t*, cairo_antialias_t) use <cairo.h>"
		alias
			"cairo_font_options_set_antialias"
		end

	font_options_get_antialias (cr: POINTER): INTEGER_8
		external
			"C signature (cairo_font_options_t*): cairo_antialias_t use <cairo.h>"
		alias
			"cairo_font_options_get_antialias"
		end

	fill (cr: POINTER)
		external
			"C signature (cairo_t*) use <cairo.h>"
		alias
			"cairo_fill"
		end

	fill_preserve (cr: POINTER)
		external
			"C signature (cairo_t*) use <cairo.h>"
		alias
			"cairo_fill_preserve"
		end

	translate (cr: POINTER; tx: REAL_64; ty: REAL_64)
		external
			"C signature (cairo_t*, double, double) use <cairo.h>"
		alias
			"cairo_translate"
		end

	scale (cr: POINTER; sx: REAL_64; sy: REAL_64)
		external
			"C signature (cairo_t*, double, double) use <cairo.h>"
		alias
			"cairo_scale"
		end

	rotate (cr: POINTER; angle: REAL_64)
		external
			"C signature (cairo_t*, double) use <cairo.h>"
		alias
			"cairo_rotate"
		end

	paint (cr: POINTER)
		external
			"C signature (cairo_t*) use <cairo.h>"
		alias
			"cairo_paint"
		end

	stroke (cr: POINTER)
		external
			"C signature (cairo_t*) use <cairo.h>"
		alias
			"cairo_stroke"
		end

	stroke_preserve (cr: POINTER)
		external
			"C signature (cairo_t*) use <cairo.h>"
		alias
			"cairo_stroke_preserve"
		end

	move_to (cr: POINTER; x: REAL_64; y: REAL_64)
		external
			"C signature (cairo_t*, double, double) use <cairo.h>"
		alias
			"cairo_move_to"
		end

	line_to (cr: POINTER; x: REAL_64; y: REAL_64)
		external
			"C signature (cairo_t*, double, double) use <cairo.h>"
		alias
			"cairo_line_to"
		end

	rectangle (cr: POINTER; x: REAL_64; y: REAL_64; width: REAL_64; height: REAL_64)
		external
			"C signature (cairo_t*, double, double, double, double) use <cairo.h>"
		alias
			"cairo_rectangle"
		end

	set_source_rgba (cr: POINTER; red: REAL_64; green: REAL_64; blue: REAL_64; alpha: REAL_64)
		external
			"C signature (cairo_t*, double, double, double, double) use <cairo.h>"
		alias
			"cairo_set_source_rgba"
		end

	set_source_rgb (cr: POINTER; red: REAL_64; green: REAL_64; blue: REAL_64)
		external
			"C signature (cairo_t*, double, double, double) use <cairo.h>"
		alias
			"cairo_set_source_rgb"
		end

	curve_to (cr: POINTER; x1: REAL_64; y1: REAL_64; x2: REAL_64; y2: REAL_64; x3: REAL_64; y3: REAL_64)
		external
			"C signature (cairo_t*, double, double, double, double, double, double) use <cairo.h>"
		alias
			"cairo_curve_to"
		end

	arc (cr: POINTER; xc: REAL_64; yc: REAL_64; radius: REAL_64; angle1: REAL_64; angle2: REAL_64)
		external
			"C signature (cairo_t*, double, double, double, double, double) use <cairo.h>"
		alias
			"cairo_arc"
		end

	arc_negative (cr: POINTER; xc: REAL_64; yc: REAL_64; radius: REAL_64; angle1: REAL_64; angle2: REAL_64)
		external
			"C signature (cairo_t*, double, double, double, double, double) use <cairo.h>"
		alias
			"cairo_arc_negative"
		end

	set_line_width (cr: POINTER; width: REAL_64)
		external
			"C signature (cairo_t*, double) use <cairo.h>"
		alias
			"cairo_set_line_width"
		end

	set_line_cap (cr: POINTER; line_cap: INTEGER_8)
		external
			"C signature (cairo_t*, cairo_line_cap_t) use <cairo.h>"
		alias
			"cairo_set_line_cap"
		end

	set_line_join (cr: POINTER; line_join: INTEGER_8)
		external
			"C signature (cairo_t*, cairo_line_join_t) use <cairo.h>"
		alias
			"cairo_set_line_join"
		end

	rel_move_to (cr: POINTER; dx: REAL_64; dy: REAL_64)
		external
			"C signature (cairo_t*, double, double) use <cairo.h>"
		alias
			"cairo_rel_move_to"
		end

	rel_line_to (cr: POINTER; dx: REAL_64; dy: REAL_64)
		external
			"C signature (cairo_t*, double, double) use <cairo.h>"
		alias
			"cairo_rel_line_to"
		end

	rel_curve_to (cr: POINTER; dx1: REAL_64; dy1: REAL_64; dx2: REAL_64; dy2: REAL_64; dx3: REAL_64; dy3: REAL_64)
		external
			"C signature (cairo_t*, double, double, double, double, double, double) use <cairo.h>"
		alias
			"cairo_rel_curve_to"
		end

	close_path (cr: POINTER)
		external
			"C signature (cairo_t*) use <cairo.h>"
		alias
			"cairo_close_path"
		end

note
	copyright: "Copyright (c) 1984-2016, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
