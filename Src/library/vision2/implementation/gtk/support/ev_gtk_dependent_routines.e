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

end -- class EV_GTK_DEPENDENT_ROUTINES
