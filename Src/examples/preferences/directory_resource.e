note
	description: "Directory path preference.  Stores simply a string value containing the path of a directory."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DIRECTORY_RESOURCE

inherit
	TYPED_PREFERENCE [STRING_32]
		redefine
			init_value_from_string
		end

create {PREFERENCE_FACTORY}
	make, make_from_string_value

feature {NONE} -- Initialization

	 init_value_from_string (a_value: READABLE_STRING_GENERAL)
			-- Set initial value from String `a_value'
		do
			create internal_value.make_from_string (a_value.to_string_32)
			Precursor (a_value)
		end

feature -- Setting	

	set_value_from_string (a_value: READABLE_STRING_GENERAL)
			-- Parse the string value `a_value' and set `value'.
		require else
			value_not_void: value /= Void
		do
			create internal_value.make_from_string (a_value.to_string_32)
		end

feature -- Access

	text_value: STRING_32
			-- String representation of `value'.
		do
			create Result.make_from_string (value)
		end

	string_type: STRING
			-- String description of this preference type.
		once
			Result := "DIRECTORY"
		end

	generating_preference_type: STRING
			-- The generating type of the preference for graphical representation.
		do
			Result := "DIRECTORY"
		end

	valid_value_string (a_string: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `a_string' valid for this preference type to convert into a value?
		do
			Result := a_string /= Void and then not a_string.is_empty
		end

	auto_default_value: STRING_32
			-- Value to use when Current is using auto by default (until real auto is set)
		once
			create Result.make_empty
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class DIRECTORY_RESOURCE
