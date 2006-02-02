indexing
	description	: "String preference."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	STRING_PREFERENCE

inherit
	TYPED_PREFERENCE [STRING]

create {PREFERENCE_FACTORY}
	make, make_from_string_value

feature -- Access

	string_value: STRING is
			-- String representation of `value'.
		do
			Result := value.twin
		end

	string_type: STRING is
			-- String description of this preference type.
		once
			Result := "STRING"
		end

feature -- Query

	valid_value_string (a_string: STRING): BOOLEAN is
			-- Is `a_string' valid for this preference type to convert into a value?
		do
				-- True.  A string preference may be empty and precondition ensures it is not void.
			Result := True
		end

feature -- Change

	set_value_from_string (a_value: STRING) is
			-- Parse the string value `a_value' and set `value'.
		do
			set_value (a_value)
		end

feature {PREFERENCES} -- Access

	generating_preference_type: STRING is
			-- The generating type of the preference for graphical representation.
		once
			Result := "TEXT"
		end

feature {NONE} -- Implementation

	auto_default_value: STRING is
			-- Value to use when Current is using auto by default (until real auto is set)
		once
			create Result.make_empty
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class STRING_PREFERENCE
