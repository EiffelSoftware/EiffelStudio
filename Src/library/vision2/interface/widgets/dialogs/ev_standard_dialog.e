indexing
	description: "EiffelVision standard dialog."
	status: "See notice at end of class"
	keywords: "modal, ok, cancel"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_STANDARD_DIALOG

inherit
	EV_ANY
		redefine
			implementation,
			create_action_sequences
		end

feature {NONE} -- Initialization

	create_action_sequences is
			-- Initialize ok/cancel actions.
		do
			Precursor
			create ok_actions
			create cancel_actions
		end

feature -- Events

	ok_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions performed when user clicks OK.

	cancel_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions performed when user cancels.

feature -- Access

	title: STRING is
			-- Title of dialog shown in title bar.
		do
			Result := implementation.title
		ensure
			bridge_ok: Result.is_equal (implementation.title)
		end

	blocking_window: EV_WINDOW is
			-- Window this dialog is a transient for.
		do
			Result := implementation.blocking_window
		ensure
			bridge_ok: Result = implementation.blocking_window
		end

feature -- Status report

	selected_button: STRING is
			-- Label of the last clicked button.
		do
			Result := implementation.selected_button
		ensure
			bridge_ok: Result /= Void implies
				Result.is_equal (implementation.selected_button)
		end

feature -- Status setting

	show_modal is
			-- Show the dialog and wait until the user closes it.
		do
			implementation.show_modal
		end

	set_title (a_title: STRING) is
			-- Set the title of the dialog.
		do
			implementation.set_title (a_title)
		ensure
			assigned: title.is_equal (a_title)
		end

	set_blocking_window (a_window: EV_WINDOW) is
			-- Set as transient for `a_window'.
		do
			implementation.set_blocking_window (a_window)
		ensure
			assigned: blocking_window = a_window
		end

feature {NONE} -- Implementation

	implementation: EV_STANDARD_DIALOG_I

invariant
	title_not_void: title /= Void

end -- class EV_STANDARD_DIALOG

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
--| Revision 1.8  2000/02/14 11:40:50  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.7.6.7  2000/01/28 22:24:23  oconnor
--| released
--|
--| Revision 1.7.6.6  2000/01/27 23:47:00  brendel
--| Improved contracts.
--| Added feature selected_button.
--|
--| Revision 1.7.6.5  2000/01/27 19:30:50  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.7.6.4  2000/01/27 17:04:48  brendel
--| Added blocking_window and set-blocking_window.
--|
--| Revision 1.7.6.3  2000/01/27 02:38:20  brendel
--| Revised with features: set_title, title, show_modal, ok_actions and
--| cancel_actions.
--|
--| Revision 1.7.6.2  2000/01/26 18:16:48  brendel
--| Cleanup.
--| Fate of this class is uncertain.
--|
--| Revision 1.7.6.1  1999/11/24 17:30:51  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.7.2.3  1999/11/04 23:10:54  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.7.2.2  1999/11/02 17:20:12  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
