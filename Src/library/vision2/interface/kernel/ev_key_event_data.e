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
			!EV_KEY_EVENT_DATA_IMP!implementation.make (Current)
		end

feature -- Access	
	
	state: INTEGER
	keyval: INTEGER
	length: INTEGER
	string: STRING

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
	
feature {EV_KEY_EVENT_DATA_I, EV_WIDGET_IMP} -- Element change
	
	set_state (new_state: INTEGER) is
		do
			state := new_state
		end
	
	set_keyval (new_keyval: INTEGER) is
		do
			keyval := new_keyval
		end
	
	set_length (new_length: INTEGER) is
		do
			length := new_length
		end
	
	set_string (new_string: STRING) is
		do
			string := new_string
		end
	
	
feature {NONE} -- Implementation
	
	implementation: EV_KEY_EVENT_DATA_I
	
end
			
	
