indexing
	description: "Eiffel Vision dialog. GTK+ implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_DIALOG_IMP
	
inherit
	EV_DIALOG_I
		redefine
			initialize,
			interface
		end

	EV_TITLED_WINDOW_IMP
		redefine
			make,
			interface
		end

create
	make

feature {NONE} -- Initialization
	
	make (an_interface: like interface) is
			-- Create empty dialog box.
		do
			base_make (an_interface)
			set_c_object (C.gtk_window_new (C.Gtk_window_dialog_enum))
			C.gtk_object_ref (c_object)
			C.gtk_widget_realize (c_object)
			C.gtk_window_set_position (
				c_object,
				C.Gtk_win_pos_center_enum
			)
		end

feature -- Basic operations

	show_modal is
			-- Show and wait until window is closed.
		do
			enable_modal
			show
			block
		end

feature {NONE} -- Implementation

	interface: EV_DIALOG
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

end -- class EV_DIALOG_IMP

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
--| Revision 1.8  2000/02/14 11:40:31  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.7.4.9  2000/02/08 01:00:12  king
--| Moved modality features from dialog to window
--|
--| Revision 1.7.4.8  2000/02/04 04:25:38  oconnor
--| released
--|
--| Revision 1.7.4.7  2000/01/27 19:29:42  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.7.4.6  2000/01/27 01:03:28  brendel
--| Dialogs now can be resized.
--|
--| Revision 1.7.4.5  2000/01/26 22:08:02  brendel
--| Added `blocking_window' and `set_blocking_window'.
--|
--| Revision 1.7.4.4  2000/01/26 18:10:39  brendel
--| Added features `is_modal', `enable_modal' and `disable_modal'.
--|
--| Revision 1.7.4.3  2000/01/26 01:37:48  brendel
--| Started implementing.
--|
--| Revision 1.7.4.2  2000/01/25 18:40:45  oconnor
--| incomplete reorganisation
--|
--| Revision 1.7.4.1  1999/11/24 17:29:53  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.6.2.3  1999/11/02 17:20:04  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
