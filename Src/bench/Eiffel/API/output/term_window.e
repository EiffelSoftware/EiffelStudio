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
			io.error.put_string (s) 
		end;

	put_new_line is 
		do 
			io.error.put_new_line 
		end;

	put_char (c: CHARACTER) is 
		do 
			io.error.put_character (c) 
		end;

end -- class TERM_WINDOW
