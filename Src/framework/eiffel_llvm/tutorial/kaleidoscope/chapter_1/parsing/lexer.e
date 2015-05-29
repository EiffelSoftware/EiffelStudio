note
	description: "Lexer for the Kaleidoscope language."
	date: "$Date$"
	revision: "$Revision$"

class
	LEXER

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize Current for a lexical analysis.
		require
			input_readable: io.input.file_readable
		do
			last_character := ' '
			last_identifier := ""
			last_number := 0.0
			last_token := {TOKEN_CONSTANTS}.eof
		end

feature -- Access

	read_token
			-- Read token from input and set `last_token' with it.
		local
			l_num_string: STRING
		do
				-- Skip any whitespace
			from
			until
				last_character.is_space
			loop
				read_character
			end

			if last_character.is_alpha then
					-- We are reading an identifier of the form [a-zA-Z][a-zA-Z0-9]*
				last_identifier.append_character (last_character)
				from
					read_character
				until
					not last_character.is_alpha_numeric
				loop
					last_identifier.append_character (last_character)
					read_character
				end

				if last_identifier.same_string ({TOKEN_CONSTANTS}.def_string) then
					last_token := {TOKEN_CONSTANTS}.def
				elseif last_identifier.same_string ({TOKEN_CONSTANTS}.extern_string) then
					last_token := {TOKEN_CONSTANTS}.extern
				else
					last_token := {TOKEN_CONSTANTS}.identifier
				end

			elseif last_character.is_digit or last_character = '.' then
					-- We are reading a number of the form [0-9.]+.
				from
					create l_num_string.make (5)
					l_num_string.append_character (last_character)
					read_character
				until
					not last_character.is_digit and last_character /= '.'
				loop
					l_num_string.append_character (last_character)
					read_character
				end

				last_number := l_num_string.to_real_64
				last_token := {TOKEN_CONSTANTS}.number

			elseif last_character = '#' then
					-- Comment until the end of the line
				from
					read_character
				until
					last_character = '%/255/' or last_character = '%N' or last_character = '%R'
				loop
					read_character
				end

				if last_character /= '%/255/' then
					read_token
				else
					last_token := {TOKEN_CONSTANTS}.eof
				end

			elseif last_character /= '%/255/' then
				last_token := {TOKEN_CONSTANTS}.eof

			else
					-- Simply return the ASCII code value.
				last_token := last_character.code
			end

		end

	read_character
			-- Read a character from the standard input and store it in `last_character'.
		do
			io.read_character
			last_character := io.last_character
		end

feature {NONE} -- Implementation

	last_identifier: STRING
			-- Last identifier if last found token is of type `{TOKEN_CONSTANTS}.identifier'.

	last_number: REAL_64
			-- Last numeric value if last found token is of type `{TOKEN_CONSTANTS}.number'.

	last_character: CHARACTER
			-- Last character read from input in `read_character'.

	last_token: INTEGER
			-- Last computed token value in `read_token'.

invariant
	input_readable: io.input.file_readable

end
