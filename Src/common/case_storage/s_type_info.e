indexing

	description: 
		"Abstract class of declaration of class type.";
	date: "$Date$";
	revision: "$Revision $"

deferred class S_TYPE_INFO

feature -- Properies

	free_text_name: STRING;
			-- String representation for Current type

	is_valid: BOOLEAN is
			-- Is Current type valid?
		deferred
		end;

	is_not_actual_class_type: BOOLEAN is
			-- Is Current a basic formal or like feature or
			-- like argument or like_current type which does
			-- not have a class type declaration
		do
		end;

	has_generics: BOOLEAN is
			-- Does Current have generics?
		do
		end;

	is_normal_class: BOOLEAN is
			-- Is Current a normal class type?
		do
			Result := not is_not_actual_class_type and then 
						not has_generics
		ensure
			is_normal_class: Result implies 
				not is_not_actual_class_type and then not has_generics
		end;

	real_class_ids: LINKED_LIST [CLASS_ID] is
			-- List of class id representing actual classes
			-- in system
		do
			!! Result.make;
		ensure
			valid_result: Result /= Void
		end

feature -- Output

	string_value: STRING is
			-- String value of Current
		require
			valid_free_text_name: free_text_name /= Void
		deferred
		ensure
			valid_result: Result /= Void
		end;

end -- class S_TYPE_INFO
