indexing
	description: "Sends compiler error output to a pipe"
	date: "$Date$"
	revision: "$Revision$"

class
	COM_PIPED_OUTPUT_WINDOW
	
inherit
	OUTPUT_WINDOW
	
create
	make
	
feature {NONE} -- Initialization

	make (a_pipe: WEL_PIPE) is
			-- create error displayer for piped output
		require
			non_void_pipe: a_pipe /= Void
			input_open: not a_pipe.input_closed
		do
			input_pipe := a_pipe
		end
		
feature -- Output

	put_string (s: STRING) is 
		do 
			input_pipe.put_string (s)
		end

	new_line is 
		do 
			input_pipe.put_string ("%N")
		end

	put_char (c: CHARACTER) is 
		local
			l_char_string: STRING
		do 
			create l_char_string.make_empty
			l_char_string.append_character (c)
			put_string (l_char_string) 
		end		
		
feature {NONE} -- Implementation

	input_pipe: WEL_PIPE
	
invariant
	non_void_intput_pipe: input_pipe /= Void
	input_pipe_open: not input_pipe.input_closed

end -- class COM_PIPED_OUTPUT_WINDOW
