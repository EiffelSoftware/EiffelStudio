indexing
	description: "Gtk version dependent routines"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GTK_DEPENDENT_ROUTINES

feature -- Implementation

	create_gtk_dialog: POINTER is
			-- Create and initialize a gtk dialog
		do
			Result := feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_dialog_new
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_dialog_set_has_separator (Result, False)
			feature {EV_GTK_EXTERNALS}.gtk_widget_hide (feature {EV_GTK_EXTERNALS}.gtk_dialog_struct_action_area (Result))
		end

	client_area_from_c_object (a_c_object: POINTER): POINTER is
			-- 
		do
			Result := feature {EV_GTK_EXTERNALS}.gtk_dialog_struct_vbox (a_c_object)
		end

	horizontal_resolution_internal: INTEGER is
			-- Number of pixels per inch along horizontal axis 
		once
			Result := (feature {EV_GTK_EXTERNALS}.gdk_screen_width / feature {EV_GTK_EXTERNALS}.gdk_screen_get_width_mm (feature {EV_GTK_EXTERNALS}.gdk_screen_get_default) * 25.4).rounded
		end

	vertical_resolution_internal: INTEGER is
			-- Number of pixels per inch along vertical axis
		once
			Result := (feature {EV_GTK_EXTERNALS}.gdk_screen_height / feature {EV_GTK_EXTERNALS}.gdk_screen_get_height_mm (feature {EV_GTK_EXTERNALS}.gdk_screen_get_default) * 25.4).rounded
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

