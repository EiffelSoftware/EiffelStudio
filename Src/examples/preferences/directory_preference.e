indexing
	description: "Directory path preference.  Stores simply a string value containing the path of a directory."
	date: "$Date$"
	revision: "$Revision$"

class
	DIRECTORY_RESOURCE

inherit
	TYPED_PREFERENCE [DIRECTORY_NAME]

create {PREFERENCE_FACTORY}
	make, make_from_string_value

feature -- Setting	

	set_value_from_string (a_value: STRING) is
			-- Parse the string value `a_value' and set `value'.
		require else
			value_not_void: value /= Void
		do
			create internal_value.make_from_string (a_value)
		end

feature -- Access

	string_value: STRING is
			-- String representation of `value'.
		do
			Result := value.out
		end

	string_type: STRING is
			-- String description of this preference type.
		once
			Result := "DIRECTORY_PATH"
		end

	generating_preference_type: STRING is
			-- The generating type of the preference for graphical representation.
		do
			Result := "DIRECTORY"
		end

	valid_value_string (a_string: STRING): BOOLEAN is
			-- Is `a_string' valid for this preference type to convert into a value?
		do
			Result := a_string /= Void and then not a_string.is_empty
		end

	auto_default_value: DIRECTORY_NAME is
			-- Value to use when Current is using auto by default (until real auto is set)
		once
			Result := create {DIRECTORY_NAME}.make_from_string ("")
		end

end -- class DIRECTORY_RESOURCE
