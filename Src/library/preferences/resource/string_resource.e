indexing
	description	: "String resource."
	date		: "$Date$"
	revision	: "$Revision$"

class
	STRING_RESOURCE

inherit
	TYPED_RESOURCE [STRING]

create {RESOURCE_FACTORY}
	make, make_from_string_value

feature -- Access

	string_value: STRING is
			-- String representation of `value'.
		do
			Result := value
		end	
		
	string_type: STRING is
			-- String description of this resource type.
		once
			Result := "STRING"
		end	

feature -- Query

	valid_value_string (a_string: STRING): BOOLEAN is
			-- Is `a_string' valid for this resource type to convert into a value?
		do
				-- True.  A string resource may be empty and precondition ensures it is not void.
			Result := True
		end

feature {PREFERENCES} -- Access

	generating_resource_type: STRING is
			-- The generating type of the resource for graphical representation.
		once
			Result := "TEXT"
		end
	
feature {NONE} -- Implementation

	set_value_from_string (a_value: STRING) is
			-- Parse the string value `a_value' and set `value'.
		do		
			set_value (a_value)
		end	

end -- class STRING_RESOURCE
