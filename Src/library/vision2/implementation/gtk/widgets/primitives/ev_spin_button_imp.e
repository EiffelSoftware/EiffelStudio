indexing
	description: "Eiffel Vision spin button. GTK+ Implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_SPIN_BUTTON_IMP

inherit
	EV_SPIN_BUTTON_I
		redefine
			interface
		end

	EV_GAUGE_IMP
		redefine
			interface,
			initialize,
			make
		end

	EV_TEXT_FIELD_IMP
		rename
			create_change_actions as create_text_change_actions,
			change_actions as text_change_actions,
			change_actions_internal as text_change_actions_internal
		redefine
			make,
			interface,
			initialize,
			set_text
		end

create
	make

feature {NONE} -- Implementation

	make (an_interface: like interface) is
			-- Create the spin button.
		do
			{EV_GAUGE_IMP} Precursor (an_interface)
			set_c_object (C.gtk_spin_button_new (adjustment, 0, 0))

			-- Set the entry widget from EV_TEXT_FIELD
			entry_widget := c_object	
		end

	initialize is
		do
			{EV_TEXT_FIELD_IMP} Precursor
			ev_gauge_imp_initialize --| {EV_GAUGE} Precursor
		end

feature {EV_ANY_I} -- Status setting

-- Version from class: EV_TEXT_FIELD_IMP

	set_text (a_text: STRING) is
			-- Assign `a_text' to `text'.
		do
			Precursor (a_text)
			C.gtk_spin_button_update (entry_widget)
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_SPIN_BUTTON

end -- class EV_SPIN_BUTTON_IMP

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
--| Revision 1.13  2001/07/14 12:46:23  manus
--| Replace --! by --|
--|
--| Revision 1.12  2001/07/14 12:16:27  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.11  2001/06/07 23:08:07  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.5.4.4  2000/10/27 16:54:44  manus
--| Removed undefinition of `set_default_colors' since now the one from EV_COLORIZABLE_IMP is
--| deferred.
--| However, there might be a problem with the definition of `set_default_colors' in the following
--| classes:
--| - EV_TITLED_WINDOW_IMP
--| - EV_WINDOW_IMP
--| - EV_TEXT_COMPONENT_IMP
--| - EV_LIST_ITEM_LIST_IMP
--| - EV_SPIN_BUTTON_IMP
--|
--| Revision 1.5.4.3  2000/09/13 17:02:47  oconnor
--| Redefine set_text to update the integer `value' imediatly.
--|
--| Revision 1.5.4.2  2000/07/24 21:36:10  oconnor
--| inherit action sequences _IMP class
--|
--| Revision 1.5.4.1  2000/05/03 19:08:51  oconnor
--| mergred from HEAD
--|
--| Revision 1.10  2000/04/14 17:05:47  oconnor
--| formatting
--|
--| Revision 1.9  2000/02/22 18:39:39  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.8  2000/02/16 04:01:53  brendel
--| Redefines make from EV_GAUGE_IMP.
--|
--| Revision 1.7  2000/02/15 16:34:31  brendel
--| Fixed bug in initialization found after adding `is_in_default_state' in
--| interface classes.
--|
--| Revision 1.6  2000/02/14 11:40:33  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.5.6.7  2000/02/11 18:25:27  king
--| Added entry widget pointer in EV_TEXT_FIELD_IMP to accomodate the fact that
--| combo box is not an entry widget
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
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
