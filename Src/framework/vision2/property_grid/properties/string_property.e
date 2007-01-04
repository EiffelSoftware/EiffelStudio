indexing
	description: "Simple string properties."
	date: "$Date$"
	revision: "$Revision$"

class
	STRING_PROPERTY [G->STRING_GENERAL]

inherit
	TEXT_PROPERTY [G]
		redefine
			is_valid_value,
			set_value
		end

create
	make

feature -- Update

	is_valid_value (a_value: like value): BOOLEAN is
			-- Is `a_value' a correct value for `data'?
		local
			l_value, l_a_value: like value
		do
			Result := True
			if a_value /= Void then
				l_a_value ?= a_value.as_string_32
			end
			if value /= Void then
				l_value ?= value.as_string_32
			end
			if not equal (l_value, l_a_value) then
				if l_a_value /= Void then
					l_a_value ?= l_a_value.as_string_8
				end
				Result := validate_value_actions.for_all (agent {FUNCTION [ANY, TUPLE [like value], BOOLEAN]}.item ([l_a_value]))
			end
		end

	set_value (a_value: like value) is
			-- Set `data' to `a_value' and propagate the change if it the new value is different from the old.
		local
			l_changed: BOOLEAN
			l_value, l_a_value: like value
			l_val: like displayed_value
		do
			if a_value /= Void then
				l_a_value ?= a_value.as_string_32
			end
			if value /= Void then
				l_value ?= value.as_string_32
			end
			l_changed := not equal (l_value, l_a_value)
			if a_value /= Void then
				l_a_value ?= a_value.as_string_8
			end
			value := a_value
			if l_changed then
				change_value_actions.call ([l_a_value])
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

	convert_to_data (a_string: like displayed_value): like value is
			-- Convert displayed data into data.
		local
			l_string: like displayed_value
		do
				-- default implementation is to just do an assignement attempt
			l_string := a_string.twin
			l_string.replace_substring_all ("%%N", "%N")
			Result ?= l_string.to_string_32
			if Result = Void then
				Result ?= l_string.to_string_8
			end
		end

end
