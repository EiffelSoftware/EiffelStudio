--| FIXME NOT_REVIEWED this file has not been reviewed
indexing

        description: 
                "EiffelVision check button, gtk implementation.";
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
			make, set_text, interface
		end
        
create
	make

feature {NONE} -- Initialization

        make (an_interface: like interface) is
                        -- Create a gtk check button.
		do
			base_make (an_interface)
			set_c_object (C.gtk_check_button_new)
                end
			

feature -- Element change

	set_text (txt: STRING) is
			-- Set current button text to `txt'.
			-- Redefined because we want the text to be left-aligned.
		do
			{EV_TOGGLE_BUTTON_IMP} Precursor (txt)

			-- We left-align and vertical_center-position the text
			C.gtk_misc_set_alignment (text_label, 0.0, 0.5)

			if gtk_pixmap /= default_pointer then
				C.gtk_misc_set_alignment (pixmap_box, 0.0, 0.5)
			end				
		end

feature {EV_ANY_I}

	interface: EV_CHECK_BUTTON
	
end -- class EV_CHECK_BUTTON_IMP

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
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
