class S_BASIC_TYPE_INFO

inherit

	S_TYPE_INFO
		redefine
			is_basic
		end

creation

	make

feature

	make (a_name: STRING) is
			-- Set free_text_nam to 'a_name'.
		require
			valid_name: a_name /= Void
		do
			free_text_name := a_name;
		end;

	is_valid: BOOLEAN is
		do	
			Result := free_text_name /= Void
		end;

	is_basic: BOOLEAN is
		do
			Result := True
		end;

	string_value: STRING is
		do
			Result := clone (free_text_name)
		end;

invariant

	valid_free_text_name: free_text_name /= Void

end
