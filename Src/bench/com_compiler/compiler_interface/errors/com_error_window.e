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
			create output_string.make (0)
		end
		
feature -- Output

	put_string (s: STRING) is 
		do 
			output_string.append (s) 
		end

	new_line is 
		do 
			interface.event_output_string (output_string) 
			output_string.wipe_out
		end

	put_char (c: CHARACTER) is 
		do 
			output_string.append_character (c) 
		end
				
feature {NONE} -- Implementation

	interface: CEIFFEL_COMPILER_COCLASS
			-- Entity that handles messages.

	output_string: STRING
			-- Holds output string.
	
end -- class COM_ERROR_WINDOW
