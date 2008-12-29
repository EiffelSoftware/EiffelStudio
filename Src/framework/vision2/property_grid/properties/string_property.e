note
	description: "Simple string properties."
	date: "$Date$"
	revision: "$Revision$"

class
	STRING_PROPERTY

inherit
	TEXT_PROPERTY [STRING_32]
		rename
			set_value as set_string_32_value
		redefine
			is_valid_value,
			set_string_32_value
		end

create
	make

feature -- Update

	is_valid_value (a_value: like value): BOOLEAN
			-- Is `a_value' a correct value for `data'?
		do
			Result := equal (value, a_value) or else
				validate_value_actions.for_all (agent {FUNCTION [ANY, TUPLE [like value], BOOLEAN]}.item ([a_value]))
		end

	set_value (a_value: STRING_GENERAL)
			-- Set `value' to `a_value' and propagate the change if the new value is different from the old one.
		do
			if a_value /= Void then
				set_string_32_value (a_value.as_string_32)
			else
				set_string_32_value (Void)
			end
		end

feature -- Specialized update

	set_string_32_value (a_value: like value)
			-- Set `value' to `a_value' and propagate the change if it the new value is different from the old one.
		local
			l_val: like displayed_value
		do
			if not equal (value, a_value) then
				value := a_value
				change_value_actions.call ([a_value])
			end
			l_val := displayed_value
			set_text (l_val)
			if text_field /= Void then
				text_field.set_text (l_val)
			end
			if l_val.is_empty then
				set_tooltip (description)
			else
				set_tooltip (l_val)
			end
		end

feature {NONE} -- Implementation

	convert_to_data (a_string: like displayed_value): like value
			-- Convert displayed data into data.
		local
			l_string: like displayed_value
		do
			l_string := a_string.twin
			l_string.replace_substring_all ("%%N", "%N")
			Result := l_string
		end

end
