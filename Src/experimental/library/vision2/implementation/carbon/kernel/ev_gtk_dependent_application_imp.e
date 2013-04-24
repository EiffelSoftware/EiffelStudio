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

feature -- Initialize

	gtk_dependent_initialize
			-- Gtk dependent code for `initialize'
		do
				-- Initialize custom styles for gtk.

		end

	gtk_dependent_launch_initialize
			-- Gtk dependent code for `launch'
		do

		end

feature -- Implementation

	pixel_value_from_point_value (a_point_value: INTEGER): INTEGER
			-- Returns the number of screen pixels represented by `a_point_value'
		do

		end

	point_value_from_pixel_value (a_pixel_value: INTEGER): INTEGER
			-- Returns the number of points represented by `a_pixel_value' screen pixels value
		do

		end

	pango_layout: POINTER
			-- PangoLayout structure used for rendering fonts
		once

		end

	pango_iter: POINTER
			-- Retrieve PangoLayoutIter from our default layout object, Result must be freed when not needed
		do

		end

	writeable_pixbuf_formats: ARRAYED_LIST [STRING_32]
			-- Array of GdkPixbuf formats that Vision2 can save to on the gtk2.4.x platform
		once

		end

	readable_pixbuf_formats: ARRAYED_LIST [STRING_32]
			-- Array of GdkPixbuf formats that Vision2 can load to on the gtk2.4.x platform
		once

		end

	pixbuf_formats (a_writeable: BOOLEAN): ARRAYED_LIST [STRING_32]
			-- List of the readable formats available with current Gtk 2.0 library
		do

		end

	initialize_default_font_values
			-- Initialize values use for creating our default font
		do

		end

	default_font_name: STRING_32
			-- Face name of the default font
		do

		end

	default_font_name_internal: STRING_32

	default_font_point_height: INTEGER
			-- Size of the default font in points
		do

		end

	default_font_point_height_internal: INTEGER

	default_font_style: INTEGER
			-- Style of the default font
		do

		end

	default_font_style_internal: INTEGER

	default_font_weight: INTEGER
			-- Weight of the default font
		do

		end

	default_font_weight_internal: INTEGER

	previous_font_description: STRING_32
		-- Stored value of the default gtk font settings string

	font_settings_changed: BOOLEAN
			-- Have the default font settings been changed by the user
		do

		end

	default_font_description: STRING_32
			-- Description string of the current font used
		do

		end

	default_gtk_settings: POINTER
			-- Default GtkSettings
		once

		end

	font_names_on_system: ARRAYED_LIST [STRING_32]
			-- Retrieve a list of all the font names available on the system
		once

		end

	font_names_on_system_as_lower: ARRAYED_LIST [STRING_32]
			-- Retrieve a list of all the font names available on the system in lower case
			-- This is needed for easy case insensitive lookup in EV_FONT_IMP.
		once

		end

	default_gtk_window: POINTER deferred end


	gdk_cursor_from_pixmap (a_cursor: EV_CURSOR): POINTER
			-- Return a GdkCursor constructed from `a_cursor'
		do

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

