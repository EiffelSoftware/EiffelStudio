indexing
	description: "EiffelVision check button, gtk implementation.";
	status: "See notice at end of class";
	id: "$Id$";
	date: "$Date$";
	revision: "$Revision$"
	
class
	EV_CHECK_BUTTON_IMP

inherit
	EV_CHECK_BUTTON_I
		redefine
			interface
		end
	
	EV_TOGGLE_BUTTON_IMP
		redefine
			make, set_text, interface, button_widget
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create a gtk check button.
		do
			base_make (an_interface)
			set_c_object (C.gtk_event_box_new)
			button_widget := C.gtk_check_button_new
			C.gtk_widget_show (button_widget)
			C.gtk_container_add (c_object, button_widget)
		end

	button_widget: POINTER 
			-- Pointer to gtkbutton widget as c_object is event box.
			

feature -- Element change

	set_text (txt: STRING) is
			-- Set current button text to `txt'.
			-- Redefined because we want the text to be left-aligned.
		do
			{EV_TOGGLE_BUTTON_IMP} Precursor (txt)

			-- We left-align and vertical_center-position the text
			C.gtk_misc_set_alignment (text_label, 0.0, 0.5)

			if gtk_pixmap /= NULL then
				C.gtk_misc_set_alignment (pixmap_box, 0.0, 0.5)
			end				
		end

feature {EV_ANY_I}

	interface: EV_CHECK_BUTTON
	
end -- class EV_CHECK_BUTTON_IMP

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

--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.12  2001/07/14 12:16:27  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.11  2001/06/07 23:08:07  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.7.4.6  2000/10/27 16:54:43  manus
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
--| Revision 1.7.4.5  2000/09/06 23:18:47  king
--| Reviewed
--|
--| Revision 1.7.4.4  2000/08/08 00:03:15  oconnor
--| Redefined set_default_colors to do nothing in EV_COLORIZABLE_IMP.
--|
--| Revision 1.7.4.3  2000/06/15 21:18:57  king
--| Redefined button_widget to be an attribute that returns gtkwidget
--|
--| Revision 1.7.4.2  2000/06/15 19:09:30  king
--| Now uses event box
--|
--| Revision 1.7.4.1  2000/05/03 19:08:50  oconnor
--| mergred from HEAD
--|
--| Revision 1.10  2000/05/02 18:55:30  oconnor
--| Use NULL instread of Defualt_pointer in C code.
--| Use eiffel_to_c (a) instead of a.to_c.
--|
--| Revision 1.9  2000/02/22 18:39:38  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.8  2000/02/14 11:40:32  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.7.6.5  2000/02/04 04:25:38  oconnor
--| released
--|
--| Revision 1.7.6.4  2000/01/27 19:29:45  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.7.6.3  2000/01/19 17:24:18  oconnor
--| renamed label_widget -> text_label & gtk_pixmap -> pixmap_box
--|
--| Revision 1.7.6.2  1999/12/23 01:33:39  king
--| Implemented check button to new structure
--|
--| Revision 1.7.6.1  1999/11/24 17:29:56  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.7.2.3  1999/11/17 01:53:04  oconnor
--| removed "child packing" hacks and obsolete _ref _unref wrappers
--|
--| Revision 1.7.2.2  1999/11/02 17:20:04  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
