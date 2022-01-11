note
	description: "text writer to generated expanded and indented JSON content."
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_STREAM_EXPANDED_TEXT_WRITER

inherit
	JSON_STREAM_TEXT_WRITER
		redefine
			make_with_text,
			reset,
			enter_object, leave_object,
			enter_array, leave_array,
			enter_property, leave_property,
			enter_value, leave_value,
			put_property_name,
			output_separator
		end

create
	make_with_text

feature {NONE} -- Initialization

	make_with_text (s: STRING_8)
		do
			Precursor (s)
			create offset.make_empty
			reset
		end

	reset
		do
			Precursor
			offset.wipe_out
		end

feature -- Writing

	put_property_name (a_name: READABLE_STRING_GENERAL)
		do
			Precursor (a_name)
			output_character (' ')
		end

feature -- Layout

	offset: STRING

	indentation: STRING = "  "

	indent
		do
			offset.append (indentation)
		end

	exdent
		require
			is_indented: offset.ends_with (indentation)
		do
			offset.remove_tail (indentation.count)
		end

	output_separator
		do
			Precursor
			output_character ('%N')
			output_string (offset)
		end

	enter_object
		do
			if
				not active_is_property and
				not active_is_empty
			then
				output_character ('%N')
				output_string (offset)
			end
			Precursor
			indent
		end

	leave_object
		do
			exdent
			output_character ('%N')
			output_string (offset)
			Precursor
		end

	enter_array
		do
			if
				not active_is_property and
				not active_is_empty
			then
				output_character ('%N')
				output_string (offset)
			end
			Precursor
			indent
		end

	leave_array
		do
			exdent
			output_character ('%N')
			output_string (offset)
			Precursor
		end

	enter_property
		do
			if active_is_empty then
				output_character ('%N')
				output_string (offset)
			end
			Precursor
		end

	leave_property
		do
			Precursor
		end

	enter_value
		do
			if not active_is_property then
				output_character ('%N')
				output_string (offset)
			end
			Precursor
		end

	leave_value
		do
			Precursor
		end

note
	copyright: "2010-2022, Javier Velilla, Jocelyn Fiat, Eiffel Software and others https://github.com/eiffelhub/json."
	license: "https://github.com/eiffelhub/json/blob/master/License.txt"
end
