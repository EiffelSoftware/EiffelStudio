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
	
	EV_TOGGLE_BUTTON_IMP
		redefine
			make
		end
        
creation
	make,
	make_with_text

feature {NONE} -- Initialization

        make is
                        -- Create a gtk check button.
		do
                        widget := gtk_check_button_new
			initialize
			gtk_object_ref (widget)
                end

end -- class EV_CHECK_BUTTON_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
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
--|----------------------------------------------------------------
