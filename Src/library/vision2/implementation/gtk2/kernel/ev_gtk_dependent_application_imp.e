indexing
	description: 
		"EiffelVision application, GTK+ implementation."
	status: "See notice at end of class"
	keywords: "application"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class 
	EV_GTK_DEPENDENT_APPLICATION_IMP

inherit
	IDENTIFIED
		undefine
			is_equal,
			copy
		end

	EV_APPLICATION_ACTION_SEQUENCES_IMP

	EXECUTION_ENVIRONMENT
		rename
			launch as ee_launch
		end

	PLATFORM

feature -- Initialize

	gtk_dependent_initialize is
			-- Gtk dependent code for `initialize'
		do
			previous_font_description := ""
		end

	gtk_dependent_launch_initialize is
			-- Gtk dependent code for `launch' 
		do
			if feature {EV_GTK_EXTERNALS}.gtk_maj_ver = 1 and then feature {EV_GTK_EXTERNALS}.gtk_min_ver <= 2 and then feature {EV_GTK_EXTERNALS}.gtk_mic_ver < 8 then
				print ("This application is designed for Gtk 1.2.8 and above, your current version is 1.2." + feature {EV_GTK_EXTERNALS}.gtk_mic_ver.out + " and may cause some unexpected behavior%N")
			end
			
				-- Initialize the default font values
			if font_settings_changed then
				initialize_default_font_values
			end			
		end

