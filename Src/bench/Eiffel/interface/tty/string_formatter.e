indexing
	description: "Process a structured text and put result in a string"
	date: "$Date$"
	revision: "$Revision$"

class
	STRING_FORMATTER

inherit
	OUTPUT_WINDOW

create
	make

feature -- Initalization

	make is
		do
			create output.make (0)
		end

feature -- Access

	output: STRING

feature -- Element change

	reset_output is
		do
			output.wipe_out
		end

feature -- Output

	put_string (s: STRING) is
		do
			output.append (s)
		end

	put_char (c: CHARACTER) is
		do
			output.extend (c)
		end

	new_line is
		do
			output.extend ('%N')
		end

end -- class STRING_FORMATTER
