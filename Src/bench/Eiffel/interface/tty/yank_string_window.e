indexing

	description: 
		"Stores into a string.";
	date: "$Date$";
	revision: "$Revision $"

class YANK_STRING_WINDOW

inherit

	OUTPUT_WINDOW

create

	make

feature -- Initalization

	make is
		do
			create stored_output.make (0);
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
			stored_output.append (s)
		end;

	put_char (c: CHARACTER) is
		do
			stored_output.extend (c)
		end;

	new_line is
		do
			stored_output.extend ('%N')
		end;

end -- class YANK_STRING_WINDOW
