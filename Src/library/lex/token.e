note
	description: "Individual elements of lexical analysis"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
	ca_ignore: "CA011", "CA011 — too many arguments"

class
	TOKEN

inherit
	ANY
		redefine
			default_create,
			out
		end

feature {NONE} -- Creation

	default_create
			-- <Precursor>
		do
			create string_value.make_empty
		end

feature -- Access

	type: INTEGER
			-- Type of the token.

	line_number: INTEGER
			-- Line number in the parsed text.

	column_number: INTEGER
			-- Column number in the parsed text.

	keyword_code: INTEGER
			-- Identification number if the token is a keyword.

	string_value: STRING
			-- The token's character string.

	is_keyword (i: INTEGER): BOOLEAN
			-- If the token is a keyword,
			-- is `i' its identification number?
		do
			Result := i = keyword_code
		end

feature -- Status setting

	set (typ, lin, col, key: INTEGER; str: STRING)
			-- Reset the contents of the token:
			-- type `type', line number `lin',
			-- column number `col', keyword value `key'.
		do
			type := typ;
			line_number := lin;
			column_number := col;
			keyword_code := key;
			if type = 0 then
				string_value := ""
			else
				string_value := str
			end
		end

feature -- Output

	out: STRING
			-- <Precursor>
		do
			create Result.make (100)
			Result.append (once "  string_value: ")
			Result.append (string_value)
			Result.append (once "%N  type: ")
			Result.append_integer (type)
			Result.append (once "%N  keyword code: ")
			Result.append_integer (keyword_code)
			Result.append (once "%N  line: ")
			Result.append_integer (line_number)
			Result.append (once "%N  column: ")
			Result.append_integer (column_number)
			Result.append_character ('%N')
		end

feature -- Obsolete

	position_in_line: INTEGER
			-- Column number in the parsed text.
		obsolete
			"Use `column_number' instead. [2017-05-31]"
		do
			Result := column_number
		end

note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
