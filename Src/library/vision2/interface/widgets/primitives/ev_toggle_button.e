indexing

	description: 
		"EiffelVision toggle button. It looks and acts like   %
		% a button. But the button looks raised when it isn't %
		% checked, and sunken when it is checked."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class 
	EV_TOGGLE_BUTTON

inherit

	EV_BUTTON
		redefine
			make, make_with_text, implementation
		end
	
creation
	make, make_with_text
	
feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
		-- Empty button
		do
			!EV_TOGGLE_BUTTON_IMP!implementation.make (par)
			initialize (par)	
		end	
	
	make_with_text (par: EV_CONTAINER; txt: STRING) is
			-- Button with 'par' as parent and 'txt' as 
			-- text label
		do
			!EV_TOGGLE_BUTTON_IMP!implementation.make_with_text (par, txt)
			initialize (par)
		end			
		
feature -- Status report
	
	pressed: BOOLEAN is
                        -- Is toggel pressed
                require
                        exists: not destroyed
                do
                        Result := implementation.pressed
                end 
	
feature -- Status setting

        set_pressed (button_pressed: BOOLEAN) is
                        -- Set Current toggle on and set
                        -- pressed to True.
                require
                        exists: not destroyed
                do
                        implementation.set_pressed (button_pressed)
                ensure
                        correct_state: pressed = button_pressed
                end

        toggle is
			-- Change the state of the toggel button to
			-- opposite
		require
                        exists: not destroyed
                do
                        implementation.toggle
                ensure
                        state_is_true: pressed = not old pressed
                end

	
feature -- Event - command association
	
	add_toggle_command ( command: EV_COMMAND; 
			     arguments: EV_ARGUMENTS) is
			-- Add 'command' to the list of commands to be
			-- executed when the button is toggled
		require
			valid_command: command /= Void
		do
			implementation.add_toggle_command ( command, 
							    arguments )
		end	

feature {NONE} -- Implementation

	implementation: EV_TOGGLE_BUTTON_I
	
end -- class EV_TOGGLE_BUTTON

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
