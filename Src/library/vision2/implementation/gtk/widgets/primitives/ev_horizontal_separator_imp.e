--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description:
		"EiffelVision horizontal separator, gtk implementation";
	status: "See notice at end of class."
	date: "$Date$";
	revision: "$Revision$"

class
	EV_HORIZONTAL_SEPARATOR_IMP

inherit

	EV_HORIZONTAL_SEPARATOR_I
		redefine
			interface
		end

	EV_SEPARATOR_IMP
		redefine
			interface
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
                        -- Create a horizontal gtk seperator
		local
			p: POINTER
                do
			base_make (an_interface)
			set_c_object (C.gtk_event_box_new)
			p := C.gtk_hseparator_new
			C.gtk_widget_show (p)
			C.gtk_container_add (c_object, p)
                end

feature {EV_ANY_I} -- Implementation

	interface: EV_HORIZONTAL_SEPARATOR

end -- class EV_HORIZONTAL_SEPARATOR_IMP

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
--| Revision 1.4  2000/02/14 11:40:32  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.3.6.5  2000/02/04 04:25:38  oconnor
--| released
--|
--| Revision 1.3.6.4  2000/01/27 19:29:46  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.3.6.3  2000/01/21 22:30:46  king
--| Changed c_object to event box
--|
--| Revision 1.3.6.2  2000/01/15 01:25:36  king
--| Implemented to fit in with new structure
--|
--| Revision 1.3.6.1  1999/11/24 17:29:56  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.3.2.3  1999/11/17 01:53:05  oconnor
--| removed "child packing" hacks and obsolete _ref _unref wrappers
--|
--| Revision 1.3.2.2  1999/11/02 17:20:04  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
