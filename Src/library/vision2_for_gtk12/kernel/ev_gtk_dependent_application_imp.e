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

feature -- Initialize

	gtk_dependent_initialize is
			-- Gtk dependent `initialize'
		do
			{EV_GTK_EXTERNALS}.gdk_rgb_init
		end

	gtk_dependent_launch_initialize is
			-- Gtl dependent initialization for `launch'
		do
			if {EV_GTK_EXTERNALS}.gtk_maj_ver = 1 and then {EV_GTK_EXTERNALS}.gtk_min_ver <= 2 and then {EV_GTK_EXTERNALS}.gtk_mic_ver < 8 then
				print ("This application is designed for Gtk 1.2.8 and above, your current version is 1.2." + {EV_GTK_EXTERNALS}.gtk_mic_ver.out + " and may cause some unexpected behavior%N")
			end			
		end

	gdk_cursor_from_pixmap (a_cursor: EV_CURSOR): POINTER is
			-- Return a GdkCursor constructed from `a_cursor'
		local
			a_cursor_imp: EV_PIXMAP_IMP
			bitmap_data: ARRAY [CHARACTER]
			cur_pix, a_cursor_ptr, fg, bg: POINTER
			a_cur_data: ANY
			a_mask, a_gc: POINTER
		do
			fg := fg_color
			bg := bg_color
			a_cursor_imp ?= a_cursor.implementation
			check
				a_cursor_imp_not_void: a_cursor_imp /= Void
			end
			bitmap_data := a_cursor_imp.bitmap_array
			a_cur_data := bitmap_data.to_c
			cur_pix := {EV_GTK_EXTERNALS}.gdk_pixmap_create_from_data (default_pointer, $a_cur_data,  a_cursor_imp.width, a_cursor_imp.height, 1, fg, bg)
			
			if a_cursor_imp.mask = Default_pointer then
					-- If mask isn't available then we create one
				a_mask := {EV_GTK_EXTERNALS}.gdk_pixmap_new (default_pointer, a_cursor_imp.width, a_cursor_imp.height, 1)
				a_gc := {EV_GTK_EXTERNALS}.gdk_gc_new (a_mask)
				{EV_GTK_EXTERNALS}.gdk_gc_set_function (a_gc, {EV_GTK_EXTERNALS}.Gdk_copy_enum)
				{EV_GTK_EXTERNALS}.gdk_gc_set_foreground (a_gc, fg_color)
				{EV_GTK_EXTERNALS}.gdk_gc_set_background (a_gc, bg_color)
				{EV_GTK_EXTERNALS}.gdk_draw_rectangle (a_mask, a_gc, 1, 0, 0, a_cursor_imp.width, a_cursor_imp.height)
				{EV_GTK_EXTERNALS}.gdk_gc_unref (a_gc)
			else
				a_mask := a_cursor_imp.mask
			end

			a_cursor_ptr := {EV_GTK_EXTERNALS}.gdk_cursor_new_from_pixmap (cur_pix, a_mask, fg, bg, a_cursor.x_hotspot, a_cursor.y_hotspot)
			Result := a_cursor_ptr
		end
		
	fg_color: POINTER is
				-- 
		deferred
		end

	bg_color: POINTER is
			-- 
		deferred
		end

	default_gdk_window: POINTER is
			-- Pointer to a default GdkWindow that may be used to
			-- access default visual information (color depth).
		deferred
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

