indexing
	description: "[
		Objects that print expressions to a character output stream.
		]"
	author: "Andreas Leitner"
	date: "$Date$"
	revision: "$Revision$"

class AUT_EXPRESSION_PRINTER

inherit

	ITP_EXPRESSION_PROCESSOR

	UT_CHARACTER_FORMATTER
		export {NONE} all end

	KL_SHARED_STREAMS
		export {NONE} all end

	ITP_VARIABLE_CONSTANTS

create

	make,
	make_null,
	make_string

feature {NONE} -- Initialization

	make (an_output_stream: like output_stream) is
			-- Create new printer using `an_output_stream' as output
			-- stream.
		require
			an_output_stream_not_void: an_output_stream /= Void
		do
			output_stream := an_output_stream
		ensure
			output_stream_set: output_stream = an_output_stream
		end

	make_null is
			-- Create new printer using the null output stream as output
			-- stream.
		do
			make (null_output_stream)
		end

	make_string (a_string: STRING) is
			-- Create a new printer appending its output
			-- to `a_string'.
		require
			a_string_not_void: a_string /= Void
		do
			create {KL_STRING_OUTPUT_STREAM} output_stream.make (a_string)
		end

feature -- Access

	output_stream: KI_CHARACTER_OUTPUT_STREAM
			-- Output stream

feature -- Setting

	set_output_stream (an_output_stream: like output_stream) is
			-- Set `output_stream' to `an_output_stream'.
		require
			an_output_stream_not_void: an_output_stream /= Void
		do
			output_stream := an_output_stream
		ensure
			output_stream_set: output_stream = an_output_stream
		end

feature {ITP_EXPRESSION} -- Processing

	process_constant (a_value: ITP_CONSTANT) is
		local
			char_8: CHARACTER_8
			char_32: CHARACTER_32
		do
			if a_value.value = Void then
				output_stream.put_string ("Void")
			elseif a_value.type_name.is_equal ("POINTER") then
				output_stream.put_string ("itp_default_pointer")
			elseif a_value.type_name.is_equal ("CHARACTER_8") then
				output_stream.put_character ('{')
				output_stream.put_string (a_value.type_name)
				output_stream.put_character ('}')
				output_stream.put_character (' ')
				if {l_char_8: CHARACTER_8} a_value.value then
					char_8 := l_char_8
				end
				put_quoted_eiffel_character (output_stream, char_8)
			elseif a_value.type_name.is_equal ("CHARACTER_32") then
				output_stream.put_character ('{')
				output_stream.put_string (a_value.type_name)
				output_stream.put_character ('}')
				output_stream.put_character (' ')
				if {l_char_32: CHARACTER_32} a_value.value then
					char_32 := l_char_32
				end
				-- TODO: either convince ISE to have a good common
				-- ancestor for CHARACTER_*, or implement
				-- `put_quoted_eiffel_character' for all CHARCACTER_*.
				put_quoted_eiffel_character (output_stream, 'x')
			elseif a_value.type_name.is_equal ("BOOLEAN") then
				output_stream.put_string (a_value.value.out)
			else
				output_stream.put_character ('{')
				output_stream.put_string (a_value.type_name)
				output_stream.put_character ('}')
				output_stream.put_character (' ')
				output_stream.put_string (a_value.value.out)
			end
		end

	process_variable (a_value: ITP_VARIABLE) is
		do
			output_stream.put_string (a_value.name (variable_name_prefix))
		end

invariant

	output_stream_not_void: output_stream /= Void

end
