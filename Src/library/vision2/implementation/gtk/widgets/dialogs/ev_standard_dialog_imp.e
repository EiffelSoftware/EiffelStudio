indexing
	description: "Eiffel Vision standard dialog. GTK+ implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_STANDARD_DIALOG_IMP

inherit
	EV_STANDARD_DIALOG_I
		redefine
			interface
		end

	EV_ANY_IMP
		redefine
			interface
		end

feature -- Access

	title: STRING is
			-- Title of dialog shown in title bar.
		do
			create Result.make (0)
			Result.from_c (C.c_gtk_window_title (c_object))
		end

	blocking_window: EV_WINDOW
			-- Window this dialog is a transient for.

feature -- Status report

	selected_button: STRING
			-- Label of the last clicked button.

feature -- Status setting

	show_modal is
			-- Show the dialog and wait until the user closes it.
		do
			selected_button := Void
			C.gtk_widget_show (c_object)
			block
		end

	set_title (a_title: STRING) is
			-- Set the title of the dialog.
		do
			C.gtk_window_set_title (c_object, eiffel_to_c (a_title))
		end

	set_blocking_window (a_window: EV_WINDOW) is
			-- Set as transient for `a_window'.
		local
			win_imp: EV_WINDOW_IMP
		do
			blocking_window := a_window
			win_imp ?= a_window.implementation
			C.gtk_window_set_transient_for (c_object, win_imp.c_object)
		end

feature {NONE} -- Implementation

	block is
			-- Wait until window is closed by the user.
		local
			app: EV_APPLICATION
		do
			app := (create {EV_ENVIRONMENT}).application
			from until selected_button /= Void loop
				app.sleep (100)
				app.process_events
			end
		end

	on_cancel is
			-- Close window and call action sequence.
		do
			selected_button := "Cancel"
			C.gtk_widget_hide (c_object)
			interface.cancel_actions.call ([])
		end

	on_ok is
			-- Close window and call action sequence.
		do
			selected_button := "OK"
			C.gtk_widget_hide (c_object)
			interface.ok_actions.call ([])
		end

	interface: EV_STANDARD_DIALOG

end -- class EV_STANDARD_DIALOG_IMP

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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.8  2000/02/14 11:40:31  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.7.6.7  2000/02/04 04:25:37  oconnor
--| released
--|
--| Revision 1.7.6.6  2000/01/27 23:52:53  brendel
--| Added feature selected_button.
--| Finished implementing events.
--|
--| Revision 1.7.6.5  2000/01/27 19:29:41  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.7.6.4  2000/01/27 17:04:48  brendel
--| Added blocking_window and set-blocking_window.
--|
--| Revision 1.7.6.3  2000/01/27 02:38:19  brendel
--| Revised with features: set_title, title, show_modal, ok_actions and
--| cancel_actions.
--|
--| Revision 1.7.6.2  2000/01/26 18:16:48  brendel
--| Cleanup.
--| Fate of this class is uncertain.
--|
--| Revision 1.7.6.1  1999/11/24 17:29:52  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.7.2.2  1999/11/02 17:20:04  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
