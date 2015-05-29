note
	description: "By default the lexer returns tokens in the range 0-255 if this is a known character, otherwise one of the constants defined below"
	date: "$Date$"
	revision: "$Revision$"

class
	TOKEN_CONSTANTS

feature -- Access

	eof: INTEGER = -1
			-- End of file token.

	def: INTEGER = -2
	extern: INTEGER = -3
			-- Definition or extern.

	identifier: INTEGER = -4
	number: INTEGER = -5
			-- Identifier or number.

feature -- Strings

	def_string: STRING = "def"
	extern_string: STRING = "extern"
			-- Constants of Kaleidoscope language.

invariant

end
