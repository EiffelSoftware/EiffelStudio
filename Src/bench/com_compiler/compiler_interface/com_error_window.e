indexing
	description: "Redirects errors to com interface"
	date: "$Date$"
	revision: "$Revision$"

class
	COM_ERROR_WINDOW

inherit
	OUTPUT_WINDOW
	
create
	make
	
feature {NONE} -- Initialization

	make (com_interface: CEIFFEL_COMPILER_COCLASS) is
			-- Initialize structure.
		require
			com_interface_exists: com_interface /= Void
		do
			interface := com_interface
		end
		
feature -- Output

	put_string (s: STRING) is 
		do 
			interface.event_output_string (s) 
		end

	new_line is 
		do 
			interface.event_output_string ("%N") 
		end

	put_char (c: CHARACTER) is 
		do 
			interface.event_output_string (c.out) 
		end
				
feature {NONE} -- Implementation

	interface: CEIFFEL_COMPILER_COCLASS
			-- Entity that handles messages.

end -- class COM_ERROR_WINDOW
