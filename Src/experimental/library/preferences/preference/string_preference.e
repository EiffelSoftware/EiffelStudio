note
	description: "String preference."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	STRING_PREFERENCE

inherit
	ABSTRACT_STRING_PREFERENCE [STRING]

create {PREFERENCE_FACTORY}
	make, make_from_string_value

feature -- Access	

	string_type: STRING
			-- String description of this preference type.
		once
			Result := "STRING"
		end

feature {NONE} -- Implementation

	is_value_compatible (a_value: READABLE_STRING_GENERAL): BOOLEAN
		do
			Result := a_value.is_valid_as_string_8
		end

	to_value (a_value: READABLE_STRING_GENERAL): STRING
			-- `a_value' to type of `value'.
		do
				-- Ok to truncate per precondition `is_value_compatible'.
			Result := a_value.to_string_8
		end

	to_adapted_value (a_value: READABLE_STRING_GENERAL): STRING
			-- Adapted conversion of `a_value' to type of `value'.
			-- In this case, convert to UTF-8
			--| This exists only for backward compatibility
		local
			utf: UTF_CONVERTER
		do
			Result := utf.string_32_to_utf_8_string_8 (a_value.to_string_32)
		end

	auto_default_value: STRING
			-- Value to use when Current is using auto by default (until real auto is set)
		once
			create Result.make_empty
		end

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"


end -- class STRING_PREFERENCE
