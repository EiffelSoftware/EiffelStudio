indexing
	description: "Gtk version dependent routines"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_GTK_DEPENDENT_ROUTINES

