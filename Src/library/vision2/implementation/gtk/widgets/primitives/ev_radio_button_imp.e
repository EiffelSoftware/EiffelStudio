indexing
        description: "Eiffel Vision radio button. GTK+ implementation."
        status: "See notice at end of class"
        date: "$Date$"
        revision: "$Revision$"
        
class
        EV_RADIO_BUTTON_IMP
        
inherit
        EV_RADIO_BUTTON_I
		redefine
			interface
		end
	
	EV_SELECT_BUTTON_IMP
		redefine
			interface,
			initialize,
			make
		end

	EV_RADIO_PEER_IMP
		redefine
			interface
		end

create
	make

feature {NONE} -- Initialization

        make (an_interface: like interface) is
                        -- Create radio button.
		do
			base_make (an_interface)
			set_c_object (C.gtk_radio_button_new (NULL))
                end

	initialize is
		do
			Precursor
			align_text_left
		end

feature {EV_ANY_I} -- Implementation

	radio_group: POINTER is
		do
			Result := C.gtk_radio_button_group (c_object)
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_RADIO_BUTTON

end -- class EV_RADIO_BUTTON_IMP

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
--| Revision 1.21  2000/05/03 18:20:07  king
--| Made text left aligned
--|
--| Revision 1.20  2000/05/02 18:55:30  oconnor
--| Use NULL instread of Defualt_pointer in C code.
--| Use eiffel_to_c (a) instead of a.to_c.
--|
--| Revision 1.19  2000/04/25 18:51:35  king
--| gslist->radio_group
--|
--| Revision 1.18  2000/02/29 02:21:41  brendel
--| Revised.
--|
--| Revision 1.17  2000/02/25 01:51:38  brendel
--| Added inheritance of EV_RADIO_PEER_IMP, which needs `gslist' effected.
--| Still needs implementing, so old implementation is not removed yet.
--|
--| Revision 1.16  2000/02/24 20:48:54  brendel
--| Changed in compliance with interface.
--|
--| Revision 1.15  2000/02/22 18:39:39  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.14  2000/02/17 02:18:40  oconnor
--| released
--|
--| Revision 1.13  2000/02/14 11:40:32  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.12.6.4  2000/01/27 19:29:48  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.12.6.3  2000/01/19 17:23:45  oconnor
--| removed call to old ev_textable_imp_initialize
--|
--| Revision 1.12.6.2  2000/01/07 00:44:09  king
--| Implemented radio button to work with new c_object structure
--|
--| Revision 1.12.6.1  1999/11/24 17:29:57  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.12.2.3  1999/11/17 01:53:05  oconnor
--| removed "child packing" hacks and obsolete _ref _unref wrappers
--|
--| Revision 1.12.2.2  1999/11/02 17:20:04  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
