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
			Result := feature {EV_GTK_EXTERNALS}.gtk_window_new (feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_window_dialog_enum)
		end

	client_area_from_c_object (a_c_object: POINTER): POINTER is
			-- Pointer to the widget that is treated as the main holder of the client area within the window.
		do
			Result := a_c_object
		end

end -- class EV_GTK_DEPENDENT_ROUTINES
