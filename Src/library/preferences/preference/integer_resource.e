indexing
	description	: "Integer resource.";
	date		: "$Date$";
	revision	: "$Revision$"

class
	INTEGER_PREFERENCE

inherit
	TYPED_PREFERENCE [INTEGER]

create {PREFERENCE_FACTORY}
	make, make_from_string_value

feature -- Access

	string_value: STRING is
			-- String representation of `value'.		
		do
			Result := value.out
		end	
		
	string_type: STRING is
			-- String description of this resource type.
		once
			Result := "INTEGER"
		end	

feature -- Query

	valid_value_string (a_string: STRING): BOOLEAN is
			-- Is `a_string' valid for this resource type to convert into a value?
		do
			Result := a_string.is_integer
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
		require else
			string_valid: valid_value_string (a_value)
		do	
			set_value (a_value.to_integer)			
		end		

	auto_default_value: INTEGER
			-- Value to use when Current is using auto by default (until real auto is set)

end -- class INTEGER_PREFERENCE