feature -- Implementation

	pixel_value_from_point_value (a_point_value: INTEGER): INTEGER is
			-- 
		do
			Result := (a_point_value / 72 * 96).rounded
		end

	point_value_from_pixel_value (a_pixel_value: INTEGER): INTEGER is
			--
		do
			Result := (a_pixel_value / 96 * 72).rounded
		end

	pango_layout: POINTER is
			-- 
		local
			a_cs: EV_GTK_C_STRING
		once
			create a_cs.make ("A")
			Result := feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_widget_create_pango_layout (default_gtk_window, a_cs.item)
		end

	pango_iter: POINTER is
			-- 
		once
			Result := feature {EV_GTK_DEPENDENT_EXTERNALS}.pango_layout_get_iter (pango_layout)
		end

	writeable_pixbuf_formats: ARRAYED_LIST [STRING] is
			-- 
		once
			Result := pixbuf_formats (True)
			Result.compare_objects
		end
		
	readable_pixbuf_formats: ARRAYED_LIST [STRING] is
			-- 
		once
			Result := pixbuf_formats (False)
			Result.compare_objects
		end

	pixbuf_formats (a_writeable: BOOLEAN): ARRAYED_LIST [STRING] is
			-- List of the readable formats available with current Gtk 2.0 library
		local
			formats: POINTER
			i,format_count: INTEGER
			format_name: STRING
			pixbuf_format: POINTER
		do
			formats := feature {EV_GTK_DEPENDENT_EXTERNALS}.gdk_pixbuf_get_formats
			format_count := feature {EV_GTK_EXTERNALS}.g_slist_length (formats)
			from
				i := 0
				create Result.make (0)
			until
				i = format_count
			loop
				pixbuf_format := feature {EV_GTK_EXTERNALS}.g_slist_nth_data (formats, i)				
				create format_name.make_from_c (feature {EV_GTK_DEPENDENT_EXTERNALS}.gdk_pixbuf_format_get_name (pixbuf_format))
				if format_name.is_equal ("jpeg") then
					format_name := "jpg"
				end
				if a_writeable then
					if feature {EV_GTK_DEPENDENT_EXTERNALS}.gdk_pixbuf_format_is_writable (pixbuf_format) then
						Result.extend (format_name.as_upper)
					end					
				else
					Result.extend (format_name.as_upper)
				end
				i := i + 1
			end
			feature {EV_GTK_EXTERNALS}.g_slist_free (formats)
		end

	initialize_default_font_values is
			-- Initialize values use for creating our default font
		local
			font_desc: STRING
			font_names: ARRAYED_LIST [STRING]
			exit_loop: BOOLEAN
			split_values: LIST [STRING]
		do
			font_desc := default_font_description.as_lower
			font_names := font_names_on_system
			
			from
				font_names.start
			until
				exit_loop or else font_names.after
			loop
				if font_desc.substring_index (font_names.item.as_lower, 1) = 1 then
					default_font_name_internal := font_names.item
					exit_loop := True
				end
				font_names.forth
			end
			
			split_values := font_desc.split (' ')
			split_values.compare_objects
			default_font_size_internal := pixel_value_from_point_value (split_values.last.to_integer)
			
			if split_values.has ("italic") or else split_values.has ("oblique") then
				default_font_style_internal := feature {EV_FONT_CONSTANTS}.shape_italic
			else
				default_font_style_internal := feature {EV_FONT_CONSTANTS}.shape_regular
			end
			
			if split_values.has ("bold") then
				default_font_weight_internal := feature {EV_FONT_CONSTANTS}.weight_bold
			elseif split_values.has ("light") then
				default_font_weight_internal := feature {EV_FONT_CONSTANTS}.weight_thin
			elseif split_values.has ("superbold") then
				default_font_weight_internal := feature {EV_FONT_CONSTANTS}.weight_black
			else
				default_font_weight_internal := feature {EV_FONT_CONSTANTS}.weight_regular
			end		
		end
	
	default_font_name: STRING is
			-- Face name of the default font
		do
			if font_settings_changed then
				initialize_default_font_values
			end
			Result := default_font_name_internal
		end
		
	default_font_name_internal: STRING
	
	default_font_size: INTEGER is
			-- Size of the default font in points
		do
			if font_settings_changed then
				initialize_default_font_values
			end
			Result := default_font_size_internal
		end
	
	default_font_size_internal: INTEGER

	default_font_style: INTEGER is
			-- Style of the default font
		do
			if font_settings_changed then
				initialize_default_font_values
			end
			Result := default_font_style_internal
		end

	default_font_style_internal: INTEGER
	
	default_font_weight: INTEGER is
			-- Weight of the default font
		do
			if font_settings_changed then
				initialize_default_font_values
			end
			Result := default_font_weight_internal
		end

	default_font_weight_internal: INTEGER
	
	previous_font_description: STRING
		-- Stored value of the default gtk font settings string

	font_settings_changed: BOOLEAN is
			-- Have the default font settings been changed by the user
		require
			default_font_initialized: previous_font_description /= Void
		local
			a_settings: STRING
		do
			a_settings := default_font_description
			Result := not a_settings.is_equal (previous_font_description)
			previous_font_description := a_settings
		end

	default_font_description: STRING is
			-- Description string of the current font used
		local
			gtk_settings, font_name_ptr: POINTER
			a_utf8_c_string: EV_GTK_C_STRING
		do
			gtk_settings := feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_settings_get_default
			create a_utf8_c_string.make ("gtk-font-name")
			feature {EV_GTK_DEPENDENT_EXTERNALS}.g_object_get_string (gtk_settings, a_utf8_c_string.item, $font_name_ptr)
			create a_utf8_c_string.make_from_pointer (font_name_ptr)
			Result := a_utf8_c_string.string
		end
		
	font_names_on_system: ARRAYED_LIST [STRING] is
			-- Retrieve a list of all the font names available on the system
		local
			a_name_array: POINTER
			i, n_array_elements: INTEGER
			utf8_string: EV_GTK_C_STRING
		once
			retrieve_available_fonts (default_gtk_window, $a_name_array, $n_array_elements)
			create Result.make_filled (n_array_elements)
			from
				i := 1
			until
				i > n_array_elements
			loop
				create utf8_string.make_from_pointer (gchar_array_i_th (a_name_array, i))
				Result.put_i_th (utf8_string.string, i)
				i := i + 1
			end
			Result.compare_objects
		end

	font_names_on_system_as_lower: ARRAYED_LIST [STRING] is
			-- Retrieve a list of all the font names available on the system in lower case
		local
			a_name_array: POINTER
			i, n_array_elements: INTEGER
			i_th_item: STRING
			utf8_string: EV_GTK_C_STRING
		once
			retrieve_available_fonts (default_gtk_window, $a_name_array, $n_array_elements)
			create Result.make_filled (n_array_elements)
			from
				i := 1
			until
				i > n_array_elements
			loop
				create utf8_string.make_from_pointer (gchar_array_i_th (a_name_array, i))
				i_th_item := utf8_string.string
				i_th_item.to_lower
				Result.put_i_th (i_th_item, i)
				i := i + 1
			end
			Result.compare_objects
		end
		
	default_gtk_window: POINTER is deferred end

	gdk_cursor_from_pixmap (a_cursor: EV_CURSOR): POINTER is
			-- Return a GdkCursor constructed from `a_cursor'
		local
			a_cursor_imp: EV_PIXMAP_IMP
			a_pixbuf: POINTER
		do
			a_cursor_imp ?= a_cursor.implementation
			a_pixbuf := a_cursor_imp.pixbuf_from_drawable
			Result := feature {EV_GTK_DEPENDENT_EXTERNALS}.gdk_cursor_new_from_pixbuf (feature {EV_GTK_DEPENDENT_EXTERNALS}.gdk_display_get_default, a_pixbuf, a_cursor.x_hotspot, a_cursor.y_hotspot)
			feature {EV_GTK_EXTERNALS}.object_unref (a_pixbuf)
		end

feature {NONE} -- Externals

	retrieve_available_fonts (a_widget: POINTER; name_array: TYPED_POINTER [POINTER]; number_elements: TYPED_POINTER [INTEGER]) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"[
			{
				PangoFontFamily **families;
				gchar **l_name_array = NULL;
				gint i;
				pango_context_list_families (gtk_widget_get_pango_context ((GtkWidget*) $a_widget), &families, $number_elements);

				
				l_name_array = malloc (*$number_elements * sizeof (gchar*));
				
				for (i=0; i < *$number_elements; i++)
				{
					 l_name_array [i] = (gchar *) pango_font_family_get_name (families[i]);
				}
				
				g_free (families);
				
				*(EIF_POINTER *) $name_array = (EIF_POINTER *) l_name_array;
			}
			]"
		end
		
	gchar_array_i_th (a_gchar_array: POINTER; an_index: INTEGER): POINTER is
		require
			an_index_valid: an_index > 0
			array_valid: a_gchar_array /= default_pointer
		external
			"C inline use <gtk/gtk.h>"
		alias
			"[
			{
				(EIF_POINTER) *((gchar**) $a_gchar_array + (int) ($an_index - 1));
			}
			]"
		end

end -- class EV_GTK_DEPENDENT_APPLICATION_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

