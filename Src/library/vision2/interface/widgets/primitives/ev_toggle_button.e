indexing

	description: 
		"EiffelVision toggle button."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class 
	EV_TOGGLE_BUTTON

inherit

	EV_BUTTON
		redefine
			make_with_text, implementation
		end
	
creation
	make, make_with_text
	
feature {NONE} -- Initialization

	make_with_text (par: EV_CONTAINER; txt: STRING) is
			-- Button with 'par' as parent and 'txt' as 
			-- text label
		do
			!EV_TOGGLE_BUTTON_IMP!implementation.make_with_text (par, txt)
			widget_make (par)
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

feature {NONE} -- Implementation

	implementation: EV_TOGGLE_BUTTON_I
	
end -- class EV_TOGGLE_BUTTON
