note
	description	: "Path preference."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	PATH_PREFERENCE

inherit
	TYPED_PREFERENCE [PATH]
		redefine
			init_value_from_string
		end

create {PREFERENCE_FACTORY}
	make, make_from_string_value

feature {NONE} -- Initialization

	init_value_from_string (a_value: READABLE_STRING_GENERAL)
			-- Set initial value from String `a_value'
		do
			internal_value := to_value (a_value)
			Precursor {TYPED_PREFERENCE} (a_value)
		end

feature {PREFERENCE_EXPORTER} -- Access

	text_value: STRING_32
			-- String representation of `value'.
		do
			Result := value.name
		end

feature -- Access	

	string_type: STRING
			-- String description of this preference type.
		once
			Result := "PATH"
		end

	valid_value_string (a_string: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `a_string' valid for this preference type to convert into a value?
		do
			Result := True
		end

feature -- Change		

	require_existing_file
			-- Requires that `value' represent an existing file
			-- This is mainly to validate changes from UI
		require
			has_no_validation_agent: not has_validation_agent
		do
			set_validation_agent (agent (s: READABLE_STRING_GENERAL): BOOLEAN
					local
						u: FILE_UTILITIES
					do
						Result := u.file_exists (s)
					end
				)
		end

	require_existing_directory
			-- Requires that `value' represent an existing directory
			-- This is mainly to validate changes from UI
		require
			has_no_validation_agent: not has_validation_agent
		do
			set_validation_agent (agent (s: READABLE_STRING_GENERAL): BOOLEAN
					local
						u: FILE_UTILITIES
					do
						Result := u.directory_exists (s)
					end
				)
		end

	set_value_from_string (a_value: READABLE_STRING_GENERAL)
			-- Parse the string value `a_value' and set `value'.
		do
			set_value (to_value (a_value))
		end

feature {PREFERENCES} -- Access

	generating_preference_type: STRING
			-- The generating type of the preference for graphical representation.
		once
			Result := "TEXT"
		end

feature {NONE} -- Implementation

	to_value (a_value: READABLE_STRING_GENERAL): PATH
			-- `a_value' to type of `value'.
		do
			create Result.make_from_string (a_value)
		end

	auto_default_value: PATH
			-- Value to use when Current is using auto by default (until real auto is set)
		once
			create Result.make_from_string ("")
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

end -- class PATH_PREFERENCE
