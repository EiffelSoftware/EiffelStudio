indexing

	description: 
		"Terminal window that redirects output to a file.";
	date: "$Date$";
	revision: "$Revision $"

class FILE_WINDOW

inherit

	OUTPUT_WINDOW;

	PLAIN_TEXT_FILE

creation

	make

feature -- Output

	open_file is
			-- Open file.
		local
			retried: BOOLEAN
		do
			if not retried then
				open_write
			end;
		rescue
			retried := True;
			retry
		end;

	put_char (c: CHARACTER) is 
			-- Put character `c' to current position in file.
		do 
			putchar (c) 
		end;

end -- class FILE_WINDOW
