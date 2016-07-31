note
	description: "Wrappers around the Pango API."
	date: "$Date$"
	revision: "$Revision$"

class
	PANGO

feature -- Constants

	frozen underline_none_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"PANGO_UNDERLINE_NONE"
		end

	frozen underline_single_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"PANGO_UNDERLINE_SINGLE"
		end

	frozen underline_double_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"PANGO_UNDERLINE_DOUBLE"
		end

	frozen scale: INTEGER_32
		external
			"C Macro use <ev_gtk.h>"
		alias
			"PANGO_SCALE"
		end

	frozen pango_pixels (a_value: INTEGER_32): INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"PANGO_PIXELS"
		end

feature -- Externals

	layout_set_ellipsize_call (a_function: POINTER; a_layout: POINTER; a_ellipsize_mode: INTEGER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"(FUNCTION_CAST(void, (PangoLayout*, gint)) $a_function)((PangoLayout*) $a_layout, (gint) $a_ellipsize_mode);"
		end

feature -- Pango font description 

	frozen font_description_new: POINTER
		external
			"C signature (): PangoFontDescription* use <ev_gtk.h>"
		alias
			"pango_font_description_new"
		end

	frozen font_description_free (a_pango_description: POINTER)
		external
			"C signature (PangoFontDescription*) use <ev_gtk.h>"
		alias
			"pango_font_description_free"
		end

	frozen font_description_copy (a_pango_description: POINTER): POINTER
		external
			"C signature (PangoFontDescription*): PangoFontDescription* use <ev_gtk.h>"
		alias
			"pango_font_description_copy"
		end

	frozen font_description_to_string (a_pango_description: POINTER): POINTER
		external
			"C signature (PangoFontDescription*): char* use <ev_gtk.h>"
		alias
			"pango_font_description_to_string"
		end

	frozen font_description_set_family (a_pango_description: POINTER; a_family: POINTER)
		external
			"C signature (PangoFontDescription*, char*) use <ev_gtk.h>"
		alias
			"pango_font_description_set_family"
		end

	frozen font_description_get_family (a_pango_description: POINTER): POINTER
		external
			"C signature (PangoFontDescription*): char* use <ev_gtk.h>"
		alias
			"pango_font_description_get_family"
		end

	frozen font_description_set_style (a_pango_description: POINTER; a_pango_style: INTEGER_32)
		external
			"C signature (PangoFontDescription*, PangoStyle) use <ev_gtk.h>"
		alias
			"pango_font_description_set_style"
		end

	frozen font_description_get_style (a_pango_description: POINTER): INTEGER_32
		external
			"C signature (PangoFontDescription*): PangoStyle use <ev_gtk.h>"
		alias
			"pango_font_description_get_style"
		end

	frozen font_description_set_weight (a_pango_description: POINTER; a_weight: INTEGER_32)
		external
			"C signature (PangoFontDescription*, PangoWeight) use <ev_gtk.h>"
		alias
			"pango_font_description_set_weight"
		end

	frozen font_description_get_weight (a_pango_description: POINTER): INTEGER_32
		external
			"C signature (PangoFontDescription*): PangoWeight use <ev_gtk.h>"
		alias
			"pango_font_description_get_weight"
		end

	frozen font_description_set_size (a_pango_description: POINTER; a_size: INTEGER_32)
		external
			"C signature (PangoFontDescription*, gint) use <ev_gtk.h>"
		alias
			"pango_font_description_set_size"
		end

	frozen font_description_get_size (a_pango_description: POINTER): INTEGER_32
		external
			"C signature (PangoFontDescription*): gint use <ev_gtk.h>"
		alias
			"pango_font_description_get_size"
		end

	frozen font_description_from_string (a_description: POINTER): POINTER
		external
			"C signature (char*): PangoFontDescription* use <ev_gtk.h>"
		alias
			"pango_font_description_from_string"
		end

feature -- Pango layout 

	frozen layout_set_font_description (a_layout, a_font_desc: POINTER)
		external
			"C signature (PangoLayout*, PangoFontDescription*) use <ev_gtk.h>"
		alias
			"pango_layout_set_font_description"
		end

	frozen layout_set_width (a_layout: POINTER; a_width: INTEGER_32)
		external
			"C signature (PangoLayout*, int) use <ev_gtk.h>"
		alias
			"pango_layout_set_width"
		end

	frozen layout_get_pixel_size (a_layout: POINTER; a_width, a_height: TYPED_POINTER [INTEGER_32])
		external
			"C signature (PangoLayout*, gint*, gint*) use <ev_gtk.h>"
		alias
			"pango_layout_get_pixel_size"
		end

	frozen layout_get_iter (a_layout: POINTER): POINTER
		external
			"C signature (PangoLayout*): PangoLayoutIter* use <ev_gtk.h>"
		alias
			"pango_layout_get_iter"
		end

	frozen layout_set_text (a_layout: POINTER; a_text: POINTER; a_length: INTEGER_32)
		external
			"C signature (PangoLayout*, char*, int) use <ev_gtk.h>"
		alias
			"pango_layout_set_text"
		end

	frozen layout_iter_get_baseline (a_iter: POINTER): INTEGER_32
		external
			"C signature (PangoLayoutIter*): gint use <ev_gtk.h>"
		alias
			"pango_layout_iter_get_baseline"
		end

	frozen layout_iter_free (a_iter: POINTER)
		external
			"C signature (PangoLayoutIter*) use <ev_gtk.h>"
		alias
			"pango_layout_iter_free"
		end

	frozen layout_get_extents (a_layout: POINTER; ink_rect, logical_rect: POINTER)
		external
			"C signature (PangoLayout*, PangoRectangle*, PangoRectangle*) use <ev_gtk.h>"
		alias
			"pango_layout_get_extents"
		end

	frozen layout_get_pixel_extents (a_layout: POINTER; ink_rect, logical_rect: POINTER)
		external
			"C signature (PangoLayout*, PangoRectangle*, PangoRectangle*) use <ev_gtk.h>"
		alias
			"pango_layout_get_pixel_extents"
		end

	frozen layout_get_size (a_layout: POINTER; a_width, a_height: TYPED_POINTER [INTEGER_32])
		external
			"C signature (PangoLayout*, gint*, gint*) use <ev_gtk.h>"
		alias
			"pango_layout_get_size"
		end

	frozen layout_context_changed (a_layout: POINTER)
		external
			"C signature (PangoLayout*) use <ev_gtk.h>"
		alias
			"pango_layout_context_changed"
		end

	frozen layout_get_line_count (a_pango_layout: POINTER): INTEGER
		external
			"C signature (PangoLayout*): int use <ev_gtk.h>"
		alias
			"pango_layout_get_line_count"
		end

	frozen layout_get_line (a_pango_layout: POINTER; a_line: INTEGER): POINTER
		external
			"C signature (PangoLayout*, int): PangoLayoutLine* use <ev_gtk.h>"
		alias
			"pango_layout_get_line"
		end

	frozen layout_get_line_readonly (a_pango_layout: POINTER; a_line: INTEGER): POINTER
		external
			"C signature (PangoLayout*, int): PangoLayoutLine* use <ev_gtk.h>"
		alias
			"pango_layout_get_line_readonly"
		end

	frozen layout_get_context (a_pango_layout: POINTER): POINTER
		external
			"C signature (PangoLayout*): PangoContext* use <ev_gtk.h>"
		alias
			"pango_layout_get_context"
		end

feature -- Cairo bindings

	frozen cairo_create_layout (a_cr: POINTER): POINTER
		external
			"C signature (cairo_t*): PangoLayout* use <ev_gtk.h>"
		alias
			"pango_cairo_create_layout"
		end

	frozen cairo_update_layout (a_cr, a_layout: POINTER)
		external
			"C signature (cairo_t *, PangoLayout*) use <ev_gtk.h>"
		alias
			"pango_cairo_update_layout"
		end

	frozen cairo_show_layout (a_cr, a_layout: POINTER)
		external
			"C signature (cairo_t *, PangoLayout*) use <ev_gtk.h>"
		alias
			"pango_cairo_show_layout"
		end

	frozen cairo_show_layout_line (a_cr, a_layout: POINTER)
		external
			"C signature (cairo_t *, PangoLayoutLine*) use <ev_gtk.h>"
		alias
			"pango_cairo_show_layout_line"
		end

	frozen cairo_layout_path (a_cr, a_layout: POINTER)
		external
			"C signature (cairo_t *, PangoLayout*) use <ev_gtk.h>"
		alias
			"pango_cairo_layout_path"
		end

feature -- Structure

	frozen new_rectangle_struct: POINTER
		external
			"C [macro <ev_gtk.h>]"
		alias
			"calloc (sizeof(PangoRectangle), 1)"
		end

	frozen rectangle_struct_x (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (PangoRectangle): EIF_INTEGER"
		alias
			"x"
		end

	frozen rectangle_struct_y (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (PangoRectangle): EIF_INTEGER"
		alias
			"y"
		end

	frozen rectangle_struct_width (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (PangoRectangle): EIF_INTEGER"
		alias
			"width"
		end

	frozen rectangle_struct_height (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (PangoRectangle): EIF_INTEGER"
		alias
			"height"
		end

feature -- Pango Tab Array

	frozen tab_array_new (a_initial_size: INTEGER_32; a_position_in_pixels: BOOLEAN): POINTER
		external
			"C signature (gint, gboolean): PangoTabArray* use <ev_gtk.h>"
		alias
			"pango_tab_array_new"
		end

	frozen tab_array_resize (a_tab_array: POINTER; a_size: INTEGER_32)
		external
			"C signature (PangoTabArray*, gint) use <ev_gtk.h>"
		alias
			"pango_tab_array_resize"
		end

	frozen tab_array_set_tab (a_tab_array: POINTER; a_tab_index, a_tab_alignment, a_location: INTEGER_32)
		external
			"C signature (PangoTabArray*, gint, PangoTabAlign, gint) use <ev_gtk.h>"
		alias
			"pango_tab_array_set_tab"
		end

	frozen tab_array_free (a_tab_array: POINTER)
		external
			"C signature (PangoTabArray*) use <ev_gtk.h>"
		alias
			"pango_tab_array_free"
		end

feature -- Matrix

	frozen matrix_init (a_pango_matrix: TYPED_POINTER [POINTER])
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				PangoMatrix matrix = PANGO_MATRIX_INIT;
				*($a_pango_matrix) = (void*) pango_matrix_copy (&matrix);
			]"
		end

	frozen matrix_free (a_pango_matrix: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				pango_matrix_free ((PangoMatrix*) $a_pango_matrix);
			]"
		end

	frozen matrix_rotate (a_matrix: POINTER; a_degrees: REAL_32)
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				pango_matrix_rotate ((PangoMatrix*) $a_matrix, (double) $a_degrees);
			]"
		end

	frozen matrix_translate (a_matrix: POINTER; a_x, a_y: REAL_32)
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				pango_matrix_translate ((PangoMatrix*) $a_matrix, (double) $a_x, (double) $a_y);
			]"
		end

	frozen context_set_matrix (a_context, a_matrix: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				pango_context_set_matrix ((PangoContext*) $a_context, (PangoMatrix*) $a_matrix);
			]"
		end

	frozen set_pango_matrix_struct_xx (a_c_struct: POINTER; a_x: REAL_64)
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				((PangoMatrix*)$a_c_struct)->xx = (gdouble) $a_x;
			]"
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
