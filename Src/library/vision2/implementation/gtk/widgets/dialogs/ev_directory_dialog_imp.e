indexing 
	description: "EiffelVision file selection dialog."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_DIRECTORY_DIALOG_IMP

inherit
	EV_DIRECTORY_DIALOG_I

	EV_FILE_DIALOG_IMP
		rename
			file_name as directory_name
		export {NONE}
			file
		redefine
			ok_widget_execute			
		end

create
	make,
	make_with_text

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create a directory selection dialog with `par' as
			-- parent.
		local
			a: ANY
			s: STRING
			par_imp: EV_CONTAINER_IMP
		do
			s := "Directory selection dialog"
			a := s.to_c
			par_imp ?= par.implementation

			-- Create the gtk object.
			widget := c_gtk_directory_selection_new ($a)

			-- Attach the window to `par'.
			gtk_window_set_transient_for (widget, par_imp.widget)
			-- Set it as modal (nothing can be done
			-- until the window is closed).
			gtk_window_set_modal (widget, True)

			-- Make it appear where the mouse is.
			gtk_window_set_position (GTK_WINDOW (widget), WINDOW_POSITION_MOUSE)

			-- Connect destroy command to `OK' and `Cancel' buttons.
			add_dialog_close_command (ok_widget)
			add_dialog_close_command (cancel_widget)		
		end

	make_with_text (par: EV_CONTAINER; txt: STRING) is
			-- Create a directory selection dialog with `par' as
			-- parent and `txt' as title.
		do
			make (par)
			set_title (txt)
		end

feature {EV_FILE_DIALOG_IMP} -- Execute procedure

	ok_widget_execute (argument: EV_ARGUMENT1[EV_STANDARD_DIALOG_I]; data: EV_EVENT_DATA) is
			-- Command to close the dialog when the user clicks
			-- on the `ok' button, only if there is a directory selected.
		local
			dialog_imp: EV_STANDARD_DIALOG_IMP
		do
			if (not directory_name.is_equal ("")) then
				dialog_imp ?= argument.first
				dialog_imp.hide
					-- Hide the gtk object
					-- The user must no forget to destroy
					-- the dialog when no more needed.
			end
		end

end -- class EV_DIRECTORY_DIALOG_IMP

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!----------------------------------------------------------------
