--| FIXME NOT_REVIEWED this file has not been reviewed
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
			interface
		end
	
	EV_BAR_ITEM_IMP

	EV_TEXTABLE_IMP
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
			text_label := C.gtk_label_new (Default_pointer)
			C.gtk_widget_show (text_label)
			C.gtk_container_add (c_object, text_label)
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_LABEL

end --class LABEL_IMP

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
