--| FIXME Not for release
indexing
	description:
		"Eiffel Vision standard dialog, Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_STANDARD_DIALOG_IMP

inherit
	EV_STANDARD_DIALOG_I

feature -- Access

	blocking_window: EV_WINDOW
			-- Window this dialog is a transient for.

feature -- Status setting

	show_modal is
			-- Show the window and wait until the user closed it.
		local
			modal_to: WEL_COMPOSITE_WINDOW
		do
			if blocking_window /= Void then
				modal_to ?= blocking_window.implementation
			else
				modal_to ?= (create {EV_ENVIRONMENT}).application.first_window.implementation
			end
			activate (modal_to)
			if selected then
				selected_button := "OK"
				--interface.ok_actions.call ([])
			else
				selected_button := "Cancel"
				--interface.cancel_actions.call ([])
			end
		end

	set_blocking_window (a_window: EV_WINDOW) is
			-- Set as transient for `a_window'.
		do
			blocking_window := a_window
		end

feature -- Status report

	selected_button: STRING
			-- Label of last clicked button.

feature -- Deferred

	activate (a_parent: WEL_COMPOSITE_WINDOW) is
		deferred
		end

	selected: BOOLEAN is
		deferred
		end

end -- class EV_STANDARD_DIALOG_IMP

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.7  2000/02/14 11:40:42  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.6.6.4  2000/01/27 23:50:22  brendel
--| Finished implementing show_modal.
--| Added feature selected_button.
--|
--| Revision 1.6.6.3  2000/01/27 19:30:19  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.6.6.2  2000/01/27 18:09:21  brendel
--| Implemented in compliance with new interface.
--|
--| Revision 1.6.6.1  1999/11/24 17:30:25  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.6.2.2  1999/11/02 17:20:09  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
