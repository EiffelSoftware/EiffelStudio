note
	description: "Summary description for {INDENDANTION_STREAM}."
	author: "sandro"
	date: "$Date$"
	revision: "$Revision$"

class
	INDENDATION_STREAM

inherit
	PLAIN_TEXT_FILE
		redefine
			put_string
		end

create

	make, make_open_read, make_open_write, make_open_append,
	make_open_read_write, make_create_read_write,
	make_open_read_append

feature -- Access

	indendation: NATURAL
			-- By how many times strings should be indendanted with `ind_character'

	ind_character: CHARACTER
			-- Indendantion character

feature

	set_indendation (an_indendation: NATURAL)
			-- Sets the indendantion.
		require
			indent_geq_0: an_indendation >= 0
		do
			indendation := an_indendation
		end

	set_ind_character (an_indendation_character: CHARACTER)
			-- Sets the indendation character.
		do
			ind_character := an_indendation_character
		end

	put_string (a_string: STRING)
			-- <Precursor>
			-- String is automatically indendated and a new line added.
		do
			indendate
			Precursor (a_string)
			put_new_line
		end

	append_string (a_string: STRING)
			-- Appends a string without indendation
		do
			put_string (a_string)
		end

	indent
			-- Indents by one character
		do
			indendation := indendation + 1
		end

	unindent
			-- Unindents by one character
		require
			indendation > 0
		do
			indendation := indendation - 1
		ensure
			indendation >= 0
		end

feature {INDENDATION_STREAM} -- Implementation

	indendate
			-- Appends the indendantion to the stream
		local
			i: NATURAL
		do
			from
				i := 1
			until
				i > indendation
			loop
				put_character (ind_character)
				i := i + 1
			end
		end

end
