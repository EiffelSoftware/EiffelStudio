indexing 
	description: "EiffelVision file open dialog."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FILE_OPEN_DIALOG_IMP

inherit
	EV_FILE_OPEN_DIALOG_I

	EV_FILE_DIALOG_IMP

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create a window with a parent.
		local
			a: ANY
			s: STRING
			par_imp: EV_CONTAINER_IMP
		do
			s := "Open file dialog"
			a := s.to_c
			par_imp ?= par.implementation

			-- Create the gtk object.
			widget := gtk_file_selection_new ($a)

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


end -- class EV_FILE_OPEN_DIALOG_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
