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
			make
		end
        
creation

         make, make_with_text

feature {NONE} -- Initialization

        make (par: EV_CONTAINER) is
                        -- Create a gtk toggle button.
		do
                        widget := gtk_toggle_button_new
			initialize 
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

feature -- Event - command association
	
	add_toggle_command ( command: EV_COMMAND; 
			    arguments: EV_ARGUMENTS) is
			-- Add 'command' to the list of commands to be
			-- executed when the button is toggled
		do
			add_command ( "toggled", command,  arguments )
		end

end
