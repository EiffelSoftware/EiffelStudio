indexing
	description:
		"Eiffel Vision dialog window. Window objects that can be modal, %N%
		%which means the application waits for the user to close the window %N%
		%before it continues. Dialogs cannot be resized by the user."
	status: "See notice at end of class"
	keywords: "dialog, dialogue, popup, window"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_DIALOG

inherit
	EV_TITLED_WINDOW
		redefine 
			implementation,
			create_implementation
		end

create
	default_create

feature -- Basic operations

	block is
			-- Wait until window is closed by the user.
		do
			implementation.block
		end

	show_modal is
			-- Show and wait until window is closed.
		do
			implementation.show_modal
		end

feature {NONE} -- Implementation

	implementation: EV_DIALOG_I
			-- Implementation of the dialog

	create_implementation is
			-- Create implementation of dialog box.
		do
			create {EV_DIALOG_IMP} implementation.make (Current)
		end

end -- class EV_DIALOG

--!-----------------------------------------------------------------------------
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
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.10  2000/02/14 11:40:51  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.9.6.9  2000/02/08 01:00:12  king
--| Moved modality features from dialog to window
--|
--| Revision 1.9.6.8  2000/01/28 22:24:23  oconnor
--| released
--|
--| Revision 1.9.6.7  2000/01/27 19:30:51  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.9.6.6  2000/01/26 22:08:02  brendel
--| Added `blocking_window' and `set_blocking_window'.
--|
--| Revision 1.9.6.5  2000/01/26 18:10:38  brendel
--| Added features `is_modal', `enable_modal' and `disable_modal'.
--|
--| Revision 1.9.6.4  2000/01/26 01:38:49  brendel
--| Added features `block' and `show_modal'.
--|
--| Revision 1.9.6.3  2000/01/25 18:39:16  oconnor
--| formatting, added invariant
--|
--| Revision 1.9.6.2  2000/01/19 22:10:25  oconnor
--| comments, formatting, renamed [display|action]_area -> [display|action]_box
--|
--| Revision 1.9.6.1  1999/11/24 17:30:51  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.9.2.3  1999/11/02 17:20:12  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
