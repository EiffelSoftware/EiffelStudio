indexing

	description: 
		"EiffelVision toggle button"
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class 
	EV_TOGGLE_BUTTON

inherit

	EV_BUTTON
		redefine
			make
		end
	
creation
	make
	
feature {NONE} -- Initialization

        make (parent: CONTAINER) is
                        -- Create a push button with, `parent' as
                        -- parent

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
                        -- state to True.
                require
                        exists: not destroyed
                do
                        implementation.set_pressed (button_pressed)
                ensure
                        correct_state: pressed = button_pressed
                end;

        arm is
                        -- Set `state' to True and call 
                        -- callback (if set).
                require
                        exists: not destroyed
                do
                        implementation.arm
                ensure
                        state_is_true: state
                end;

        disarm is
                        -- Set `state' to False and call 
                        -- callback (if set).
                require
                        exists: not destroyed
                do
                        implementation.disarm
                ensure
                        state_is_false: not state
                end; 

        set_default is
                        -- Set default values to current toggle button.
                do
                ensure then
                        not state
                end;


end -- class EV_TOGGLE_BUTTON
