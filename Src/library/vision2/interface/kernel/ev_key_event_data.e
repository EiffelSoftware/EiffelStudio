indexing
	description: "EiffelVision key event data.% 
	%Class for representing button event data";
	status: "See notice at end of class";
	id: "$Id$";
	date: "$Date$";
	revision: "$Revision$"

class
	EV_KEY_EVENT_DATA
	
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
			!EV_KEY_EVENT_DATA_IMP! implementation
		end

feature -- Access	

	keycode: INTEGER is
			-- Server-dependent code corresponding to the keystroke
		do
			Result := implementation.keycode
		end

	length: INTEGER is
			-- length of the string returned by the system
		do
			Result := implementation.length
		end

	string: STRING is
		-- String given the char equivalent of the key
		do
			Result := implementation.string
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

	caps_lock_key_pressed: BOOLEAN is
			-- Is the caps-lock key locked during the event?
		do
			Result := implementation.caps_lock_key_pressed
		end

	num_lock_key_pressed: BOOLEAN is
			-- Is the num-lock key locked during the event?
		do
			Result := implementation.num_lock_key_pressed
		end

	scroll_lock_key_pressed: BOOLEAN is
			-- Is the scroll-lock key locked during the event?
		do
			Result := implementation.scroll_lock_key_pressed
		end

feature -- Debug
	
	print_contents is
			-- print the contents of the object
		do
			io.put_string (" Keycode: ")
			io.put_integer (keycode)
			io.put_string (" Length: ")
			io.put_integer (length)
			io.put_string (" String: ")
			io.put_string (string)
			io.put_string ("%N")
			io.put_string (" Shift: ")
			io.put_boolean (shift_key_pressed)
			io.put_string (" Control: ")
			io.put_boolean (control_key_pressed)
			io.put_string (" Caps lock: ")
			io.put_boolean (caps_lock_key_pressed)
			io.put_string ("%N")
			io.put_string (" Num Lock: ")
			io.put_boolean (num_lock_key_pressed)
			io.put_string (" Scroll Lock: ")
			io.put_boolean (scroll_lock_key_pressed)
			io.put_string ("%N")
		end

feature {EV_WIDGET_IMP} -- Implementation

	implementation: EV_KEY_EVENT_DATA_I

end -- class EV_KEY_EVENT_DATA

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
