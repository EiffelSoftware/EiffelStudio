note
	description: "[
			Common implementation of stream JSON writer.
		]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	JSON_STREAM_WRITER_IMP

inherit
	JSON_STREAM_WRITER
		redefine
			reset
		end

feature -- Reset

	reset
		do
			active_stack.wipe_out
		end

feature -- Writing

	put_object_start
		do
			enter_object
			output_character (object_start_character)
		end

	put_object_end
		do
			output_character (object_end_character)
			leave_object
		end

	put_array_start
		do
			enter_array
			output_character (array_start_character)
		end

	put_array_end
		do
			output_character (array_end_character)
			leave_array
		end

	put_property_name (a_name: READABLE_STRING_GENERAL)
		do
			enter_property
			output_character ('%"')
			output_string ((create {JSON_STRING}.make_from_string_general (a_name)).item)
			output_character ('%"')
			output_character (property_delimiter)
		end

	put_string_value (a_value: READABLE_STRING_GENERAL)
		do
			enter_value
			output_character ('%"')
			output_string ((create {JSON_STRING}.make_from_string_general (a_value)).item)
			output_character ('%"')
			leave_value
		end

	put_integer_64_value (a_value: INTEGER_64)
		do
			enter_value
			output_string ((create {JSON_NUMBER}.make_integer (a_value)).item)
			leave_value
		end

	put_real_64_value (a_value: REAL_64)
		do
			enter_value
			output_string ((create {JSON_NUMBER}.make_real (a_value)).item)
			leave_value
		end

	put_boolean_value (a_value: BOOLEAN)
		do
			enter_value
			if a_value then
				output_string (boolean_true_string)
			else
				output_string (boolean_false_string)
			end
			leave_value
		end

	put_null_value
		do
			enter_value
			output_string (null_string)
			leave_value
		end

feature -- Status report

	active_is_object: BOOLEAN
		do
			Result := not active_stack.is_empty and then active_stack.item.kind = object_start_character
		end

	active_is_array: BOOLEAN
		do
			Result := not active_stack.is_empty and then active_stack.item.kind = array_start_character
		end

	active_is_property: BOOLEAN
		do
			Result := not active_stack.is_empty and then active_stack.item.kind = property_delimiter
		end

	active_is_empty: BOOLEAN
		do
			Result := active_count = 0
		end

	active_count: INTEGER
			-- Count of active stack item (if any).
		do
			if active_stack.is_empty then
				Result := 0
			else
				Result := active_stack.item.nb
			end
		end

feature {NONE} -- Implementation

	output_string (s: READABLE_STRING_8)
			-- Output string `s` into `output`.
		deferred
		end

	output_character (c: CHARACTER)
			-- Output character `c` into `output`.	
		deferred
		end

	enter_object
			-- Enter JSON object.
		do
			if not active_is_empty then
				output_character (',')
			end
			active_stack.extend ([object_start_character, 0])
		end

	leave_object
			-- Leave JSON object.	
		require
			active_is_object
		do
			active_stack.remove
			increment_count
			if active_is_property then
				leave_value
			end
		end

	enter_array
			-- Enter JSON array.	
		do
			if not active_is_empty then
				output_character (',')
			end
			active_stack.extend ([array_start_character, 0])
		end

	leave_array
			-- Leave JSON array.	
		require
			active_is_array
		do
			active_stack.remove
			increment_count
			if active_is_property then
				leave_value
			end
		end

	enter_value
			-- Enter JSON value.
		do
			if not active_is_property then
				if not active_is_empty then
					output_separator
				end
			end
		end

	leave_value
			-- Leave JSON value.
		do
			if active_is_property then
				leave_property
			else
				increment_count
			end
		end

	enter_property
			-- Enter JSON property.
		do
			if not active_is_empty then
				output_separator
			end
			active_stack.extend ([property_delimiter, 0])
		end

	leave_property
			-- Leave JSON property.	
		require
			active_is_property
		do
			active_stack.remove
			increment_count
		end

	increment_count
			-- Increment active stack item element count.
		do
			if not active_stack.is_empty then
				active_stack.item.nb := active_stack.item.nb + 1
			end
		end

	output_separator
		do
			output_character (',')
		end

	boolean_true_string: STRING = "true"

	boolean_false_string: STRING = "false"

	null_string: STRING = "null"

	object_start_character: CHARACTER = '{'

	object_end_character: CHARACTER = '}'

	array_start_character: CHARACTER = '['

	array_end_character: CHARACTER = ']'

	property_delimiter: CHARACTER = ':'

	active_stack: ARRAYED_STACK [TUPLE [kind: CHARACTER; nb: INTEGER]]

invariant

note
	copyright: "2010-2022, Javier Velilla, Jocelyn Fiat, Eiffel Software and others https://github.com/eiffelhub/json."
	license: "https://github.com/eiffelhub/json/blob/master/License.txt"
end
