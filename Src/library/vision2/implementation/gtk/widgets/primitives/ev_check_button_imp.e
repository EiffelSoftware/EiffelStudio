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

         make, make_with_text

feature {NONE} -- Initialization

        make (par: EV_CONTAINER) is
                        -- Create a gtk check button.
		do
                        widget := gtk_check_button_new
			initialize
                end
	
end
