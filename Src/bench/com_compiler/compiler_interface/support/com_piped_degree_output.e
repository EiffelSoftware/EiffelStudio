indexing
	description: "Redirects output to specified pipe"
	date: "$Date$"
	revision: "$Revision$"

class
	COM_PIPED_DEGREE_OUTPUT
	
inherit
	COM_DEGREE_OUTPUT
		rename
			make as make_std_output
		redefine
			put_string,
			should_continue
		end
create
	make
	
feature {NONE} -- Initialization

	make (a_pipe: WEL_PIPE) is
			-- Initialize structure.
		require
			non_void_pipe: a_pipe /= Void
			pipe_writable: not a_pipe.input_closed
		do
			input_pipe := a_pipe
		end

feature -- Output
		
	put_string (a_message: STRING) is
			-- Put `a_message' to output window.
		do
			input_pipe.put_string (a_message + "%N")
		end	
		
feature {NONE} -- Implementation

	input_pipe: WEL_PIPE
			-- Pipe to send output to
			
	should_continue: BOOLEAN is
			-- should the compile contine?
		do
			Result := True
		end
		
		
end -- class COM_PIPED_DEGREE_OUTPUT
