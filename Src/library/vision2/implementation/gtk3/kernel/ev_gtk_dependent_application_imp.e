note
	description:
		"EiffelVision application, GTK+ implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "application"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_GTK_DEPENDENT_APPLICATION_IMP

inherit
	EV_GTK_ENVIRONMENT

	IDENTIFIED
		undefine
			is_equal,
			copy
		end

	EXECUTION_ENVIRONMENT
		rename
			launch as ee_launch
		end

	PLATFORM

	EV_ANY_HANDLER

feature -- Initialize

	gtk_dependent_initialize
			-- Gtk dependent code for `initialize'
		local
			dlg: POINTER
 		do
 				-- The following call seems to be needed for any Xlib function.
			dlg := {GTK2}.gtk_dialog_new
				-- take ownership
				-- Using GDK instead GDK
			dlg := {GDK}.g_object_ref_sink (dlg)
				-- unref the dialog, as we do nothing with it
			{GDK}.g_object_unref (dlg)
				-- destroy dlg
			{GTK2}.gtk_widget_destroy (dlg)
			initialize_gtk_theme_properties
 		end

	initialize_gtk_theme_properties
			-- Description string of the current font used
		local
			str_ptr: POINTER
			l_cs: EV_GTK_C_STRING
		do
				-- On macos, the cursor theme name is not set by default.
			create l_cs.set_with_eiffel_string ("gtk-cursor-theme-name")
			{GTK2}.g_object_get_string (default_gtk_settings, l_cs.item, $str_ptr)
			if str_ptr.is_default_pointer then
				l_cs.set_with_eiffel_string ("gtk-theme-name")
				{GTK2}.g_object_get_string (default_gtk_settings, l_cs.item, $str_ptr)
				if not str_ptr.is_default_pointer then
					l_cs.set_with_eiffel_string ("gtk-cursor-theme-name")
					{GTK2}.g_object_set_string (default_gtk_settings, l_cs.item, str_ptr)
				end
			end
		end

feature -- Implementation

	pixel_value_from_point_value (a_point_value: INTEGER): INTEGER
			-- Returns the number of screen pixels represented by `a_point_value'
		do
			Result := ((a_point_value / 3 * 4) + 0.5).truncated_to_integer
		end

	point_value_from_pixel_value (a_pixel_value: INTEGER): INTEGER
			-- Returns the number of points represented by `a_pixel_value' screen pixels value
		do
			Result := ((a_pixel_value / 4 * 3) + 0.5).truncated_to_integer
		end

	pango_layout: POINTER
			-- PangoLayout structure used for rendering fonts
		once
			Result := {GTK2}.gtk_widget_create_pango_layout (default_gtk_window, default_pointer)
		end

	pango_iter: POINTER
			-- Retrieve PangoLayoutIter from our default layout object, Result must be freed when not needed
		do
			Result := {PANGO}.layout_get_iter (pango_layout)
		end

	initialize_default_font_values
			-- Initialize values use for creating our default font
		local
			font_desc: STRING_32
			font_names, font_names_as_lower: ARRAYED_LIST [STRING_32]
			exit_loop: BOOLEAN
			split_values: LIST [STRING_32]
			i, l_font_names_count: INTEGER
			l_font_item: STRING_32
			l_sans: STRING_32
		do
			from
				font_desc := default_font_description.as_lower
				font_names_as_lower := font_names_on_system_as_lower
				font_names := font_names_on_system
				i := 1
				l_font_names_count := font_names.count
					-- A default is needed should no enumerable fonts be found on the system.
				l_sans := once "Sans"
				default_font_name_internal := l_sans
			until
				exit_loop or else i > l_font_names_count
			loop
				l_font_item := font_names_as_lower [i]
				if font_desc.substring_index (l_font_item, 1) = 1 then
					if default_font_name_internal = l_sans or else l_font_item.count > default_font_name_internal.count then
							default_font_name_internal := font_names [i]
					end
					exit_loop := default_font_name_internal.count = font_desc.count
						-- If the match is perfect then we exit, otherwise we keep looping for the best match.
				end
				i := i + 1
			end

			split_values := font_desc.split (' ')
			split_values.compare_objects
			default_font_point_height_internal := split_values.last.to_integer

			if split_values.has (once {STRING_32} "italic") or else split_values.has (once {STRING_32} "oblique") then
				default_font_style_internal := {EV_FONT_CONSTANTS}.shape_italic
			else
				default_font_style_internal := {EV_FONT_CONSTANTS}.shape_regular
			end

			if split_values.has (once {STRING_32} "bold") then
				default_font_weight_internal := {EV_FONT_CONSTANTS}.weight_bold
			elseif split_values.has (once {STRING_32} "light") then
				default_font_weight_internal := {EV_FONT_CONSTANTS}.weight_thin
			elseif split_values.has (once {STRING_32} "superbold") then
				default_font_weight_internal := {EV_FONT_CONSTANTS}.weight_black
			else
				default_font_weight_internal := {EV_FONT_CONSTANTS}.weight_regular
			end
		end

	default_font_name: STRING_32
			-- Face name of the default font
		do
			if font_settings_changed then
				initialize_default_font_values
			end
			Result := default_font_name_internal
		end

	default_font_name_internal: STRING_32

	default_font_point_height: INTEGER
			-- Size of the default font in points
		do
			if font_settings_changed then
				initialize_default_font_values
			end
			Result := default_font_point_height_internal
		end

	default_font_point_height_internal: INTEGER

	default_font_style: INTEGER
			-- Style of the default font
		do
			if font_settings_changed then
				initialize_default_font_values
			end
			Result := default_font_style_internal
		end

	default_font_style_internal: INTEGER

	default_font_weight: INTEGER
			-- Weight of the default font
		do
			if font_settings_changed then
				initialize_default_font_values
			end
			Result := default_font_weight_internal
		end

	default_font_weight_internal: INTEGER

	font_settings_changed: BOOLEAN
			-- Have the default font settings been changed by the user
		local
			font_name_ptr: POINTER
		do
			{GTK2}.g_object_get_string (default_gtk_settings, gtk_font_name_setting.item, $font_name_ptr)
			if font_name_ptr /= default_pointer then
				if previous_font_settings /= default_pointer then
					Result := c_strcmp (previous_font_settings, font_name_ptr) /= 0
					if Result then
							-- Font settings have changed
						{GDK}.g_free (previous_font_settings)
						previous_font_settings := font_name_ptr
					else
							-- Font settings have not changed so we free font_name_ptr.
						{GDK}.g_free (font_name_ptr)
					end
				else
					Result := True
					previous_font_settings := font_name_ptr
				end
			else
				Result := True
			end
		end

	previous_font_settings: POINTER
		-- Pointer to the previous gtk-settings font value.

	c_strcmp (ptr1, ptr2: POINTER): INTEGER
		external
			"C inline use <string.h>"
		alias
			"return strcmp ((const char*) $ptr1, (const char*) $ptr2);"
		end

	default_gtk_settings: POINTER
			-- Default GtkSettings
		once
			Result := {GTK}.gtk_settings_get_default
		end

	default_font_description: STRING_32
			-- Description string of the current font used
		local
			font_name_ptr: POINTER
			a_cs: EV_GTK_C_STRING
			l_result: detachable STRING_32
		do
			{GTK2}.g_object_get_string (default_gtk_settings, gtk_font_name_setting.item, $font_name_ptr)
			if font_name_ptr /= default_pointer then
				create a_cs.make_from_pointer (font_name_ptr)
				l_result := a_cs.string
			end
					-- Sometimes when gtk isn't setup correctly the 'gtk-font-name' setting cannot be found, so the default is used instead.
			if l_result = Void or else l_result.is_empty then
				Result := once {STRING_32} "Sans 10"
			else
				Result := l_result
			end
		end

	gtk_font_name_setting: EV_GTK_C_STRING
			-- String optimization for gtk-font-name property string
		once
			Result := "gtk-font-name"
		end

	font_names_on_system: ARRAYED_LIST [STRING_32]
			-- Retrieve a list of all the font names available on the system
		local
			a_name_array: POINTER
			i, n_array_elements: INTEGER
			utf8_string: EV_GTK_C_STRING
		once
			retrieve_available_fonts (default_gtk_window, $a_name_array, $n_array_elements)
			create Result.make (n_array_elements)
			from
				i := 1
					-- Create an initialize our reusable pointer.
				create utf8_string.set_with_eiffel_string ("")
			until
				i > n_array_elements
			loop
				utf8_string.share_from_pointer (gchar_array_i_th (a_name_array, i))
				Result.extend (utf8_string.string)
				i := i + 1
			end
			Result.compare_objects
			a_name_array.memory_free
		end

	font_names_on_system_as_lower: ARRAYED_LIST [STRING_32]
			-- Retrieve a list of all the font names available on the system in lower case
			-- This is needed for easy case insensitive lookup in EV_FONT_IMP.
		local
			i, l_font_count: INTEGER
			l_font_names: like font_names_on_system
		once
			from
				i := 1
				l_font_names := font_names_on_system
				l_font_count := l_font_names.count
				create Result.make (l_font_count)
			until
				i > l_font_count
			loop
				Result.extend ((l_font_names [i]).as_lower)
				i := i + 1
			end
			Result.compare_objects
		end

	default_gtk_window: POINTER deferred end

	window_manager_name: STRING
			-- Name of Window Manager currently running.
		local
			l_wm_name: POINTER
		do
			if {GTK}.is_x11_session then
				l_wm_name := gdk_x11_screen_get_window_manager_name ({GDK_HELPERS}.default_screen)
				create Result.make_from_c (l_wm_name)
			elseif {GTK}.is_wayland_session then
				Result := once "wayland"
			else
				Result := once "unknown"
			end
		end

feature {NONE} -- Externals

	frozen gdk_x11_screen_get_window_manager_name (a_screen: POINTER): POINTER
		external
			"C inline use %"ev_c_util.h%""
		alias
			"[
				#ifdef GDK_WINDOWING_X11
					return (EIF_POINTER) gdk_x11_screen_get_window_manager_name ((GdkScreen*) $a_screen);
				#else
					return "unknown";
				#endif
			]"
		end


	retrieve_available_fonts (a_widget: POINTER; name_array: TYPED_POINTER [POINTER]; number_elements: TYPED_POINTER [INTEGER])
			-- Retrieve all available fonts present on the system
		external
			"C inline use <ev_gtk.h>"
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

	gchar_array_i_th (a_gchar_array: POINTER; an_index: INTEGER): POINTER
			-- Returns `an_index' i_th value from gchar** `a_gchar_array'
		require
			an_index_valid: an_index > 0
			array_valid: a_gchar_array /= default_pointer
		external
			"C inline use <ev_gtk.h>"
		alias
			"(EIF_POINTER) *((gchar**) $a_gchar_array + (int) ($an_index - 1))"
		end

note
	copyright:	"Copyright (c) 1984-2023, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class EV_GTK_DEPENDENT_APPLICATION_IMP











