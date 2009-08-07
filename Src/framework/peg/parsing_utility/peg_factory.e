note
	description: "[
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	PEG_FACTORY

feature -- Predefined PEGs

	plus: PEG_ABSTRACT_PEG
		do
			Result := char ('+')

		end

	minus: PEG_ABSTRACT_PEG
		do
			Result := char ('-')

		end

	dot: PEG_ABSTRACT_PEG
		do
			Result := char ('.')

		end

	quote: PEG_ABSTRACT_PEG
		do
			Result := char ('"')

		end

	colon: PEG_ABSTRACT_PEG
		do
			Result := char (':')

		end

	comma: PEG_ABSTRACT_PEG
		do
			Result := char (',')

		end

	back_slash: PEG_ABSTRACT_PEG
		do
			Result := char ('\')

		end

	open_square: PEG_ABSTRACT_PEG
		do
			Result := char ('[')

		end

	close_square: PEG_ABSTRACT_PEG
		do
			Result := char (']')

		end

	open_curly: PEG_ABSTRACT_PEG
		do
			Result := char ('{')

		end

	close_curly: PEG_ABSTRACT_PEG
		do
			Result := char ('}')
		end

	hyphen: PEG_ABSTRACT_PEG
		do
			Result := char ('-')
		end

	underscore: PEG_ABSTRACT_PEG
		do
			Result := char ('_')
		end

	slash: PEG_ABSTRACT_PEG
		do
			Result := char ('/')
		end

	percent: PEG_ABSTRACT_PEG
		do
			Result := char ('%%')
		end

	equals: PEG_ABSTRACT_PEG
		do
			Result := char ('=')
		end

	sharp: PEG_ABSTRACT_PEG
		do
			Result := char ('#')
		end

	ampersand: PEG_ABSTRACT_PEG
		do
			Result := char ('&')
		end

	digit: PEG_ABSTRACT_PEG
		do
			Result := range ('0', '9')
		end

	digits: PEG_ABSTRACT_PEG
			-- Non-empty string of digits [0-9]
			-- Ommits the result
		do
			Result := range ('0', '9')
			Result := +Result
		ensure
			Result_attached: attached Result
		end

	lower_case: PEG_ABSTRACT_PEG
			-- Lower case letter
			-- Ommits the result
		do
			Result := range ('a', 'z')
		ensure
			Result_attached: attached Result
		end

	upper_case: PEG_ABSTRACT_PEG
			-- Upper case letter
			-- Ommits the result
		do
			Result := range ('A', 'Z')
		ensure
			Result_attached: attached Result
		end

	any: PEG_ANY
			--  The Parser which accepts anything (1 character)
			-- Ommits the result
		do
			create {PEG_ANY} Result.make
			Result.ommit_result
		ensure
			Result_attached: attached Result
		end

	rany: PEG_ANY
			-- The parser which accepts anything (1 character)
			-- Doesn't ommit the result
		do
			create {PEG_ANY} Result.make
		end

	whitespaces: PEG_ABSTRACT_PEG
			-- A chain of whitespaces
			-- Ommits the result
		do
			create {PEG_WHITE_SPACE_CHARACTER} Result.make
			Result.ommit_result
			Result := +Result
			Result.set_name ("whitespaces")
		end

feature --

	stringp (a_string: STRING): PEG_ABSTRACT_PEG
			-- Generates a parser which parses `a_string' which ommits results
		require
			a_string_valid: attached a_string and then not a_string.is_empty
		local
			l_i: INTEGER
		do
			create {PEG_SEQUENCE} Result.make
			from
				l_i := 1
			until
				l_i > a_string.count
			loop
				Result := Result + char (a_string [l_i])
				l_i := l_i + 1
			end
			Result.fixate
		ensure
			Result_attached: attached Result
		end

	rstringp (a_string: STRING): PEG_ABSTRACT_PEG
			-- Generates a parser which parses `a_string' which puts a string on the result list
		require
			a_string_valid: attached a_string and then not a_string.is_empty
		local
			l_i: INTEGER
		do
			create {PEG_SEQUENCE} Result.make
			from
				l_i := 1
			until
				l_i > a_string.count
			loop
				Result := Result + rchar (a_string [l_i])
				l_i := l_i + 1
			end
			Result := Result.consumer
			Result.fixate
		ensure
			Result_attached: attached Result
		end

	char (a_char: CHARACTER): PEG_CHARACTER
			-- Generates  Character Parser
		require
			a_char_attached: attached a_char
		do
			Result := rchar (a_char)
			Result.ommit_result
		ensure
			Result_attached: attached Result
		end

	rchar (a_character: CHARACTER): PEG_CHARACTER
			-- Builds an non-ommiter {PEG_CHARACTER}
		require
			a_character_attached: attached a_character
		do
			create Result.make_with_character (a_character)
		ensure
			Result_attached: attached result
		end

	range (a_first_char, a_last_char: CHARACTER): PEG_RANGE
			-- Builds an ommiter {PEG_CHARACTER} (doesn't put any characters to the result list)
		require
			a_first_char_attached: attached a_first_char
			a_last_char_attached: attached a_last_char
		do
			create Result.make_with_range (a_first_char, a_last_char)
			Result.ommit_result
		ensure
			Result_attached: attached Result
		end

feature -- Formatting

	format_debug (a_line_row: TUPLE [line: INTEGER; row: INTEGER]; a_source_path: STRING): STRING
			-- Formats the line/row information
		require
			a_line_row_attached: attached a_line_row
		do
			Result := "line: " + a_line_row.line.out + " row: " + a_line_row.row.out + " of file: " + a_source_path
		ensure
			Result_attached_and_not_empty: attached Result and then not Result.is_empty
		end

end
