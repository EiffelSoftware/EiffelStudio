indexing
	description: "EiffelVision button event data.% 
	%Class for representing button event data";
	status: "See notice at end of class";
	id: "$Id$";
	date: "$Date$";
	revision: "$Revision$"

class
	EV_BUTTON_EVENT_DATA
	
inherit
	EV_EVENT_DATA	
		redefine
			make,
			implementation,
			print_contents
		end
	
creation
	make
	
feature {NONE} -- Initialization
	
	make is
		do
			!EV_BUTTON_EVENT_DATA_IMP! implementation
		end

feature -- Access	
	
	x: INTEGER is
			-- Horizontal position of the mouse pointer relative
			-- to the receiving widget
		do
			Result := implementation.x
		end

	y: INTEGER is
			-- Vertical position of the mouse pointer relative
			-- to the receiving window
		do
			Result := implementation.y
		end

	absolute_x: INTEGER is
			-- Absolute horizontal position of the mouse pointer
			-- (in other words relative to the screen)
		do
			Result := implementation.absolute_x
		end

	absolute_y: INTEGER is
			-- Absolute vertical position of the mouse pointer
			-- (in other words relative to the screen)
		do
			Result := implementation.absolute_y
		end

	button: INTEGER is
			-- Button that triggered event
		do
			Result := implementation.button
		end

	shift_key_pressed: BOOLEAN is
			-- Is the shift key pressed during the event?
		do
			Result := implementation.shift_key_pressed
		end

	control_key_pressed: BOOLEAN is
			-- Is the control key pressed during the event?
		do
			Result := implementation.control_key_pressed
		end

	first_button_pressed: BOOLEAN is
			-- Is the first button of the mouse pressed during the
			-- event?
		do
			Result := implementation.first_button_pressed
		end

	second_button_pressed: BOOLEAN is
			-- Is the second button of the mouse pressed during the
			-- event?
		do
			Result := implementation.second_button_pressed
		end

	third_button_pressed: BOOLEAN is
			-- Is the third button of the mouse pressed during the
			-- event?
		do
			Result := implementation.third_button_pressed
		end

feature -- Debug
	
	print_contents is
			-- print the contents of the object
		do
			io.put_string ("(X: ")
			io.put_double (x)
			io.put_string (", Y: ")
			io.put_double (y)
			io.put_string (") Button: ")
			io.put_integer (button)
			io.put_string ("%N")
			io.put_string (" Shift: ")
			io.put_boolean (shift_key_pressed)
			io.put_string (" Control: ")
			io.put_boolean (control_key_pressed)
			io.put_string ("%N")
			io.put_string (" First: ")
			io.put_boolean (first_button_pressed)
			io.put_string (" Second: ")
			io.put_boolean (second_button_pressed)
			io.put_string (" Third: ")
			io.put_boolean (third_button_pressed)
			io.put_string ("%N")
		end

feature {EV_WIDGET_IMP} -- Implementation
	
	implementation: EV_BUTTON_EVENT_DATA_I
	
end -- class EV_BUTTON_EVENT_DATA

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
