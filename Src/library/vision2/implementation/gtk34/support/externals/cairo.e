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
    	-- https://www.cairographics.org/manual/cairo-Image-Surfaces.html#cairo-format-t

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
		ensure
			is_class: class
		end

	OPERATOR_OVER: INTEGER_8
		external
			"C macro use <cairo.h>"
		alias
			"CAIRO_OPERATOR_OVER"
		ensure
			is_class: class
		end

	OPERATOR_IN: INTEGER_8
		external
			"C macro use <cairo.h>"
		alias
			"CAIRO_OPERATOR_IN"
		ensure
			is_class: class
		end

	OPERATOR_OUT: INTEGER_8
		external
			"C macro use <cairo.h>"
		alias
			"CAIRO_OPERATOR_OUT"
		ensure
			is_class: class
		end

	OPERATOR_XOR: INTEGER_8
		external
			"C macro use <cairo.h>"
		alias
			"CAIRO_OPERATOR_XOR"
		ensure
			is_class: class
		end

	OPERATOR_ADD: INTEGER_8
		external
			"C macro use <cairo.h>"
		alias
			"CAIRO_OPERATOR_ADD"
		ensure
			is_class: class
		end

	OPERATOR_ATOP: INTEGER_8
		external
			"C macro use <cairo.h>"
		alias
			"CAIRO_OPERATOR_ATOP"
		ensure
			is_class: class
		end

	OPERATOR_DEST: INTEGER_8
		external
			"C macro use <cairo.h>"
		alias
			"CAIRO_OPERATOR_DEST"
		ensure
			is_class: class
		end

	OPERATOR_DEST_OVER: INTEGER_8
		external
			"C macro use <cairo.h>"
		alias
			"CAIRO_OPERATOR_DEST_OVER"
		ensure
			is_class: class
		end

	OPERATOR_DEST_IN: INTEGER_8
		external
			"C macro use <cairo.h>"
		alias
			"CAIRO_OPERATOR_DEST_IN"
		ensure
			is_class: class
		end

	OPERATOR_DEST_OUT: INTEGER_8
		external
			"C macro use <cairo.h>"
		alias
			"CAIRO_OPERATOR_DEST_OUT"
		ensure
			is_class: class
		end

	OPERATOR_DEST_ATOP: INTEGER_8
		external
			"C macro use <cairo.h>"
		alias
			"CAIRO_OPERATOR_DEST_ATOP"
		ensure
			is_class: class
		end

	OPERATOR_DIFFERENCE: INTEGER_8
		external
			"C macro use <cairo.h>"
		alias
			"CAIRO_OPERATOR_DIFFERENCE"
		ensure
			is_class: class
		end

	OPERATOR_EXCLUSION: INTEGER_8
		external
			"C macro use <cairo.h>"
		alias
			"CAIRO_OPERATOR_EXCLUSION"
		ensure
			is_class: class
		end

	OPERATOR_MULTIPLY: INTEGER_8
		external
			"C macro use <cairo.h>"
		alias
			"CAIRO_OPERATOR_MULTIPLY"
		ensure
			is_class: class
		end

