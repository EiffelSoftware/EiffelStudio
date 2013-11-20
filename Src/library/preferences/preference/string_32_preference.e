note
	description: "String 32 preference."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	STRING_32_PREFERENCE

inherit
	ABSTRACT_STRING_PREFERENCE [STRING_32]

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
			Result := True
		end

	to_value (a_value: READABLE_STRING_GENERAL): STRING_32
			-- `a_value' to type of `value'.
		do
			Result := a_value.to_string_32
		end

	to_adapted_value (a_value: READABLE_STRING_GENERAL): STRING_32
			-- Adapted conversion of `a_value' to type of `value'.
			-- In this case, convert to UTF-8
		do
			check should_not_occur: False end
			Result := a_value.to_string_32
		end

	auto_default_value: STRING_32
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




end -- class STRING_32_PREFERENCE
