note
	description: "Information about a parsing error."
	date: "$Date$"
	revision: "$Revision$"

class
	PARSING_ERROR

inherit
	ANY
		redefine
			out
		end

create
	make_with_token,
	make_with_message

feature {NONE} -- Initialization

	make_with_token (a_file: RAW_FILE; a_line: STRING; a_line_number: INTEGER; a_position_in_line: INTEGER; an_unexpected_token: STRING)
			-- Initialize Current with `a_file', `a_line', `a_line_number', `a_position_in_line' and `an_unexpected_token'
		require
			a_valid_file: a_file.exists
			a_valid_line: not a_line.is_empty
		do
			file := a_file
			line := a_line
			line_number := a_line_number
			position_in_line := a_position_in_line
			unexpected_token := an_unexpected_token
		ensure
			file_set: file = a_file
			line_set: line = a_line
			line_number_set: line_number = a_line_number
			position_in_line_set: position_in_line = a_position_in_line
			unexpected_token_set: unexpected_token = an_unexpected_token
		end

	make_with_message (a_file: RAW_FILE; a_line: STRING; a_line_number: INTEGER; a_position_in_line: INTEGER; a_message: STRING)
			-- Initialize Current with `a_file', `a_line', `a_line_number', `a_position_in_line' and `an_unexpected_token'
		require
			a_valid_file: a_file.exists
			a_valid_line: not a_line.is_empty
			a_valid_message: not a_message.is_empty
		do
			file := a_file
			line := a_line
			line_number := a_line_number
			position_in_line := a_position_in_line
			message := a_message
		ensure
			file_set: file = a_file
			line_set: line = a_line
			line_number_set: line_number = a_line_number
			position_in_line_set: position_in_line = a_position_in_line
			message_set: message = a_message
		end

feature -- Access

	file: RAW_FILE
			-- The file in which the parsing error occured.

	line: STRING
			-- The line in which the parsing error occured.

	line_number: INTEGER
			-- The line number at which the parsing error occured.

	position_in_line: INTEGER
			-- The position in the line in which the parsing error occured.

	unexpected_token: detachable STRING
			-- The unexpected token that generated this parsing error.

	message: detachable STRING
			-- A custom error message.

feature -- Text Output

	out: STRING
			-- New string containing terse printable representation
			-- of current object
		do
			Result := "Parsing error in file %"" + file.name + "%":%N"
			if attached unexpected_token as attached_unexpected_token then
				Result := "Unexpected token %"" + attached_unexpected_token + "%" at line " + line_number.out + " at position " + (position_in_line - attached_unexpected_token.count).out + ":%N"
				Result.append (line + "%N")
			elseif attached message as attached_message then
				Result := attached_message + "%N"
			end
		end

end
