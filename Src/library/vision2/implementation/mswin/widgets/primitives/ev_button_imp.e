indexing

        description: 
                "EiffelVision push button. Mswindows implementation.";
        status: "See notice at end of class";
        id: "$Id$";
        date: "$Date$";
        revision: "$Revision$"
        
class
    EV_BUTTON_IMP
        
inherit
    EV_BUTTON_I
        
	EV_BAR_ITEM_IMP
		redefine
			wel_window
		end
        
	EV_TEXT_CONTAINER_IMP
		redefine
			wel_window
		end
	
creation

        make_with_label

feature {NONE} -- Initialization

		make (par: EV_CONTAINER) is
			do
				make_with_label (par, "")
			end

        make_with_label (par: EV_CONTAINER; txt: STRING) is
        		-- Create a wel push button.
		local
			cont_imp: EV_CONTAINER_IMP
		do
			cont_imp ?= par.implementation
			check
				valid_container: cont_imp /= Void
			end

			!!wel_window.make (cont_imp.wel_window, txt, 0, 0, 10, 10, 0)
			set_font (font)
			set_default_size
		end
		
feature {NONE} -- Implementation	
	
	wel_window: WEL_PUSH_BUTTON
end

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


