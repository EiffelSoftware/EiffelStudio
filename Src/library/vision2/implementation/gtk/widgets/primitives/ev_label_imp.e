indexing

	description: 
		"EiffelVision label, gtk implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_LABEL_IMP
	
inherit
	EV_LABEL_I
		redefine
			interface
		end

	EV_PRIMITIVE_IMP
		redefine
			interface,
			set_foreground_color,
			foreground_color_pointer
		end

	EV_TEXTABLE_IMP
		redefine
			interface
		end

	EV_FONTABLE_IMP
		redefine
			interface
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create a gtk label.
		do
			base_make (an_interface)
			set_c_object (C.gtk_event_box_new)
			text_label := C.gtk_label_new (NULL)
			C.gtk_widget_show (text_label)
			C.gtk_container_add (c_object, text_label)
		end

feature {NONE} -- Implementation

	foreground_color_pointer: POINTER is
			-- Color of foreground features like text.
		do
			Result := C.gtk_style_struct_fg (
				C.gtk_widget_struct_style (text_label)
			)
		end

feature {EV_ANY_I} -- Implementation

	set_foreground_color (a_color: EV_COLOR) is
			-- Assign `a_color' to `foreground_color'
		do
			real_set_foreground_color (text_label, a_color)
		end

	interface: EV_LABEL

end --class LABEL_IMP

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
--| Revision 1.17  2001/06/07 23:08:07  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.13.4.7  2000/10/27 16:54:44  manus
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
--| Revision 1.13.4.6  2000/09/06 23:18:48  king
--| Reviewed
--|
--| Revision 1.13.4.5  2000/08/16 18:43:22  king
--| Accounted for change in colorizable_imp
--|
--| Revision 1.13.4.4  2000/08/08 00:03:15  oconnor
--| Redefined set_default_colors to do nothing in EV_COLORIZABLE_IMP.
--|
--| Revision 1.13.4.3  2000/08/07 18:50:14  king
--| Corrected foreground color functionality
--|
--| Revision 1.13.4.2  2000/07/28 17:57:35  king
--| Label now inherits from EV_FONTABLE
--|
--| Revision 1.13.4.1  2000/05/03 19:08:50  oconnor
--| mergred from HEAD
--|
--| Revision 1.16  2000/05/02 18:55:30  oconnor
--| Use NULL instread of Defualt_pointer in C code.
--| Use eiffel_to_c (a) instead of a.to_c.
--|
--| Revision 1.15  2000/02/22 18:39:39  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.14  2000/02/14 11:40:32  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.13.6.7  2000/02/04 04:25:38  oconnor
--| released
--|
--| Revision 1.13.6.6  2000/02/02 18:53:03  oconnor
--| put label in event box
--|
--| Revision 1.13.6.5  2000/01/28 21:52:46  oconnor
--| removed undefine of initiliaze from EV_TEXTABLE_IMP
--|
--| Revision 1.13.6.4  2000/01/27 19:29:46  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.13.6.3  2000/01/18 23:43:13  oconnor
--| update for new EV_TEXTABLE_IMP that uses GtkLable directly
--|
--| Revision 1.13.6.2  2000/01/14 23:37:27  king
--| Converted to new structure
--|
--| Revision 1.13.6.1  1999/11/24 17:29:56  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.13.2.3  1999/11/17 01:53:05  oconnor
--| removed "child packing" hacks and obsolete _ref _unref wrappers
--|
--| Revision 1.13.2.2  1999/11/02 17:20:04  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
