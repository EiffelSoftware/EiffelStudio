indexing
	description: "Gtk version dependent routines"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GTK_DEPENDENT_ROUTINES

feature -- Implementation

	create_gtk_dialog: POINTER is
			-- Create our gtk dialog
		do
			Result := {EV_GTK_EXTERNALS}.gtk_window_new ({EV_GTK_DEPENDENT_EXTERNALS}.gtk_window_dialog_enum)
		end

	client_area_from_c_object (a_c_object: POINTER): POINTER is
			-- Pointer to the widget that is treated as the main holder of the client area within the window.
		do
			Result := a_c_object
		end

        horizontal_resolution_internal: INTEGER is
                        -- Number of pixels per inch along horizontal axis 
                do
                        Result := 75
                end

        vertical_resolution_internal: INTEGER is
                        -- Number of pixels per inch along vertical axis
                do
                        Result := 75
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

