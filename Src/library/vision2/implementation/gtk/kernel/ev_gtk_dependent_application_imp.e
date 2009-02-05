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

	EV_ANY_HANDLER

feature -- Initialize

	gtk_dependent_initialize
			-- Gtk dependent code for `initialize'
		do
				-- Initialize custom styles for gtk.
			initialize_combo_box_style
			initialize_tool_bar_style
		end

	gtk_dependent_launch_initialize
			-- Gtk dependent code for `launch'
		do
			if {EV_GTK_EXTERNALS}.gtk_maj_ver = 1 and then {EV_GTK_EXTERNALS}.gtk_min_ver <= 2 and then {EV_GTK_EXTERNALS}.gtk_mic_ver < 8 then
				print ("This application is designed for Gtk 1.2.8 and above, your current version is 1.2." + {EV_GTK_EXTERNALS}.gtk_mic_ver.out + " and may cause some unexpected behavior%N")
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
			Result := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_widget_create_pango_layout (default_gtk_window, default_pointer)
		end

	pango_iter: POINTER
			-- Retrieve PangoLayoutIter from our default layout object, Result must be freed when not needed
		do
			Result := {EV_GTK_DEPENDENT_EXTERNALS}.pango_layout_get_iter (pango_layout)
		end

	writeable_pixbuf_formats: ARRAYED_LIST [STRING_32]
			-- Array of GdkPixbuf formats that Vision2 can save to on the gtk2.4.x platform
		once
			Result := pixbuf_formats (True)
			Result.compare_objects
		end

	readable_pixbuf_formats: ARRAYED_LIST [STRING_32]
			-- Array of GdkPixbuf formats that Vision2 can load to on the gtk2.4.x platform
		once
			Result := pixbuf_formats (False)
			Result.compare_objects
		end

	pixbuf_formats (a_writeable: BOOLEAN): ARRAYED_LIST [STRING_32]
			-- List of the readable formats available with current Gtk 2.0 library
		local
			formats: POINTER
			i,format_count: INTEGER
			format_name: STRING_32
			pixbuf_format: POINTER
			a_cs: EV_GTK_C_STRING
		do
			formats := {EV_GTK_DEPENDENT_EXTERNALS}.gdk_pixbuf_get_formats
			format_count := {EV_GTK_EXTERNALS}.g_slist_length (formats)
			from
				i := 0
				create Result.make (0)
				create a_cs.set_with_eiffel_string ("")
			until
				i = format_count
			loop
				pixbuf_format := {EV_GTK_EXTERNALS}.g_slist_nth_data (formats, i)
				a_cs.share_from_pointer ({EV_GTK_DEPENDENT_EXTERNALS}.gdk_pixbuf_format_get_name (pixbuf_format))
				format_name := a_cs.string
				if format_name.is_equal (once "jpeg") then
					format_name := once "jpg"
				end
				if a_writeable then
					if {EV_GTK_DEPENDENT_EXTERNALS}.gdk_pixbuf_format_is_writable (pixbuf_format) then
						Result.extend (format_name.as_upper)
					end
				else
					Result.extend (format_name.as_upper)
				end
				i := i + 1
			end
			{EV_GTK_EXTERNALS}.g_slist_free (formats)
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

			if split_values.has (once "italic") or else split_values.has (once "oblique") then
				default_font_style_internal := {EV_FONT_CONSTANTS}.shape_italic
			else
				default_font_style_internal := {EV_FONT_CONSTANTS}.shape_regular
			end

			if split_values.has (once "bold") then
				default_font_weight_internal := {EV_FONT_CONSTANTS}.weight_bold
			elseif split_values.has (once "light") then
				default_font_weight_internal := {EV_FONT_CONSTANTS}.weight_thin
			elseif split_values.has (once "superbold") then
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
			{EV_GTK_EXTERNALS}.g_object_get_string (default_gtk_settings, gtk_font_name_setting.item, $font_name_ptr)
			if font_name_ptr /= default_pointer then
				if previous_font_settings /= default_pointer then
					Result := c_strcmp (previous_font_settings, font_name_ptr) /= 0
					if Result then
							-- Font settings have changed
						{EV_GTK_EXTERNALS}.g_free (previous_font_settings)
						previous_font_settings := font_name_ptr
					else
							-- Font settings have not changed so we free font_name_ptr.
						{EV_GTK_EXTERNALS}.g_free (font_name_ptr)
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
			Result := {EV_GTK_EXTERNALS}.gtk_settings_get_default
		end

	default_font_description: STRING_32
			-- Description string of the current font used
		local
			font_name_ptr: POINTER
			a_cs: EV_GTK_C_STRING
		do
			{EV_GTK_EXTERNALS}.g_object_get_string (default_gtk_settings, gtk_font_name_setting.item, $font_name_ptr)
			if font_name_ptr /= default_pointer then
				create a_cs.make_from_pointer (font_name_ptr)
				Result := a_cs.string
			end
					-- Sometimes when gtk isn't setup correctly the 'gtk-font-name' setting cannot be found, so the default is used instead.
			if Result = Void or else Result.is_empty then
				Result := once "Sans 10"
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
			create Result.make_filled (n_array_elements)
			from
				i := 1
					-- Create an initialize our reusable pointer.
				create utf8_string.set_with_eiffel_string ("")
			until
				i > n_array_elements
			loop
				utf8_string.share_from_pointer (gchar_array_i_th (a_name_array, i))
				Result.put_i_th (utf8_string.string, i)
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
				create Result.make_filled (l_font_count)
			until
				i > l_font_count
			loop
				Result [i] := (l_font_names [i]).as_lower
				i := i + 1
			end
			Result.compare_objects
		end

	default_gtk_window: POINTER deferred end


	window_manager_name: STRING
			-- Name of Window Manager currently running.
		local
			l_display, l_screen, l_wm_name: POINTER
		do
			l_display := {EV_GTK_EXTERNALS}.gdk_display_get_default
			l_screen := {EV_GTK_EXTERNALS}.gdk_display_get_default_screen (l_display)
			l_wm_name := {EV_GTK_EXTERNALS}.gdk_x11_screen_get_window_manager_name (l_screen)
			create Result.make_from_c_pointer (l_wm_name)
		end