feature -- Externals

	clip (cr: POINTER)
		external
			"C signature (cairo_t*) use <cairo.h>"
		alias
			"cairo_clip"
		ensure
			is_class: class
		end

	reset_clip (cr: POINTER)
		external
			"C signature (cairo_t*) use <cairo.h>"
		alias
			"cairo_reset_clip"
		ensure
			is_class: class
		end

	clip_extents (cr: POINTER; a_x1, a_y1, a_x2, a_y2: TYPED_POINTER [REAL_64])
		external
			"C signature (cairo_t*, double*, double*, double*, double*) use <cairo.h>"
		alias
			"cairo_clip_extents"
		ensure
			is_class: class
		end

	copy_clip_rectangle_list (cr: POINTER): POINTER
		external
			"C signature (cairo_t*): cairo_rectangle_list_t* use <cairo.h>"
		alias
			"cairo_copy_clip_rectangle_list"
		ensure
			is_class: class
		end

	region_get_extents (a_region: POINTER; a_rectangle: POINTER)
		external
			"C signature (cairo_region_t*, cairo_rectangle_int_t*) use <cairo.h>"
		alias
			"cairo_region_get_extents"
		ensure
			is_class: class
		end

	rectangle_int_struct_size: INTEGER
		external
			"C macro use <cairo.h>"
		alias
			"sizeof(cairo_rectangle_int_t)"
		ensure
			is_class: class
		end

	rectangle_struct_size: INTEGER
		external
			"C macro use <cairo.h>"
		alias
			"sizeof(cairo_rectangle_t)"
		ensure
			is_class: class
		end

	set_source (cr: POINTER; source: POINTER)
		external
			"C signature (cairo_t*, cairo_pattern_t*) use <cairo.h>"
		alias
			"cairo_set_source"
		ensure
			is_class: class
		end

	paint_with_alpha (cr: POINTER; alpha: REAL_64)
		external
			"C signature (cairo_t*, double) use <cairo.h>"
		alias
			"cairo_paint_with_alpha"
		ensure
			is_class: class
		end

	mask (cr: POINTER; pattern: POINTER)
		external
			"C signature (cairo_t*, cairo_pattern_t*) use <cairo.h>"
		alias
			"cairo_mask"
		ensure
			is_class: class
		end

	mask_surface (cr: POINTER; surface: POINTER; surface_x: REAL_64; surface_y: REAL_64)
		external
			"C signature (cairo_t*, cairo_surface_t*, double, double) use <cairo.h>"
		alias
			"cairo_mask_surface"
		ensure
			is_class: class
		end

	set_source_surface (cr: POINTER; surface: POINTER; x: REAL_64; y: REAL_64)
		external
			"C signature (cairo_t*, cairo_surface_t*, double, double) use <cairo.h>"
		alias
			"cairo_set_source_surface"
		ensure
			is_class: class
		end

	create_context (target: POINTER): POINTER
		external
			"C signature (cairo_surface_t*): cairo_t* use <cairo.h>"
		alias
			"cairo_create"
		ensure
			is_class: class
		end

	add_reference (cr: POINTER): POINTER
		external
			"C signature (cairo_t*): cairo_t* use <cairo.h>"
		alias
			"cairo_reference"
		ensure
			is_class: class
		end

	destroy (cr: POINTER)
		external
			"C signature (cairo_t*) use <cairo.h>"
		alias
			"cairo_destroy"
		ensure
			is_class: class
		end

	status (cr: POINTER): INTEGER
		external
			"C signature (cairo_t*): cairo_status_t use <cairo.h>"
		alias
			"cairo_status"
		ensure
			is_class: class
		end

	surface_destroy (cr: POINTER)
		external
			"C signature (cairo_surface_t*) use <cairo.h>"
		alias
			"cairo_surface_destroy"
		ensure
			is_class: class
		end

	get_reference_count (cr: POINTER): NATURAL_32
		external
			"C signature (cairo_t*): unsigned int use <cairo.h>"
		alias
			"cairo_get_reference_count"
		ensure
			is_class: class
		end

	surface_flush (surface: POINTER)
		external
			"C signature (cairo_surface_t*) use <cairo.h>"
		alias
			"cairo_surface_flush"
		ensure
			is_class: class
		end

	surface_mark_dirty (surface: POINTER)
		external
			"C signature (cairo_surface_t*) use <cairo.h>"
		alias
			"cairo_surface_mark_dirty"
		ensure
			is_class: class
		end

	surface_mark_dirty_rectangle (surface: POINTER; x: INTEGER_32; y: INTEGER_32; width: INTEGER_32; height: INTEGER_32)
		external
			"C signature (cairo_surface_t*, int, int, int, int) use <cairo.h>"
		alias
			"cairo_surface_mark_dirty_rectangle"
		ensure
			is_class: class
		end

	surface_set_device_offset (surface: POINTER; x_offset: REAL_64; y_offset: REAL_64)
		external
			"C signature (cairo_surface_t*, double, double) use <cairo.h>"
		alias
			"cairo_surface_set_device_offset"
		ensure
			is_class: class
		end

	surface_get_device_offset (surface: POINTER; x_offset: TYPED_POINTER [REAL_64]; y_offset: TYPED_POINTER [REAL_64])
		external
			"C signature (cairo_surface_t*, double*, double*) use <cairo.h>"
		alias
			"cairo_surface_get_device_offset"
		ensure
			is_class: class
		end

	surface_set_fallback_resolution (surface: POINTER; x_pixels_per_inch: REAL_64; y_pixels_per_inch: REAL_64)
		external
			"C signature (cairo_surface_t*, double, double) use <cairo.h>"
		alias
			"cairo_surface_set_fallback_resolution"
		ensure
			is_class: class
		end

	surface_get_fallback_resolution (surface: POINTER; x_pixels_per_inch: TYPED_POINTER [REAL_64]; y_pixels_per_inch: TYPED_POINTER [REAL_64])
		external
			"C signature (cairo_surface_t*, double*, double*) use <cairo.h>"
		alias
			"cairo_surface_get_fallback_resolution"
		ensure
			is_class: class
		end

	surface_copy_page (surface: POINTER)
		external
			"C signature (cairo_surface_t*) use <cairo.h>"
		alias
			"cairo_surface_copy_page"
		ensure
			is_class: class
		end

	surface_show_page (surface: POINTER)
		external
			"C signature (cairo_surface_t*) use <cairo.h>"
		alias
			"cairo_surface_show_page"
		ensure
			is_class: class
		end

	surface_has_show_text_glyphs (surface: POINTER): BOOLEAN
		external
			"C signature (cairo_surface_t*): cairo_bool_t use <cairo.h>"
		alias
			"cairo_surface_has_show_text_glyphs"
		ensure
			is_class: class
		end

	surface_get_type (surface: POINTER): INTEGER_8
		external
			"C signature (cairo_surface_t*): cairo_surface_type_t use <cairo.h>"
		alias
			"cairo_surface_get_type"
		ensure
			is_class: class
		end

	surface_get_content (surface: POINTER): INTEGER_8
		external
			"C signature (cairo_surface_t*): cairo_content_t use <cairo.h>"
		alias
			"cairo_surface_get_content"
		ensure
			is_class: class
		end

	surface_write_to_png (surface: POINTER; filename: POINTER): INTEGER_8
		external
			"C signature (cairo_surface_t*, char*): cairo_status_t use <cairo.h>"
		alias
			"cairo_surface_write_to_png"
		ensure
			is_class: class
		end

	image_surface_create (format: INTEGER_8; width: INTEGER_32; height: INTEGER_32): POINTER
		external
			"C signature (cairo_format_t, int, int): cairo_surface_t* use <cairo.h>"
		alias
			"cairo_image_surface_create"
		ensure
			is_class: class
		end

	format_stride_for_width (format: INTEGER_8; width: INTEGER_32): INTEGER_32
		external
			"C signature (cairo_format_t, int): int use <cairo.h>"
		alias
			"cairo_format_stride_for_width"
		ensure
			is_class: class
		end

	image_surface_create_for_data (data: TYPED_POINTER [NATURAL_8]; format: INTEGER_8; width: INTEGER_32; height: INTEGER_32; stride: INTEGER_32): POINTER
		external
			"C signature (unsigned char*, cairo_format_t, int, int, int): cairo_surface_t* use <cairo.h>"
		alias
			"cairo_image_surface_create_for_data"
		ensure
			is_class: class
		end

	image_surface_get_data (surface: POINTER): TYPED_POINTER [NATURAL_8]
		external
			"C signature (cairo_surface_t*): unsigned char* use <cairo.h>"
		alias
			"cairo_image_surface_get_data"
		ensure
			is_class: class
		end

	image_surface_get_format (surface: POINTER): INTEGER_8
		external
			"C signature (cairo_surface_t*): cairo_format_t use <cairo.h>"
		alias
			"cairo_image_surface_get_format"
		ensure
			is_class: class
		end

	image_surface_get_width (surface: POINTER): INTEGER_32
		external
			"C signature (cairo_surface_t*): int use <cairo.h>"
		alias
			"cairo_image_surface_get_width"
		ensure
			is_class: class
		end

	image_surface_get_height (surface: POINTER): INTEGER_32
		external
			"C signature (cairo_surface_t*): int use <cairo.h>"
		alias
			"cairo_image_surface_get_height"
		ensure
			is_class: class
		end

	new_path (cr: POINTER)
		external
			"C signature (cairo_t*) use <cairo.h>"
		alias
			"cairo_new_path"
		ensure
			is_class: class
		end

	save (cr: POINTER)
		external
			"C signature (cairo_t*) use <cairo.h>"
		alias
			"cairo_save"
		ensure
			is_class: class
		end

	restore (cr: POINTER)
		external
			"C signature (cairo_t*) use <cairo.h>"
		alias
			"cairo_restore"
		ensure
			is_class: class
		end

	push_group (cr: POINTER)
		external
			"C signature (cairo_t*) use <cairo.h>"
		alias
			"cairo_push_group"
		ensure
			is_class: class
		end

	push_group_with_content (cr: POINTER; content: INTEGER_8)
		external
			"C signature (cairo_t*, cairo_content_t) use <cairo.h>"
		alias
			"cairo_push_group_with_content"
		ensure
			is_class: class
		end

	pop_group (cr: POINTER): POINTER
		external
			"C signature (cairo_t*): cairo_pattern_t* use <cairo.h>"
		alias
			"cairo_pop_group"
		ensure
			is_class: class
		end

	pop_group_to_source (cr: POINTER)
		external
			"C signature (cairo_t*) use <cairo.h>"
		alias
			"cairo_pop_group_to_source"
		ensure
			is_class: class
		end

	set_operator (cr: POINTER; op: INTEGER_8)
		external
			"C signature (cairo_t*, cairo_operator_t) use <cairo.h>"
		alias
			"cairo_set_operator"
		ensure
			is_class: class
		end

	set_antialias (cr: POINTER; op: INTEGER_8)
		external
			"C signature (cairo_t*, cairo_antialias_t) use <cairo.h>"
		alias
			"cairo_set_antialias"
		ensure
			is_class: class
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
		ensure
			is_class: class
		end

	font_options_set_antialias (cr: POINTER; op: INTEGER_8)
		external
			"C signature (cairo_font_options_t*, cairo_antialias_t) use <cairo.h>"
		alias
			"cairo_font_options_set_antialias"
		ensure
			is_class: class
		end

	font_options_get_antialias (cr: POINTER): INTEGER_8
		external
			"C signature (cairo_font_options_t*): cairo_antialias_t use <cairo.h>"
		alias
			"cairo_font_options_get_antialias"
		ensure
			is_class: class
		end

	fill (cr: POINTER)
		external
			"C signature (cairo_t*) use <cairo.h>"
		alias
			"cairo_fill"
		ensure
			is_class: class
		end

	fill_preserve (cr: POINTER)
		external
			"C signature (cairo_t*) use <cairo.h>"
		alias
			"cairo_fill_preserve"
		ensure
			is_class: class
		end

	translate (cr: POINTER; tx: REAL_64; ty: REAL_64)
		external
			"C signature (cairo_t*, double, double) use <cairo.h>"
		alias
			"cairo_translate"
		ensure
			is_class: class
		end


	intersect (dst: POINTER; other: POINTER): INTEGER
		external
			"C inline use <ev_gtk.h>"
		alias
			"return  cairo_region_intersect ((cairo_region_t *)$dst, (const cairo_region_t *)$other);"
		ensure
			is_class: class
		end

	union (dst: POINTER; other: POINTER): INTEGER
		external
			"C inline use <ev_gtk.h>"
		alias
			"return  cairo_region_union ((cairo_region_t *)$dst, (const cairo_region_t *)$other);"
		ensure
			is_class: class
		end

	subtract (dst: POINTER; other: POINTER): INTEGER
		external
			"C inline use <ev_gtk.h>"
		alias
			"return  cairo_region_subtract ((cairo_region_t *)$dst, (const cairo_region_t *)$other);"
		ensure
			is_class: class
		end

	cairo_xor (dst: POINTER; other: POINTER): INTEGER
		external
			"C inline use <ev_gtk.h>"
		alias
			"return  cairo_region_xor ((cairo_region_t *)$dst, (const cairo_region_t *)$other);"
		ensure
			is_class: class
		end

	cairo_equal (dst: POINTER; other: POINTER): BOOLEAN
		external
			"C inline use <ev_gtk.h>"
		alias
			"return  cairo_region_equal ((const cairo_region_t *)$dst, (const cairo_region_t *)$other);"
		ensure
			is_class: class
		end

	cairo_copy (original: POINTER): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"return  cairo_region_copy ((const cairo_region_t *)$original);"
		ensure
			is_class: class
		end

	scale (cr: POINTER; sx: REAL_64; sy: REAL_64)
		external
			"C signature (cairo_t*, double, double) use <cairo.h>"
		alias
			"cairo_scale"
		ensure
			is_class: class
		end

	rotate (cr: POINTER; angle: REAL_64)
		external
			"C signature (cairo_t*, double) use <cairo.h>"
		alias
			"cairo_rotate"
		ensure
			is_class: class
		end

	paint (cr: POINTER)
		external
			"C signature (cairo_t*) use <cairo.h>"
		alias
			"cairo_paint"
		ensure
			is_class: class
		end

	stroke (cr: POINTER)
		external
			"C signature (cairo_t*) use <cairo.h>"
		alias
			"cairo_stroke"
		ensure
			is_class: class
		end

	stroke_preserve (cr: POINTER)
		external
			"C signature (cairo_t*) use <cairo.h>"
		alias
			"cairo_stroke_preserve"
		ensure
			is_class: class
		end

	move_to (cr: POINTER; x: REAL_64; y: REAL_64)
		external
			"C signature (cairo_t*, double, double) use <cairo.h>"
		alias
			"cairo_move_to"
		ensure
			is_class: class
		end

	line_to (cr: POINTER; x: REAL_64; y: REAL_64)
		external
			"C signature (cairo_t*, double, double) use <cairo.h>"
		alias
			"cairo_line_to"
		ensure
			is_class: class
		end

	rectangle (cr: POINTER; x: REAL_64; y: REAL_64; width: REAL_64; height: REAL_64)
		external
			"C signature (cairo_t*, double, double, double, double) use <cairo.h>"
		alias
			"cairo_rectangle"
		ensure
			is_class: class
		end

	set_source_rgba (cr: POINTER; red: REAL_64; green: REAL_64; blue: REAL_64; alpha: REAL_64)
		external
			"C signature (cairo_t*, double, double, double, double) use <cairo.h>"
		alias
			"cairo_set_source_rgba"
		ensure
			is_class: class
		end

	set_source_rgb (cr: POINTER; red: REAL_64; green: REAL_64; blue: REAL_64)
		external
			"C signature (cairo_t*, double, double, double) use <cairo.h>"
		alias
			"cairo_set_source_rgb"
		ensure
			is_class: class
		end

	curve_to (cr: POINTER; x1: REAL_64; y1: REAL_64; x2: REAL_64; y2: REAL_64; x3: REAL_64; y3: REAL_64)
		external
			"C signature (cairo_t*, double, double, double, double, double, double) use <cairo.h>"
		alias
			"cairo_curve_to"
		ensure
			is_class: class
		end

	arc (cr: POINTER; xc: REAL_64; yc: REAL_64; radius: REAL_64; angle1: REAL_64; angle2: REAL_64)
		external
			"C signature (cairo_t*, double, double, double, double, double) use <cairo.h>"
		alias
			"cairo_arc"
		ensure
			is_class: class
		end

	arc_negative (cr: POINTER; xc: REAL_64; yc: REAL_64; radius: REAL_64; angle1: REAL_64; angle2: REAL_64)
		external
			"C signature (cairo_t*, double, double, double, double, double) use <cairo.h>"
		alias
			"cairo_arc_negative"
		ensure
			is_class: class
		end

	set_line_width (cr: POINTER; width: REAL_64)
		external
			"C signature (cairo_t*, double) use <cairo.h>"
		alias
			"cairo_set_line_width"
		ensure
			is_class: class
		end

	set_line_cap (cr: POINTER; line_cap: INTEGER_8)
		external
			"C signature (cairo_t*, cairo_line_cap_t) use <cairo.h>"
		alias
			"cairo_set_line_cap"
		ensure
			is_class: class
		end

	set_line_join (cr: POINTER; line_join: INTEGER_8)
		external
			"C signature (cairo_t*, cairo_line_join_t) use <cairo.h>"
		alias
			"cairo_set_line_join"
		ensure
			is_class: class
		end

	rel_move_to (cr: POINTER; dx: REAL_64; dy: REAL_64)
		external
			"C signature (cairo_t*, double, double) use <cairo.h>"
		alias
			"cairo_rel_move_to"
		ensure
			is_class: class
		end

	rel_line_to (cr: POINTER; dx: REAL_64; dy: REAL_64)
		external
			"C signature (cairo_t*, double, double) use <cairo.h>"
		alias
			"cairo_rel_line_to"
		ensure
			is_class: class
		end

	rel_curve_to (cr: POINTER; dx1: REAL_64; dy1: REAL_64; dx2: REAL_64; dy2: REAL_64; dx3: REAL_64; dy3: REAL_64)
		external
			"C signature (cairo_t*, double, double, double, double, double, double) use <cairo.h>"
		alias
			"cairo_rel_curve_to"
		ensure
			is_class: class
		end

	close_path (cr: POINTER)
		external
			"C signature (cairo_t*) use <cairo.h>"
		alias
			"cairo_close_path"
		ensure
			is_class: class
		end

