indexing

	description: 
		"Terminal window that redirects output to `io.error'.";
	date: "$Date$";
	revision: "$Revision $"

class TERM_WINDOW

inherit

	OUTPUT_WINDOW

feature -- Output

	put_string (s: STRING) is 
		do 
			io.error.putstring (s) 
		end;

	new_line is 
		do 
			io.error.new_line 
		end;

	put_char (c: CHARACTER) is 
		do 
			io.error.putchar (c) 
		end;

end -- class TERM_WINDOW
