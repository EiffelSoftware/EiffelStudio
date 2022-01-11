note
	description: "Summary description for {JSON_STREAM_TEXT_WRITER}."
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_STREAM_TEXT_EXPANDED_WRITER

inherit
	JSON_STREAM_WRITER
		undefine
			reset
		end

	JSON_STREAM_EXPANDED_WRITER_IMP

create
	make_with_text

feature {NONE} -- Intialization

	make_with_text (s: STRING_8)
		do
			output := s
			create active_stack.make (3)
			reset
		end

	output: STRING_8

feature {NONE} -- Implementation

	output_string (s: READABLE_STRING_8)
		do
			output.append (s)
		end

	output_character (c: CHARACTER)
		do
			output.append_character (c)
		end

note
	copyright: "2010-2022, Javier Velilla, Jocelyn Fiat, Eiffel Software and others https://github.com/eiffelhub/json."
	license: "https://github.com/eiffelhub/json/blob/master/License.txt"
end
