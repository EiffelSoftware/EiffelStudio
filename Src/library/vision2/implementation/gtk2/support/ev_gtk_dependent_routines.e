indexing
	description: "Gtk version dependent routines"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GTK_DEPENDENT_ROUTINES

feature -- Implementation

	frozen add_g_type_string (an_array: POINTER; a_pos: INTEGER) is
			-- Add G_TYPE_STRING constant in `an_array' at `a_pos' bytes from beginning
			-- of `an_array'.
		require
			an_array_not_null: an_array /= default_pointer
			a_pos_nonnegative: a_pos >= 0
		external
			"C inline use <gtk/gtk.h>"
		alias
			"[
				{
					GType type = G_TYPE_STRING;
					memcpy ((char *) $an_array + $a_pos, &type, sizeof(GType));
				}
			]"
		end

	frozen add_gdk_type_pixbuf (an_array: POINTER; a_pos: INTEGER) is
			-- Add GDK_TYPE_PIXBUF constant in `an_array' at `a_pos' bytes from beginning
			-- of `an_array'.
		require
			an_array_not_null: an_array /= default_pointer
			a_pos_nonnegative: a_pos >= 0
		external
			"C inline use <gtk/gtk.h>"
		alias
			"[
				{
					GType type = GDK_TYPE_PIXBUF;
					memcpy ((char *) $an_array + $a_pos, &type, sizeof(GType));
				}
			]"
		end

	frozen sizeof_gtype: INTEGER is
			-- Size of the `GType' C type
		external
			"C inline use <gtk/gtk.h>"
		alias
			"sizeof(GType)"
		end	

	create_gtk_dialog: POINTER is
			-- Create and initialize a gtk dialog
		do
			Result := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_dialog_new
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_dialog_set_has_separator (Result, False)
			{EV_GTK_EXTERNALS}.gtk_widget_hide ({EV_GTK_EXTERNALS}.gtk_dialog_struct_action_area (Result))
		end

	client_area_from_c_object (a_c_object: POINTER): POINTER is
			-- 
		do
			Result := {EV_GTK_EXTERNALS}.gtk_dialog_struct_vbox (a_c_object)
		end

	horizontal_resolution_internal: INTEGER is
			-- Number of pixels per inch along horizontal axis 
		once
			Result := ({EV_GTK_EXTERNALS}.gdk_screen_width / {EV_GTK_EXTERNALS}.gdk_screen_get_width_mm ({EV_GTK_EXTERNALS}.gdk_screen_get_default) * 25.4).rounded
		end

	vertical_resolution_internal: INTEGER is
			-- Number of pixels per inch along vertical axis
		once
			Result := ({EV_GTK_EXTERNALS}.gdk_screen_height / {EV_GTK_EXTERNALS}.gdk_screen_get_height_mm ({EV_GTK_EXTERNALS}.gdk_screen_get_default) * 25.4).rounded
		end

end -- class EV_GTK_DEPENDENT_ROUTINES

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

