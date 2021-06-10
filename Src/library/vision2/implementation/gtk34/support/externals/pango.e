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
		ensure
			is_class: class
		end

	frozen underline_single_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"PANGO_UNDERLINE_SINGLE"
		ensure
			is_class: class
		end

	frozen underline_double_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"PANGO_UNDERLINE_DOUBLE"
		ensure
			is_class: class
		end

	frozen scale: INTEGER_32
		external
			"C Macro use <ev_gtk.h>"
		alias
			"PANGO_SCALE"
		ensure
			is_class: class
		end

	frozen pango_pixels (a_value: INTEGER_32): INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"PANGO_PIXELS"
		ensure
			is_class: class
		end

feature -- Externals

	layout_set_ellipsize_call (a_function: POINTER; a_layout: POINTER; a_ellipsize_mode: INTEGER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"(FUNCTION_CAST(void, (PangoLayout*, gint)) $a_function)((PangoLayout*) $a_layout, (gint) $a_ellipsize_mode);"
		ensure
			is_class: class
		end

feature -- Pango font description

	frozen font_description_new: POINTER
		external
			"C signature (): PangoFontDescription* use <ev_gtk.h>"
		alias
			"pango_font_description_new"
		ensure
			is_class: class
		end

	frozen font_description_free (a_pango_description: POINTER)
		external
			"C signature (PangoFontDescription*) use <ev_gtk.h>"
		alias
			"pango_font_description_free"
		ensure
			is_class: class
		end

	frozen font_description_copy (a_pango_description: POINTER): POINTER
		external
			"C signature (PangoFontDescription*): PangoFontDescription* use <ev_gtk.h>"
		alias
			"pango_font_description_copy"
		ensure
			is_class: class
		end

	frozen font_description_to_string (a_pango_description: POINTER): POINTER
		external
			"C signature (PangoFontDescription*): char* use <ev_gtk.h>"
		alias
			"pango_font_description_to_string"
		ensure
			is_class: class
		end

	frozen font_description_set_family (a_pango_description: POINTER; a_family: POINTER)
		external
			"C signature (PangoFontDescription*, char*) use <ev_gtk.h>"
		alias
			"pango_font_description_set_family"
		ensure
			is_class: class
		end

	frozen font_description_get_family (a_pango_description: POINTER): POINTER
		external
			"C signature (PangoFontDescription*): char* use <ev_gtk.h>"
		alias
			"pango_font_description_get_family"
		ensure
			is_class: class
		end

	frozen font_description_set_style (a_pango_description: POINTER; a_pango_style: INTEGER_32)
		external
			"C signature (PangoFontDescription*, PangoStyle) use <ev_gtk.h>"
		alias
			"pango_font_description_set_style"
		ensure
			is_class: class
		end

	frozen font_description_get_style (a_pango_description: POINTER): INTEGER_32
		external
			"C signature (PangoFontDescription*): PangoStyle use <ev_gtk.h>"
		alias
			"pango_font_description_get_style"
		ensure
			is_class: class
		end

	frozen font_description_set_weight (a_pango_description: POINTER; a_weight: INTEGER_32)
		external
			"C signature (PangoFontDescription*, PangoWeight) use <ev_gtk.h>"
		alias
			"pango_font_description_set_weight"
		ensure
			is_class: class
		end

	frozen font_description_get_weight (a_pango_description: POINTER): INTEGER_32
		external
			"C signature (PangoFontDescription*): PangoWeight use <ev_gtk.h>"
		alias
			"pango_font_description_get_weight"
		ensure
			is_class: class
		end

	frozen font_description_set_size (a_pango_description: POINTER; a_size: INTEGER_32)
		external
			"C signature (PangoFontDescription*, gint) use <ev_gtk.h>"
		alias
			"pango_font_description_set_size"
		ensure
			is_class: class
		end

	frozen font_description_get_size (a_pango_description: POINTER): INTEGER_32
		external
			"C signature (PangoFontDescription*): gint use <ev_gtk.h>"
		alias
			"pango_font_description_get_size"
		ensure
			is_class: class
		end

	frozen font_description_from_string (a_description: POINTER): POINTER
		external
			"C signature (char*): PangoFontDescription* use <ev_gtk.h>"
		alias
			"pango_font_description_from_string"
		ensure
			is_class: class
		end

feature -- Pango layout

	frozen layout_set_font_description (a_layout, a_font_desc: POINTER)
		external
			"C signature (PangoLayout*, PangoFontDescription*) use <ev_gtk.h>"
		alias
			"pango_layout_set_font_description"
		ensure
			is_class: class
		end

	frozen layout_set_width (a_layout: POINTER; a_width: INTEGER_32)
		external
			"C signature (PangoLayout*, int) use <ev_gtk.h>"
		alias
			"pango_layout_set_width"
		ensure
			is_class: class
		end

	frozen layout_get_pixel_size (a_layout: POINTER; a_width, a_height: TYPED_POINTER [INTEGER_32])
		external
			"C signature (PangoLayout*, gint*, gint*) use <ev_gtk.h>"
		alias
			"pango_layout_get_pixel_size"
		ensure
			is_class: class
		end

	frozen layout_get_iter (a_layout: POINTER): POINTER
		external
			"C signature (PangoLayout*): PangoLayoutIter* use <ev_gtk.h>"
		alias
			"pango_layout_get_iter"
		ensure
			is_class: class
		end

	frozen layout_set_text (a_layout: POINTER; a_text: POINTER; a_length: INTEGER_32)
		external
			"C signature (PangoLayout*, char*, int) use <ev_gtk.h>"
		alias
			"pango_layout_set_text"
		ensure
			is_class: class
		end

	frozen layout_iter_get_baseline (a_iter: POINTER): INTEGER_32
		external
			"C signature (PangoLayoutIter*): gint use <ev_gtk.h>"
		alias
			"pango_layout_iter_get_baseline"
		ensure
			is_class: class
		end

	frozen layout_iter_free (a_iter: POINTER)
		external
			"C signature (PangoLayoutIter*) use <ev_gtk.h>"
		alias
			"pango_layout_iter_free"
		ensure
			is_class: class
		end

	frozen layout_get_extents (a_layout: POINTER; ink_rect, logical_rect: POINTER)
		external
			"C signature (PangoLayout*, PangoRectangle*, PangoRectangle*) use <ev_gtk.h>"
		alias
			"pango_layout_get_extents"
		ensure
			is_class: class
		end

	frozen layout_get_pixel_extents (a_layout: POINTER; ink_rect, logical_rect: POINTER)
		external
			"C signature (PangoLayout*, PangoRectangle*, PangoRectangle*) use <ev_gtk.h>"
		alias
			"pango_layout_get_pixel_extents"
		ensure
			is_class: class
		end

	frozen layout_get_size (a_layout: POINTER; a_width, a_height: TYPED_POINTER [INTEGER_32])
		external
			"C signature (PangoLayout*, gint*, gint*) use <ev_gtk.h>"
		alias
			"pango_layout_get_size"
		ensure
			is_class: class
		end

	frozen layout_context_changed (a_layout: POINTER)
		external
			"C signature (PangoLayout*) use <ev_gtk.h>"
		alias
			"pango_layout_context_changed"
		ensure
			is_class: class
		end

	frozen layout_get_line_count (a_pango_layout: POINTER): INTEGER
		external
			"C signature (PangoLayout*): int use <ev_gtk.h>"
		alias
			"pango_layout_get_line_count"
		ensure
			is_class: class
		end

	frozen layout_get_line (a_pango_layout: POINTER; a_line: INTEGER): POINTER
		external
			"C signature (PangoLayout*, int): PangoLayoutLine* use <ev_gtk.h>"
		alias
			"pango_layout_get_line"
		ensure
			is_class: class
		end

	frozen layout_get_line_readonly (a_pango_layout: POINTER; a_line: INTEGER): POINTER
		external
			"C signature (PangoLayout*, int): PangoLayoutLine* use <ev_gtk.h>"
		alias
			"pango_layout_get_line_readonly"
		ensure
			is_class: class
		end

	frozen layout_get_context (a_pango_layout: POINTER): POINTER
		external
			"C signature (PangoLayout*): PangoContext* use <ev_gtk.h>"
		alias
			"pango_layout_get_context"
		ensure
			is_class: class
		end

feature -- Cairo bindings

	frozen cairo_create_layout (a_cr: POINTER): POINTER
		external
			"C signature (cairo_t*): PangoLayout* use <ev_gtk.h>"
		alias
			"pango_cairo_create_layout"
		ensure
			is_class: class
		end

	frozen cairo_update_layout (a_cr, a_layout: POINTER)
		external
			"C signature (cairo_t *, PangoLayout*) use <ev_gtk.h>"
		alias
			"pango_cairo_update_layout"
		ensure
			is_class: class
		end

	frozen cairo_show_layout (a_cr, a_layout: POINTER)
		external
			"C signature (cairo_t *, PangoLayout*) use <ev_gtk.h>"
		alias
			"pango_cairo_show_layout"
		ensure
			is_class: class
		end

	frozen cairo_show_layout_line (a_cr, a_layout: POINTER)
		external
			"C signature (cairo_t *, PangoLayoutLine*) use <ev_gtk.h>"
		alias
			"pango_cairo_show_layout_line"
		ensure
			is_class: class
		end

	frozen cairo_layout_path (a_cr, a_layout: POINTER)
		external
			"C signature (cairo_t *, PangoLayout*) use <ev_gtk.h>"
		alias
			"pango_cairo_layout_path"
		ensure
			is_class: class
		end

feature -- Structure

	frozen new_rectangle_struct: POINTER
		external
			"C [macro <ev_gtk.h>]"
		alias
			"calloc (sizeof(PangoRectangle), 1)"
		ensure
			is_class: class
		end

	frozen rectangle_struct_x (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (PangoRectangle): EIF_INTEGER"
		alias
			"x"
		ensure
			is_class: class
		end

	frozen rectangle_struct_y (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (PangoRectangle): EIF_INTEGER"
		alias
			"y"
		ensure
			is_class: class
		end

	frozen rectangle_struct_width (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (PangoRectangle): EIF_INTEGER"
		alias
			"width"
		ensure
			is_class: class
		end

	frozen rectangle_struct_height (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (PangoRectangle): EIF_INTEGER"
		alias
			"height"
		ensure
			is_class: class
		end

feature -- Pango Tab Array

	frozen tab_array_new (a_initial_size: INTEGER_32; a_position_in_pixels: BOOLEAN): POINTER
		external
			"C signature (gint, gboolean): PangoTabArray* use <ev_gtk.h>"
		alias
			"pango_tab_array_new"
		ensure
			is_class: class
		end

	frozen tab_array_resize (a_tab_array: POINTER; a_size: INTEGER_32)
		external
			"C signature (PangoTabArray*, gint) use <ev_gtk.h>"
		alias
			"pango_tab_array_resize"
		ensure
			is_class: class
		end

	frozen tab_array_set_tab (a_tab_array: POINTER; a_tab_index, a_tab_alignment, a_location: INTEGER_32)
		external
			"C signature (PangoTabArray*, gint, PangoTabAlign, gint) use <ev_gtk.h>"
		alias
			"pango_tab_array_set_tab"
		ensure
			is_class: class
		end

	frozen tab_array_free (a_tab_array: POINTER)
		external
			"C signature (PangoTabArray*) use <ev_gtk.h>"
		alias
			"pango_tab_array_free"
		ensure
			is_class: class
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
		ensure
			is_class: class
		end

	frozen matrix_free (a_pango_matrix: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				pango_matrix_free ((PangoMatrix*) $a_pango_matrix);
			]"
		ensure
			is_class: class
		end

	frozen matrix_rotate (a_matrix: POINTER; a_degrees: REAL_32)
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				pango_matrix_rotate ((PangoMatrix*) $a_matrix, (double) $a_degrees);
			]"
		ensure
			is_class: class
		end

	frozen matrix_translate (a_matrix: POINTER; a_x, a_y: REAL_32)
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				pango_matrix_translate ((PangoMatrix*) $a_matrix, (double) $a_x, (double) $a_y);
			]"
		ensure
			is_class: class
		end

	frozen context_set_matrix (a_context, a_matrix: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				pango_context_set_matrix ((PangoContext*) $a_context, (PangoMatrix*) $a_matrix);
			]"
		ensure
			is_class: class
		end

	frozen context_set_font_description (a_context, a_font_description: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				pango_context_set_font_description ((PangoContext*) $a_context, (const PangoFontDescription*) $a_font_description);
			]"
		ensure
			is_class: class
		end

	frozen set_pango_matrix_struct_xx (a_c_struct: POINTER; a_x: REAL_64)
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				((PangoMatrix*)$a_c_struct)->xx = (gdouble) $a_x;
			]"
		ensure
			is_class: class
		end


feature -- Pango Attribute

	pango_attr_list_new: POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"return pango_attr_list_new();"
		end

	pango_attr_family_new (family: POINTER): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"return pango_attr_family_new ((const char *)$family);"
		end

	pango_attr_style_new (style: INTEGER): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"return pango_attr_style_new ((PangoStyle)$style);"
		end

	pango_attr_font_desc_new (desc: POINTER): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"return pango_attr_font_desc_new ((const PangoFontDescription *)$desc);"
		end

	pango_attr_list_insert (list: POINTER; attr: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"pango_attr_list_insert ((PangoAttrList *)$list, (PangoAttribute *)$attr);	"
		end

	pango_attr_list_unref (list: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"pango_attr_list_unref ((PangoAttrList *)$list);"
		end

	pango_attribute_destroy (attr: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"pango_attribute_destroy ((PangoAttribute *)$attr);"
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
