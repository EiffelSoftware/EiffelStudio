note
	description: "Summary description for {CAIRO}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CAIRO

feature

    CAIRO_FORMAT_INVALID: INTEGER_8 = -1
    CAIRO_FORMAT_ARGB32: INTEGER_8  = 0
    CAIRO_FORMAT_RGB24: INTEGER_8   = 1
    CAIRO_FORMAT_A8: INTEGER_8        = 2
    CAIRO_FORMAT_A1: INTEGER_8        = 3
    CAIRO_FORMAT_RGB16_565: INTEGER_8 = 4
    CAIRO_FORMAT_RGB30: INTEGER_8     = 5

    CAIRO_ANTIALIAS_DEFAULT: INTEGER_8 = 0
    CAIRO_ANTIALIAS_NONE: INTEGER_8 = 1
    CAIRO_ANTIALIAS_GRAY: INTEGER_8 = 2
    CAIRO_ANTIALIAS_SUBPIXEL: INTEGER_8 = 3
    CAIRO_ANTIALIAS_FAST: INTEGER_8 = 4
    CAIRO_ANTIALIAS_GOOD: INTEGER_8 = 5
    CAIRO_ANTIALIAS_BEST: INTEGER_8 = 6

	CAIRO_OPERATOR_SOURCE: INTEGER_8
		external
			"C macro use <cairo.h>"
		alias
			"CAIRO_OPERATOR_SOURCE"
		end

	CAIRO_OPERATOR_OVER: INTEGER_8
		external
			"C macro use <cairo.h>"
		alias
			"CAIRO_OPERATOR_OVER"
		end

	CAIRO_OPERATOR_IN: INTEGER_8
		external
			"C macro use <cairo.h>"
		alias
			"CAIRO_OPERATOR_IN"
		end

	CAIRO_OPERATOR_OUT: INTEGER_8
		external
			"C macro use <cairo.h>"
		alias
			"CAIRO_OPERATOR_OUT"
		end

	CAIRO_OPERATOR_XOR: INTEGER_8
		external
			"C macro use <cairo.h>"
		alias
			"CAIRO_OPERATOR_XOR"
		end

	CAIRO_OPERATOR_ADD: INTEGER_8
		external
			"C macro use <cairo.h>"
		alias
			"CAIRO_OPERATOR_ADD"
		end

	CAIRO_OPERATOR_DEST: INTEGER_8
		external
			"C macro use <cairo.h>"
		alias
			"CAIRO_OPERATOR_DEST"
		end

	CAIRO_OPERATOR_DEST_OVER: INTEGER_8
		external
			"C macro use <cairo.h>"
		alias
			"CAIRO_OPERATOR_DEST_OVER"
		end

	CAIRO_OPERATOR_DEST_IN: INTEGER_8
		external
			"C macro use <cairo.h>"
		alias
			"CAIRO_OPERATOR_DEST_IN"
		end

	CAIRO_OPERATOR_DEST_OUT: INTEGER_8
		external
			"C macro use <cairo.h>"
		alias
			"CAIRO_OPERATOR_DEST_OUT"
		end

	CAIRO_OPERATOR_DEST_ATOP: INTEGER_8
		external
			"C macro use <cairo.h>"
		alias
			"CAIRO_OPERATOR_DEST_ATOP"
		end

	CAIRO_OPERATOR_DIFFERENCE: INTEGER_8
		external
			"C macro use <cairo.h>"
		alias
			"CAIRO_OPERATOR_DIFFERENCE"
		end

	cairo_clip_extents (cr: POINTER; x1: TYPED_POINTER [REAL_64]; y1: TYPED_POINTER [REAL_64]; x2: TYPED_POINTER [REAL_64]; y2: TYPED_POINTER [REAL_64])
		external
			"C signature (cairo_t*, double*, double*, double*, double*) use <cairo.h>"
		end

	cairo_copy_clip_rectangle_list (cr: POINTER): POINTER
		external
			"C signature (cairo_t*): cairo_rectangle_list_t* use <cairo.h>"
		end

	cairo_rectangle_list_t_get_status (a_rectangle_list_t: POINTER): INTEGER
		external
			"C [struct <cairo.h>] (cairo_rectangle_list_t): cairo_status_t"
		alias
			"status"
		end

	cairo_rectangle_list_t_get_rectangles (a_rectangle_list_t: POINTER): POINTER
		external
			"C [struct <cairo.h>] (cairo_rectangle_list_t): EIF_POINTER"
		alias
			"rectangles"
		end

	cairo_rectangle_list_t_get_num_rectangles (a_rectangle_list_t: POINTER): INTEGER
		external
			"C [struct <cairo.h>] (cairo_rectangle_list_t): int"
		alias
			"num_rectangles"
		end

	cairo_region_num_rectangles (a_region: POINTER): INTEGER_32
		external
			"C signature (cairo_region_t*): int use <cairo.h>"
		end

	cairo_region_get_rectangle (a_region: POINTER; nth: INTEGER_32; a_rectangle: POINTER)
		external
			"C signature (cairo_region_t*, int, cairo_rectangle_int_t*) use <cairo.h>"
		end

	cairo_region_get_extents (a_region: POINTER; a_rectangle: POINTER)
		external
			"C signature (cairo_region_t*, cairo_rectangle_int_t*) use <cairo.h>"
		end

	cairo_rectangle_int_t_size: INTEGER
		external
			"C macro use <cairo.h>"
		alias
			"sizeof(cairo_rectangle_int_t)"
		end

	cairo_rectangle_t_size: INTEGER
		external
			"C macro use <cairo.h>"
		alias
			"sizeof(cairo_rectangle_t)"
		end

	cairo_set_source (cr: POINTER; source: POINTER)
		external
			"C signature (cairo_t*, cairo_pattern_t*) use <cairo.h>"
		end

	cairo_paint_with_alpha (cr: POINTER; alpha: REAL_64)
		external
			"C signature (cairo_t*, double) use <cairo.h>"
		end

	cairo_mask (cr: POINTER; pattern: POINTER)
		external
			"C signature (cairo_t*, cairo_pattern_t*) use <cairo.h>"
		end

	cairo_mask_surface (cr: POINTER; surface: POINTER; surface_x: REAL_64; surface_y: REAL_64)
		external
			"C signature (cairo_t*, cairo_surface_t*, double, double) use <cairo.h>"
		end

	cairo_set_source_surface (cr: POINTER; surface: POINTER; x: REAL_64; y: REAL_64)
		external
			"C signature (cairo_t*, cairo_surface_t*, double, double) use <cairo.h>"
		end

	cairo_create (target: POINTER): POINTER
		external
			"C signature (cairo_surface_t*): cairo_t* use <cairo.h>"
		end

	cairo_reference (cr: POINTER): POINTER
		external
			"C signature (cairo_t*): cairo_t* use <cairo.h>"
		end

	cairo_destroy (cr: POINTER)
		external
			"C signature (cairo_t*) use <cairo.h>"
		end

	cairo_status (cr: POINTER): INTEGER
		external
			"C signature (cairo_t*): cairo_status_t use <cairo.h>"
		end

	cairo_surface_destroy (cr: POINTER)
		external
			"C signature (cairo_surface_t*) use <cairo.h>"
		end

	cairo_get_reference_count (cr: POINTER): NATURAL_32
		external
			"C signature (cairo_t*): unsigned int use <cairo.h>"
		end

	cairo_surface_flush (surface: POINTER)
		external
			"C signature (cairo_surface_t*) use <cairo.h>"
		end

	cairo_surface_mark_dirty (surface: POINTER)
		external
			"C signature (cairo_surface_t*) use <cairo.h>"
		end

	cairo_surface_mark_dirty_rectangle (surface: POINTER; x: INTEGER_32; y: INTEGER_32; width: INTEGER_32; height: INTEGER_32)
		external
			"C signature (cairo_surface_t*, int, int, int, int) use <cairo.h>"
		end

	cairo_surface_set_device_offset (surface: POINTER; x_offset: REAL_64; y_offset: REAL_64)
		external
			"C signature (cairo_surface_t*, double, double) use <cairo.h>"
		end

	cairo_surface_get_device_offset (surface: POINTER; x_offset: TYPED_POINTER [REAL_64]; y_offset: TYPED_POINTER [REAL_64])
		external
			"C signature (cairo_surface_t*, double*, double*) use <cairo.h>"
		end

	cairo_surface_set_fallback_resolution (surface: POINTER; x_pixels_per_inch: REAL_64; y_pixels_per_inch: REAL_64)
		external
			"C signature (cairo_surface_t*, double, double) use <cairo.h>"
		end

	cairo_surface_get_fallback_resolution (surface: POINTER; x_pixels_per_inch: TYPED_POINTER [REAL_64]; y_pixels_per_inch: TYPED_POINTER [REAL_64])
		external
			"C signature (cairo_surface_t*, double*, double*) use <cairo.h>"
		end

	cairo_surface_copy_page (surface: POINTER)
		external
			"C signature (cairo_surface_t*) use <cairo.h>"
		end

	cairo_surface_show_page (surface: POINTER)
		external
			"C signature (cairo_surface_t*) use <cairo.h>"
		end

	cairo_surface_has_show_text_glyphs (surface: POINTER): BOOLEAN
		external
			"C signature (cairo_surface_t*): cairo_bool_t use <cairo.h>"
		end

	cairo_surface_get_type (surface: POINTER): INTEGER_8
		external
			"C signature (cairo_surface_t*): cairo_surface_type_t use <cairo.h>"
		end

	cairo_surface_get_content (surface: POINTER): INTEGER_8
		external
			"C signature (cairo_surface_t*): cairo_content_t use <cairo.h>"
		end

	cairo_surface_write_to_png (surface: POINTER; filename: POINTER): INTEGER_8
		external
			"C signature (cairo_surface_t*, char*): cairo_status_t use <cairo.h>"
		end

	cairo_image_surface_create (format: INTEGER_8; width: INTEGER_32; height: INTEGER_32): POINTER
		external
			"C signature (cairo_format_t, int, int): cairo_surface_t* use <cairo.h>"
		end

	cairo_format_stride_for_width (format: INTEGER_8; width: INTEGER_32): INTEGER_32
		external
			"C signature (cairo_format_t, int): int use <cairo.h>"
		end

	cairo_image_surface_create_for_data (data: TYPED_POINTER [NATURAL_8]; format: INTEGER_8; width: INTEGER_32; height: INTEGER_32; stride: INTEGER_32): POINTER
		external
			"C signature (unsigned char*, cairo_format_t, int, int, int): cairo_surface_t* use <cairo.h>"
		end

	cairo_image_surface_get_data (surface: POINTER): TYPED_POINTER [NATURAL_8]
		external
			"C signature (cairo_surface_t*): unsigned char* use <cairo.h>"
		end

	cairo_image_surface_get_format (surface: POINTER): INTEGER_8
		external
			"C signature (cairo_surface_t*): cairo_format_t use <cairo.h>"
		end

	cairo_image_surface_get_width (surface: POINTER): INTEGER_32
		external
			"C signature (cairo_surface_t*): int use <cairo.h>"
		end

	cairo_image_surface_get_height (surface: POINTER): INTEGER_32
		external
			"C signature (cairo_surface_t*): int use <cairo.h>"
		end

	cairo_new_path (cr: POINTER)
		external
			"C signature (cairo_t*) use <cairo.h>"
		end

	cairo_save (cr: POINTER)
		external
			"C signature (cairo_t*) use <cairo.h>"
		end

	cairo_restore (cr: POINTER)
		external
			"C signature (cairo_t*) use <cairo.h>"
		end

	cairo_push_group (cr: POINTER)
		external
			"C signature (cairo_t*) use <cairo.h>"
		end

	cairo_push_group_with_content (cr: POINTER; content: INTEGER_8)
		external
			"C signature (cairo_t*, cairo_content_t) use <cairo.h>"
		end

	cairo_pop_group (cr: POINTER): POINTER
		external
			"C signature (cairo_t*): cairo_pattern_t* use <cairo.h>"
		end

	cairo_pop_group_to_source (cr: POINTER)
		external
			"C signature (cairo_t*) use <cairo.h>"
		end

	cairo_set_operator (cr: POINTER; op: INTEGER_8)
		external
			"C signature (cairo_t*, cairo_operator_t) use <cairo.h>"
		end

	cairo_set_antialias (cr: POINTER; op: INTEGER_8)
		external
			"C signature (cairo_t*, cairo_antialias_t) use <cairo.h>"
		end

	cairo_font_options_set_antialias (cr: POINTER; op: INTEGER_8)
		external
			"C signature (cairo_font_options_t*, cairo_antialias_t) use <cairo.h>"
		end

	cairo_font_options_get_antialias (cr: POINTER): INTEGER_8
		external
			"C signature (cairo_font_options_t*): cairo_antialias_t use <cairo.h>"
		end

	cairo_fill (cr: POINTER)
		external
			"C signature (cairo_t*) use <cairo.h>"
		end

	cairo_fill_preserve (cr: POINTER)
		external
			"C signature (cairo_t*) use <cairo.h>"
		end

	cairo_translate (cr: POINTER; tx: REAL_64; ty: REAL_64)
		external
			"C signature (cairo_t*, double, double) use <cairo.h>"
		end

	cairo_scale (cr: POINTER; sx: REAL_64; sy: REAL_64)
		external
			"C signature (cairo_t*, double, double) use <cairo.h>"
		end

	cairo_rotate (cr: POINTER; angle: REAL_64)
		external
			"C signature (cairo_t*, double) use <cairo.h>"
		end

	cairo_paint (cr: POINTER)
		external
			"C signature (cairo_t*) use <cairo.h>"
		end

	cairo_stroke (cr: POINTER)
		external
			"C signature (cairo_t*) use <cairo.h>"
		end

	cairo_stroke_preserve (cr: POINTER)
		external
			"C signature (cairo_t*) use <cairo.h>"
		end

	cairo_move_to (cr: POINTER; x: REAL_64; y: REAL_64)
		external
			"C signature (cairo_t*, double, double) use <cairo.h>"
		end

	cairo_line_to (cr: POINTER; x: REAL_64; y: REAL_64)
		external
			"C signature (cairo_t*, double, double) use <cairo.h>"
		end

	cairo_rectangle (cr: POINTER; x: REAL_64; y: REAL_64; width: REAL_64; height: REAL_64)
		external
			"C signature (cairo_t*, double, double, double, double) use <cairo.h>"
		end

	cairo_set_source_rgba (cr: POINTER; red: REAL_64; green: REAL_64; blue: REAL_64; alpha: REAL_64)
		external
			"C signature (cairo_t*, double, double, double, double) use <cairo.h>"
		end

	cairo_set_source_rgb (cr: POINTER; red: REAL_64; green: REAL_64; blue: REAL_64)
		external
			"C signature (cairo_t*, double, double, double) use <cairo.h>"
		end

	cairo_curve_to (cr: POINTER; x1: REAL_64; y1: REAL_64; x2: REAL_64; y2: REAL_64; x3: REAL_64; y3: REAL_64)
		external
			"C signature (cairo_t*, double, double, double, double, double, double) use <cairo.h>"
		end

	cairo_arc (cr: POINTER; xc: REAL_64; yc: REAL_64; radius: REAL_64; angle1: REAL_64; angle2: REAL_64)
		external
			"C signature (cairo_t*, double, double, double, double, double) use <cairo.h>"
		end

	cairo_arc_negative (cr: POINTER; xc: REAL_64; yc: REAL_64; radius: REAL_64; angle1: REAL_64; angle2: REAL_64)
		external
			"C signature (cairo_t*, double, double, double, double, double) use <cairo.h>"
		end

	cairo_set_line_width (cr: POINTER; width: REAL_64)
		external
			"C signature (cairo_t*, double) use <cairo.h>"
		end

	cairo_set_line_cap (cr: POINTER; line_cap: INTEGER_8)
		external
			"C signature (cairo_t*, cairo_line_cap_t) use <cairo.h>"
		end

	cairo_set_line_join (cr: POINTER; line_join: INTEGER_8)
		external
			"C signature (cairo_t*, cairo_line_join_t) use <cairo.h>"
		end

	cairo_rel_move_to (cr: POINTER; dx: REAL_64; dy: REAL_64)
		external
			"C signature (cairo_t*, double, double) use <cairo.h>"
		end

	cairo_rel_line_to (cr: POINTER; dx: REAL_64; dy: REAL_64)
		external
			"C signature (cairo_t*, double, double) use <cairo.h>"
		end

	cairo_rel_curve_to (cr: POINTER; dx1: REAL_64; dy1: REAL_64; dx2: REAL_64; dy2: REAL_64; dx3: REAL_64; dy3: REAL_64)
		external
			"C signature (cairo_t*, double, double, double, double, double, double) use <cairo.h>"
		end

	cairo_close_path (cr: POINTER)
		external
			"C signature (cairo_t*) use <cairo.h>"
		end

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
