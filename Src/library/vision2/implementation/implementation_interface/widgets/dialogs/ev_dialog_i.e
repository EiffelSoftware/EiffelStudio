indexing
	description: "Eiffel Vision dialog. Implementation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	EV_DIALOG_I

inherit
	EV_TITLED_WINDOW_I
		export
			{NONE} set_default_colors
		redefine
			interface
		end

feature -- Status Report

	is_closeable: BOOLEAN is
			-- Is the window closeable by the user?
			-- (Through a clik on the Window Menu, or by
			-- pressing ALT-F4)
		deferred
		end

feature -- Status Setting
	
	enable_closeable is
			-- Set the window to be closeable by the user
			-- (Through a clik on the Window Menu, or by
			-- pressing ALT-F4)
		require
			not_closeable: not is_closeable
		deferred
		ensure
			closeable: is_closeable
		end

	disable_closeable is
			-- Set the window not to be closeable by the user
		require
			closeable: is_closeable
		deferred
		ensure
			not_closeable: not is_closeable
		end

feature -- Basic operations

	block is
			-- Wait until window is closed by the user.
		deferred
		end

	show_modal is
			-- Show and wait until window is closed.
		deferred
		end

feature -- Implementation

	interface: EV_DIALOG
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

end -- class EV_DIALOG_I

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
--| Revision 1.12  2000/04/29 03:01:48  pichery
--| Added feature `is_closeable', `enable/disable_closeable'.
--|
--| Revision 1.11  2000/02/22 18:39:43  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.10  2000/02/14 11:40:37  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.9.6.9  2000/02/08 01:00:12  king
--| Moved modality features from dialog to window
--|
--| Revision 1.9.6.8  2000/02/04 04:09:08  oconnor
--| released
--|
--| Revision 1.9.6.7  2000/02/01 23:24:56  brendel
--| Removed export {NONE} of set_default_minimum_size.
--|
--| Revision 1.9.6.6  2000/01/27 19:30:01  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.9.6.5  2000/01/26 22:08:02  brendel
--| Added `blocking_window' and `set_blocking_window'.
--|
--| Revision 1.9.6.4  2000/01/26 18:10:38  brendel
--| Added features `is_modal', `enable_modal' and `disable_modal'.
--|
--| Revision 1.9.6.3  2000/01/26 01:38:49  brendel
--| Added features `block' and `show_modal'.
--|
--| Revision 1.9.6.2  2000/01/25 18:40:05  oconnor
--| incomplete reorgainisation
--|
--| Revision 1.9.6.1  1999/11/24 17:30:10  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.9.2.3  1999/11/02 17:20:06  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
