indexing
	description:
		"Eiffel Vision standard dialog. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_STANDARD_DIALOG_IMP

inherit
	EV_STANDARD_DIALOG_I

	EV_STANDARD_DIALOG_ACTION_SEQUENCES_IMP
	
	EV_DIALOG_CONSTANTS
		export
			{NONE} all
		end

feature -- Access

	blocking_window: EV_WINDOW
			-- Window this dialog is a transient for.

feature -- Status setting

	show_modal_to_window (a_window: EV_WINDOW) is
			-- Show the window and wait until the user closed it.
			--| A window is required for the gtk implementation.
		local
			modal_to: WEL_COMPOSITE_WINDOW
			app_imp: EV_APPLICATION_IMP
			app: EV_APPLICATION
		do
			app := (create {EV_ENVIRONMENT}).application
			app_imp ?= app.implementation
			set_blocking_window (a_window)
			modal_to ?= blocking_window.implementation
			activate (modal_to)
			set_blocking_window (Void)
			if selected then
				selected_button := ev_ok
				if ok_actions_internal /= Void then
					ok_actions_internal.call ([])
				end
			else
				selected_button := ev_cancel
				if cancel_actions_internal /= Void then
					cancel_actions_internal.call ([])
				end
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

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
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
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.12  2001/07/12 20:58:45  rogers
--| Fixed a bug in `show_modal_to_window'. After `ativate' has been called,
--| we now set the blocking window to `Void', as blocking window should be
--| `Void' when the dialog is closed. We also now inherit
--| EV_DIALOG_CONSTANTS.
--|
--| Revision 1.11  2001/06/07 23:08:14  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.6.4.14  2001/01/02 22:12:25  rogers
--| Removed unused local variable from show_modal_to_window.
--|
--| Revision 1.6.4.13  2000/12/29 15:30:22  pichery
--| Removed the WEL_BLOCKING_DISPATCHER. It is now useless
--| with the new implementation for Dialogs
--|
--| Revision 1.6.4.12  2000/10/04 17:54:01  rogers
--| Removed unreferenced variable from show_modal_to_window.
--|
--| Revision 1.6.4.11  2000/09/05 17:51:45  rogers
--| Show_modal_to_window now sets the blocking window. Removed redundent
--| code from show_modal_to_window as the window passed as an argument
--| can never be Void.
--|
--| Revision 1.6.4.10  2000/08/16 22:06:27  rogers
--| Renamed show_modal to show_modal_to_window.
--|
--| Revision 1.6.4.9  2000/08/11 23:52:05  rogers
--| Corrected copyright clause.
--|
--| Revision 1.6.4.8  2000/08/04 00:44:02  rogers
--| Replaced action sequence calls made through the interface of `Current' with
--| calls to the internal action sequences.
--|
--| Revision 1.6.4.7  2000/07/24 23:59:26  rogers
--| Now inherits EV_STANDARD_DIALOG_ACTION_SEQUENCES_IMP.
--|
--| Revision 1.6.4.6  2000/07/20 20:03:25  rogers
--| Removed hide and show.
--|
--| Revision 1.6.4.5  2000/07/20 19:22:34  rogers
--| Added hide and show. Still to be implemented.
--|
--| Revision 1.6.4.4  2000/06/15 03:42:59  pichery
--| Fixed bug. The blocking dispatcher was
--| enabled at the end when it should not.
--|
--| Revision 1.6.4.3  2000/06/14 22:21:21  rogers
--| Show_modal now references the new feature, windows from EV_APPLICATION.
--|
--| Revision 1.6.4.2  2000/06/13 03:58:47  pichery
--| Disable blocking dispatcher before showing the
--| standard dialogs
--|
--| Revision 1.6.4.1  2000/05/03 19:09:23  oconnor
--| mergred from HEAD
--|
--| Revision 1.10  2000/04/19 00:38:40  brendel
--| Cosmetics.
--|
--| Revision 1.9  2000/03/07 02:01:32  brendel
--| Released
--|
--| Revision 1.8  2000/02/23 04:51:29  pichery
--| removed 2 commented lines in order to have actions performed when
--| clicking on "ok" or "cancel" buttons.
--|
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
