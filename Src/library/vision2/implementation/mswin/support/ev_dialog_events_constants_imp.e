--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: "This class is used by EV_MESSAGE_DIALOG_IMP.%
				% It gives the identifications of the different%
				% events that can occur for a dialog. It is a%
				% class of constants"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_DIALOG_EVENTS_CONSTANTS_IMP

feature -- General events for dialogs

	Cmd_ok: INTEGER is 1
			-- The `ok' button of the dialog has been clicked

	Cmd_cancel: INTEGER is 2
			-- The `cancel' button of the dialog has been clicked

	Cmd_yes: INTEGER is 3
			-- The `yes' button of the dialog has been clicked

	Cmd_no: INTEGER is 4
			-- The `no' button of dialog has been clicked

	Cmd_abort: INTEGER is 5
			-- The `abort' button of the dialog has been clicked

	Cmd_retry: INTEGER is 6
			-- The `retry' button of the dialog has been clicked

	Cmd_ignore: INTEGER is 7
			-- The `ignore' button of the dialog has been clicked

	Cmd_help: INTEGER is 8
			-- The `help' button of the dialog has been clicked

feature -- Upper constants value

	command_count: INTEGER is 8

end -- class EV_DIALOG_EVENTS_CONSTANTS_IMP

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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.5  2001/06/07 23:08:13  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.3.8.1  2000/05/03 19:09:17  oconnor
--| mergred from HEAD
--|
--| Revision 1.4  2000/02/14 11:40:41  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.3.10.2  2000/01/27 19:30:14  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.3.10.1  1999/11/24 17:30:20  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.3.6.2  1999/11/02 17:20:08  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
