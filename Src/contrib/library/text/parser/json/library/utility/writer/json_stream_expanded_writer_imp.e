note
	description: "writer to generated expanded and indented JSON content."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	JSON_STREAM_EXPANDED_WRITER_IMP

inherit
	JSON_STREAM_WRITER_IMP
		redefine
			reset,
			on_enter_object, leave_object,
			on_enter_array, leave_array,
			on_enter_property,
			on_enter_value,
			put_property_name,
			output_separator
		end

feature {NONE} -- Initialization

	reset
		do
			Precursor
			create offset.make_empty
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

	on_enter_object
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

	on_enter_array
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

	on_enter_property
		do
			if active_is_empty then
				output_character ('%N')
				output_string (offset)
			end
			Precursor
		end

	on_enter_value
		do
			if active_is_empty and not active_is_property then
				output_character ('%N')
				output_string (offset)
			end
			Precursor
		end

note
	copyright: "2010-2022, Javier Velilla, Jocelyn Fiat, Eiffel Software and others https://github.com/eiffelhub/json."
	license: "https://github.com/eiffelhub/json/blob/master/License.txt"
end
