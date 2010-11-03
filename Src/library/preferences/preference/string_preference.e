note
	description	: "String preference."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	STRING_PREFERENCE

inherit
	TYPED_PREFERENCE [STRING]
		redefine
			init_value_from_string
		end

create {PREFERENCE_FACTORY}
	make, make_from_string_value

feature {NONE} -- Initialization

	init_value_from_string (a_value: STRING)
			-- Set initial value from String `a_value'
		do
			internal_value := a_value
			Precursor {TYPED_PREFERENCE} (a_value)
		end

feature -- Access

	string_value: STRING
			-- String representation of `value'.
		local
			l_value: like value
		do
			l_value := value
			check attached l_value end -- implied by precondition `has_value'
			create Result.make_from_string (l_value)
		end

	string_type: STRING
			-- String description of this preference type.
		once
			Result := "STRING"
		end

feature -- Query

	valid_value_string (a_string: STRING): BOOLEAN
			-- Is `a_string' valid for this preference type to convert into a value?
		do
				-- True.  A string preference may be empty and precondition ensures it is not void.
			Result := True
		end

feature -- Change

	set_value_from_string (a_value: STRING)
			-- Parse the string value `a_value' and set `value'.
		do
			set_value (a_value)
		end

feature {PREFERENCES} -- Access

	generating_preference_type: STRING
			-- The generating type of the preference for graphical representation.
		once
			Result := "TEXT"
		end

feature {NONE} -- Implementation

	auto_default_value: STRING
			-- Value to use when Current is using auto by default (until real auto is set)
		once
			create Result.make_empty
		end

note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class STRING_PREFERENCE
