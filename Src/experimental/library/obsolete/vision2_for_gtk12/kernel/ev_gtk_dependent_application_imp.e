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

	EV_ANY_HANDLER

feature -- Initialize

	gtk_dependent_initialize
			-- Gtk dependent `initialize'
		do
			{EV_GTK_EXTERNALS}.gdk_rgb_init
		end

	gtk_dependent_launch_initialize
			-- Gtl dependent initialization for `launch'
		do
			if {EV_GTK_EXTERNALS}.gtk_maj_ver = 1 and then {EV_GTK_EXTERNALS}.gtk_min_ver <= 2 and then {EV_GTK_EXTERNALS}.gtk_mic_ver < 8 then
				print ("This application is designed for Gtk 1.2.8 and above, your current version is 1.2." + {EV_GTK_EXTERNALS}.gtk_mic_ver.out + " and may cause some unexpected behavior%N")
			end
		end

	gdk_cursor_from_pixmap (a_pixmap: EV_PIXMAP; a_x_hotspot, a_y_hotspot: INTEGER): POINTER
			-- Return a GdkCursor constructed from `a_pixmap'
		local
			a_pixmap_imp: EV_PIXMAP_IMP
			bitmap_data: ARRAY [NATURAL_8]
			cur_pix, a_cursor_ptr, fg, bg: POINTER
			a_cur_data: ANY
			a_mask, a_gc: POINTER
		do
			fg := fg_color
			bg := bg_color
			a_pixmap_imp ?= a_pixmap.implementation
			bitmap_data := a_pixmap_imp.bitmap_array
			a_cur_data := bitmap_data.to_c
			cur_pix := {EV_GTK_EXTERNALS}.gdk_pixmap_create_from_data (default_pointer, $a_cur_data,  a_pixmap_imp.width, a_pixmap_imp.height, 1, fg, bg)

			if a_pixmap_imp.mask = Default_pointer then
					-- If mask isn't available then we create one
				a_mask := {EV_GTK_EXTERNALS}.gdk_pixmap_new (default_pointer, a_pixmap_imp.width, a_pixmap_imp.height, 1)
				a_gc := {EV_GTK_EXTERNALS}.gdk_gc_new (a_mask)
				{EV_GTK_EXTERNALS}.gdk_gc_set_function (a_gc, {EV_GTK_EXTERNALS}.Gdk_copy_enum)
				{EV_GTK_EXTERNALS}.gdk_gc_set_foreground (a_gc, fg_color)
				{EV_GTK_EXTERNALS}.gdk_gc_set_background (a_gc, bg_color)
				{EV_GTK_EXTERNALS}.gdk_draw_rectangle (a_mask, a_gc, 1, 0, 0, a_pixmap_imp.width, a_pixmap_imp.height)
				{EV_GTK_EXTERNALS}.gdk_gc_unref (a_gc)
			else
				a_mask := a_pixmap_imp.mask
			end
			a_cursor_ptr := {EV_GTK_EXTERNALS}.gdk_cursor_new_from_pixmap (cur_pix, a_mask, fg, bg, a_x_hotspot, a_y_hotspot)
			Result := a_cursor_ptr
		end

	fg_color: POINTER
				--
		deferred
		end

	bg_color: POINTER
			--
		deferred
		end

	default_gdk_window: POINTER
			-- Pointer to a default GdkWindow that may be used to
			-- access default visual information (color depth).
		deferred
		end

	default_gtk_settings: POINTER
			-- Default GtkSettings
		once
			Result := default_pointer
				-- Needed for compatibility with gtk 2.x
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

