deferred class S_TYPE_INFO

feature 

	free_text_name: STRING;

	is_valid: BOOLEAN is
		deferred
		end;

	is_basic: BOOLEAN is
		do
		end;

	has_generics: BOOLEAN is
		do
		end;

	is_normal_class: BOOLEAN is
		do
			Result := not is_basic and then not has_generics
		end;

	string_value: STRING is
			-- String value of Current
		require
			valid_free_text_name: free_text_name /= Void
		deferred
		ensure
			valid_result: Result /= Void
		end;

	real_class_ids: LINKED_LIST [INTEGER] is
		do
			!! Result.make;
		end

end