feature -- Cairo Rectangle Int

	frozen cairo_rectangle_int_t_struct_allocate: POINTER
		external
			"C [macro <stdlib.h>]"
		alias
			"calloc (sizeof(cairo_rectangle_int_t), 1)"
		ensure
			is_class: class
		end

	frozen set_cairo_rectangle_int_t_height (a_c_struct: POINTER; a_height: INTEGER_32)
		external
			"C [struct <ev_gtk.h>] (cairo_rectangle_int_t, int)"
		alias
			"height"
		ensure
			is_class: class
		end

	frozen set_cairo_rectangle_int_t_width (a_c_struct: POINTER; a_width: INTEGER_32)
		external
			"C [struct <ev_gtk.h>] (cairo_rectangle_int_t, int)"
		alias
			"width"
		ensure
			is_class: class
		end

	frozen set_cairo_rectangle_int_t_x (a_c_struct: POINTER; a_x: INTEGER_32)
		external
			"C [struct <ev_gtk.h>] (cairo_rectangle_int_t, int)"
		alias
			"x"
		ensure
			is_class: class
		end

	frozen set_cairo_rectangle_int_t_y (a_c_struct: POINTER; a_y: INTEGER_32)
		external
			"C [struct <ev_gtk.h>] (cairo_rectangle_int_t, int)"
		alias
			"y"
		ensure
			is_class: class
		end

	frozen 	cairo_region_create_rectangle (a_rectangle: POINTER): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"return cairo_region_create_rectangle ((const cairo_rectangle_int_t *)$a_rectangle);"
		ensure
			is_class: class
		end


note
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
