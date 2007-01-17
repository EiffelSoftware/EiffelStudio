indexing
	description: "Simple string properties."
	date: "$Date$"
	revision: "$Revision$"

class
	STRING_PROPERTY [G -> STRING_GENERAL]

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
			l_a_value := adapted_value (a_value)
			if not equal (value, l_a_value) then
				Result := validate_value_actions.for_all (agent {FUNCTION [ANY, TUPLE [like value], BOOLEAN]}.item ([l_a_value]))
			else
				Result := True
			end
		end

	set_value (a_value: like value) is
			-- Set `data' to `a_value' and propagate the change if it the new value is different from the old.
		local
			l_value, l_a_value: like value
			l_val: like displayed_value
		do
			l_a_value := adapted_value (a_value)
			if not equal (value, l_a_value) then
				value := l_a_value
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
			Result := adapted_value (l_string)
		end

	adapted_value (s: STRING_GENERAL): G is
			-- Adapt `s' to the type of formal generic parameter G.
		require
			valid_type: s /= Void implies (s.same_type ("") or s.same_type (("").as_string_32))
		do
			if s = Void then
				Result := Void
			else
				Result ?= s
				if Result = Void then
						-- Try if `G' is instantiated as a STRING_32
					Result ?= s.as_string_32
					if Result = Void then
							-- It was not valid as a STRING_32, so it must be STRING_8
						Result ?= s.as_string_8
						check Result_not_void: Result /= Void end
					end
				end
			end
		ensure
			adapted: s /= Void implies Result /= Void
		end

end
