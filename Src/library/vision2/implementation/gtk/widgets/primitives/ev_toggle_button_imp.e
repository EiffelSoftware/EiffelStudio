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
	
	EV_BUTTON_IMP
		redefine
			make_with_text
		end
        
creation

         make_with_text

feature {NONE} -- Initialization

        make_with_text (par: EV_CONTAINER; txt: STRING) is
                        -- Create a gtk push button.
                local
                        a: ANY
		do
			a ?= txt.to_c
                        widget := gtk_toggle_button_new_with_label ($a)
                end
	
feature -- Status report
	
	pressed: BOOLEAN is
                        -- Is toggle pressed
                do
			Result := c_gtk_toggle_button_active (widget)
                end 
	
feature -- Status setting

        set_pressed (button_pressed: BOOLEAN) is
                        -- Set Current toggle on and set
                        -- pressed to True.
                do
			gtk_toggle_button_set_state (widget, button_pressed)
                end

        toggle is
			-- Change the state of the toggle button to
			-- opposite
		do
			gtk_toggle_button_toggled (widget)
                end
end
