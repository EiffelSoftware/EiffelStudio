indexing

	description: 
		"Stores the output in a string.";
	date: "$Date$";
	revision: "$Revision $"

class YANK_WINDOW

inherit

--	WINDOWS;
	EB_SHARED_OUTPUT_TOOLS
	
	OUTPUT_WINDOW

creation

	make

feature -- Initalization

	make is
		do
			!!stored_output.make (0);
		end;

feature -- Properties

	stored_output: STRING

feature -- Element change

	reset_output is
		do
			stored_output.wipe_out
		end;

feature -- Output

	put_string (s: STRING) is
		do
			error_window.put_string (s);
			stored_output.append (s)
		end;

	put_char (c: CHARACTER) is
		do
			error_window.put_char (c)
			stored_output.extend (c)
		end;

	new_line is
		do
			error_window.new_line
			stored_output.extend ('%N')
		end;

end -- class YANK_WINDOW
