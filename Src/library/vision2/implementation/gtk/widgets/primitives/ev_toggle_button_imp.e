--| FIXME NOT_REVIEWED this file has not been reviewed
indexing

        description: 
                "EiffelVision toggle button, gtk implementation.";
        status: "See notice at end of class";
        id: "$Id$";
        date: "$Date$";
        revision: "$Revision$"
        
class
        EV_TOGGLE_BUTTON_IMP
        
inherit
        EV_TOGGLE_BUTTON_I
		redefine
			interface
		end
	
	EV_BUTTON_IMP
		redefine
			make,
			interface
		end
        
create
	make

feature {NONE} -- Initialization

        make (an_interface: like interface) is
                        -- Create a gtk toggle button.
		do
			base_make (an_interface)
			set_c_object (C.gtk_toggle_button_new)
		end

feature -- Status report
	
	state: BOOLEAN is
                        -- Is toggle pressed
                do
			Result := C.gtk_toggle_button_get_active (c_object)
                end 
	
feature -- Status setting

        set_state (button_pressed: BOOLEAN) is
                        -- Set Current toggle on and set
                        -- pressed to True.
                do
			C.gtk_toggle_button_set_active (c_object, button_pressed)
                end

        toggle is
			-- Change the state of the toggle button to
			-- opposite
		do
			C.gtk_toggle_button_toggled (c_object)
                end

feature {EV_ANY_I}

	interface: EV_TOGGLE_BUTTON

end -- class EV_TOGGLE_BUTTON_IMP

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
--| Revision 1.17  2000/02/14 11:40:33  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.16.4.5  2000/02/04 04:25:39  oconnor
--| released
--|
--| Revision 1.16.4.4  2000/01/27 19:29:49  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.16.4.3  2000/01/19 17:23:45  oconnor
--| removed call to old ev_textable_imp_initialize
--|
--| Revision 1.16.4.2  1999/12/23 01:35:28  king
--| Removed redundant event commands
--| Implemented to fit in with new structure
--|
--| Revision 1.16.4.1  1999/11/24 17:29:59  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.15.2.3  1999/11/17 01:53:06  oconnor
--| removed "child packing" hacks and obsolete _ref _unref wrappers
--|
--| Revision 1.15.2.2  1999/11/02 17:20:04  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
