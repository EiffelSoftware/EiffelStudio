indexing
	description: "EiffelVision key event data. Implementation interface";
	status: "See notice at end of class";
	id: "$Id$";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	EV_KEY_EVENT_DATA_I

inherit
	EV_EVENT_DATA_I	
		redefine
			print_contents
		end	

feature -- Access	
	
	state: INTEGER
		-- To find

	keyval: INTEGER
		-- To find

	length: INTEGER
		-- to find

	string: STRING
		-- String given the char equivalent of the key

feature -- Element change
	
	set_state (value: INTEGER) is
			-- Make `value' the new state.
		do
			state := value
		end
	
	set_keyval (value: INTEGER) is
			-- Make `value' the new keyval.
		do
			keyval := value
		end
	
	set_length (value: INTEGER) is
			-- Make `value' the new length.
		do
			length := value
		end
	
	set_string (str: STRING) is
			-- Make `str' the new string.
		do
			string := str
		end

feature -- Debug
	
	print_contents is
			-- print the contents of the object
		do
			io.put_string ("State: ")			
			io.put_integer (state)
			io.put_string (" Keyval: ")			
			io.put_integer (keyval)
			io.put_string (" Length: ")			
			io.put_integer (length)
			io.put_string (" String: ")			
			io.put_string (string)
			io.put_string ("%N")		
		end

end -- class EV_KEY_EVENT_DATA_I

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
