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

end -- class EV_GTK_DEPENDENT_ROUTINES
