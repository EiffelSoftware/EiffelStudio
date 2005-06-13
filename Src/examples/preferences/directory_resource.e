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
			create value.make_from_string (a_value)
		end	

feature -- Access

	string_value: STRING is
			-- String representation of `value'.
		do
			Result := value.out
		end		

	string_type: STRING is
			-- String description of this resource type.
		once
			Result := "DIRECTORY_PATH"
		end		

	generating_resource_type: STRING is
			-- The generating type of the resource for graphical representation.
		do
			Result := "DIRECTORY"
		end	

	valid_value_string (a_string: STRING): BOOLEAN is
			-- Is `a_string' valid for this resource type to convert into a value?
		do			
			Result := a_string /= Void and then not a_string.is_empty
		end	

end -- class DIRECTORY_RESOURCE
