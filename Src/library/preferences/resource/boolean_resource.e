indexing
	description	: "Boolean resource."
	date		: "$Date$"
	revision	: "$Revision$"

class
	BOOLEAN_PREFERENCE

inherit
	TYPED_PREFERENCE [BOOLEAN]

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
			Result := "BOOLEAN"
		end	

feature -- Query

	valid_value_string (a_string: STRING): BOOLEAN is
			-- Is `a_string' valid for this resource type to convert into a value?
		local
			l_string: STRING
		do
			l_string := a_string.twin
			l_string.to_lower
			Result := l_string.is_equal ("true") or l_string.is_equal ("false")
		end	

feature {PREFERENCES} -- Access

	generating_resource_type: STRING is
			-- The generating type of the resource for graphical representation.
		once
			Result := "BOOLEAN"
		end

feature -- Status Setting

	set_value_from_string (a_value: STRING) is
			-- Parse the string value `a_value' and set `value'.
		local
			l_value: STRING
		do			
			l_value := a_value.twin
			l_value.to_lower
			set_value (l_value.is_equal ("true"))
		end	

end -- class BOOLEAN_PREFERENCE
