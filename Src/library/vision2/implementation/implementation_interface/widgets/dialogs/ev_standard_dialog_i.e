indexing
	description: "EiffelVision standard dialog. Implementation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_STANDARD_DIALOG_I

inherit
	EV_ANY_I
		redefine
			interface
		end

	EV_POSITIONABLE_I
		redefine
			interface
		end
		
	EV_STANDARD_DIALOG_ACTION_SEQUENCES_I

feature -- Access

	title: STRING is
			-- Title of dialog shown in title bar.
		deferred
		end

	blocking_window: EV_WINDOW is
			-- Window this dialog is a transient for.
		deferred
		end

feature -- Status report

	selected_button: STRING is
			-- Label of the last clicked button.
		deferred
		end

feature -- Status setting

	show_modal_to_window (a_window: EV_WINDOW) is
			-- Show the dialog modal with respect to `a_window'.
		deferred
		end

	set_title (a_title: STRING) is
			-- Set the title of the dialog.
		deferred
		end

feature {NONE} -- Implementation

	interface: EV_STANDARD_DIALOG

end -- class EV_STANDARD_DIALOG_I

--|-----------------------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2000 Interactive Software Engineering Inc.
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
--|-----------------------------------------------------------------------------

--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.10  2001/07/14 12:46:24  manus
--| Replace --! by --|
--|
--| Revision 1.9  2001/07/14 12:16:29  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.8  2001/06/07 23:08:09  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.5.4.8  2000/12/15 19:21:49  king
--| Removed invalid postsconditiondgets/common_dialogs/ev_standard_dialog_i.e
--|
--| Revision 1.5.4.7  2000/09/04 18:20:00  oconnor
--| inherit EV_POSITIONABLE_I
--|
--| Revision 1.5.4.6  2000/08/16 19:52:00  king
--| Implemented show_modal_to_window
--|
--| Revision 1.5.4.5  2000/07/24 21:30:46  oconnor
--| inherit action sequences _I class
--|
--| Revision 1.5.4.4  2000/07/20 20:03:00  king
--| Removed hide/show
--|
--| Revision 1.5.4.3  2000/07/20 18:45:27  king
--| Added hide/show, updated show comment
--|
--|
--| Revision 1.5.4.1  2000/05/03 19:09:03  oconnor
--| mergred from HEAD
--|
--| Revision 1.7  2000/02/22 18:39:43  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.6  2000/02/14 11:40:37  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.5.6.8  2000/02/04 04:07:01  oconnor
--| released
--|
--| Revision 1.5.6.7  2000/01/27 23:47:40  brendel
--| Added feature selected_button.
--|
--| Revision 1.5.6.6  2000/01/27 19:30:00  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.5.6.5  2000/01/27 18:06:42  brendel
--| Added redefinition of interface.
--|
--| Revision 1.5.6.4  2000/01/27 17:04:48  brendel
--| Added blocking_window and set-blocking_window.
--|
--| Revision 1.5.6.3  2000/01/27 02:38:20  brendel
--| Revised with features: set_title, title, show_modal, ok_actions and
--| cancel_actions.
--|
--| Revision 1.5.6.2  2000/01/26 18:16:48  brendel
--| Cleanup.
--| Fate of this class is uncertain.
--|
--| Revision 1.5.6.1  1999/11/24 17:30:09  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.5.2.3  1999/11/04 23:10:40  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.5.2.2  1999/11/02 17:20:06  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