feature {NONE} -- Externals

	initialize_combo_box_style
			-- Set the combo box style so that they appear as lists and not menus.
		external
			"C inline use <gtk/gtk.h>"
		alias
			"[
				{
					gtk_rc_parse_string ("style \"v2-combo-style\" {\n GtkComboBox::appears-as-list = 1\n }\n  widget \"*.v2combobox\" style : highest  \"v2-combo-style\" " );
				}
			]"
		end

	initialize_tool_bar_style
			-- Remove the default shadow from the toolbar.
		external
			"C inline use <gtk/gtk.h>"
		alias
			"[
				{
					gtk_rc_parse_string ("style \"v2-toolbar-style\" {\n GtkToolbar::shadow-type = none\n }\n  widget \"*.v2toolbar\" style : highest  \"v2-toolbar-style\" " );
				}
			]"
		end

	retrieve_available_fonts (a_widget: POINTER; name_array: TYPED_POINTER [POINTER]; number_elements: TYPED_POINTER [INTEGER])
			-- Retrieve all available fonts present on the system
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

	gchar_array_i_th (a_gchar_array: POINTER; an_index: INTEGER): POINTER
			-- Returns `an_index' i_th value from gchar** `a_gchar_array'
		require
			an_index_valid: an_index > 0
			array_valid: a_gchar_array /= default_pointer
		external
			"C inline use <gtk/gtk.h>"
		alias
			"(EIF_POINTER) *((gchar**) $a_gchar_array + (int) ($an_index - 1))"
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_GTK_DEPENDENT_APPLICATION_IMP

