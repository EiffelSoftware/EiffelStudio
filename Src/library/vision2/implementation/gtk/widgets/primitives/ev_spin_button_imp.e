indexing
	description: "Eiffel Vision spin button. GTK+ Implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_SPIN_BUTTON_IMP

inherit
	EV_SPIN_BUTTON_I
		undefine
			set_default_colors
		redefine
			interface
		end

	EV_GAUGE_IMP
		undefine
			set_default_colors
		redefine
			interface,
			initialize
		end

	EV_TEXT_FIELD_IMP
		redefine
			make,
			interface,
			initialize
		end

create
	make

feature {NONE} -- Implementation

	make (an_interface: like interface) is
			-- Create the spin button.
		do
			base_make (an_interface)
			adjustment := C.gtk_adjustment_new (1, 1, 100, 1, 5, 0)
			set_c_object (C.gtk_spin_button_new (adjustment, 0, 0))

			-- Set the entry widget from EV_TEXT_FIELD
			entry_widget := c_object	
		end

	initialize is
		do
			{EV_TEXT_FIELD_IMP} Precursor
			ev_gauge_imp_initialize --| {EV_GAUGE} Precursor
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_SPIN_BUTTON

end -- class EV_SPIN_BUTTON_IMP

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
--| Revision 1.6  2000/02/14 11:40:33  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.5.6.7  2000/02/11 18:25:27  king
--| Added entry widget pointer in EV_TEXT_FIELD_IMP to accomodate the fact that combo box is not an entry widget
--|
--| Revision 1.5.6.6  2000/02/04 04:25:39  oconnor
--| released
--|
--| Revision 1.5.6.5  2000/02/02 01:19:43  brendel
--| Fixed bug where initialize of EV_WIDGET_IMP was called more than once.
--|
--| Revision 1.5.6.4  2000/02/01 01:43:51  brendel
--| Added undefine of set_default_colors from EV_WIDGET.
--|
--| Revision 1.5.6.3  2000/02/01 01:27:55  brendel
--| Revised.
--|
--| Revision 1.5.6.2  2000/01/27 19:29:48  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.5.6.1  1999/11/24 17:29:58  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.5.2.3  1999/11/17 01:53:05  oconnor
--| removed "child packing" hacks and obsolete _ref _unref wrappers
--|
--| Revision 1.5.2.2  1999/11/02 17:20:04  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
