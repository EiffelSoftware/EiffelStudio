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
	make,
	make_with_text

feature {NONE} -- Initialization

        make is
                        -- Create a gtk toggle button.
		do
			-- Create the gtk object.
                        widget := gtk_toggle_button_new
			gtk_object_ref (widget)

			-- Create the `box'.
			initialize

			-- Create the label with a text set to "".
			create_text_label ("")

 			-- We center-align and vertical_center-position the text.
			gtk_misc_set_alignment (gtk_misc (label_widget), 0.5, 0.5)
              end
	
feature -- Status report
	
	state: BOOLEAN is
                        -- Is toggle pressed
                do
			Result := c_gtk_toggle_button_active (widget)
                end 
	
feature -- Status setting

        set_state (button_pressed: BOOLEAN) is
                        -- Set Current toggle on and set
                        -- pressed to True.
                do
			gtk_toggle_button_set_active (widget, button_pressed)
                end

        toggle is
			-- Change the state of the toggle button to
			-- opposite
		do
			gtk_toggle_button_toggled (widget)
                end

feature -- Event - command association
	
	add_toggle_command ( command: EV_COMMAND; 
			    arguments: EV_ARGUMENT) is
			-- Add 'command' to the list of commands to be
			-- executed when the button is toggled
		do
			add_command (widget, "toggled", command,  arguments )
		end

feature -- Event -- removing command association

	remove_toggle_commands is	
			-- Empty the list of commands to be executed
			-- when the button is toggled.
		do
			remove_commands (widget, toggled_id)
		end	

end -- class EV_TOGGLE_BUTTON_IMP

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
