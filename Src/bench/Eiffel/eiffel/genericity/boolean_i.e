class BOOLEAN_I

inherit

	CHAR_I
		redefine
			is_char, is_boolean, dump, same_as,
			description, hash_code,
			associated_reference, generate_cecil_value, sk_value,
			generate_sk_value
		end

feature

	is_char: BOOLEAN is False;
			-- Is the type a char type ?

	is_boolean: BOOLEAN is True;
			-- Type is a boolean one.

	same_as (other: TYPE_I): BOOLEAN is
			-- Is `other' equal to `Current' ?
		do
			Result := 	other.is_boolean
		end;

	description: BOOLEAN_DESC is
			-- Type description for skeleton
		do
			!!Result
		end;

	dump (file: UNIX_FILE) is
			-- Debug purpose
		do
			file.putstring ("BOOLEAN");
		end;

	hash_code: INTEGER is
			-- Hash code for current type
		once
			Result := Boolean_code;
		end;

	associated_reference: CLASS_TYPE is
			-- Reference class associated with simple type
		do
			Result := system.boolean_ref_class.compiled_class.types.first;
		end;

	generate_cecil_value (file: UNIX_FILE) is
			-- Generate cecil type value
		do
			file.putstring ("SK_BOOL");
		end;

	sk_value: INTEGER is
			-- Generate SK value associated to the current type.
		do
			Result := Sk_bool;
		end;

	generate_sk_value (file: UNIX_FILE) is
			-- Generate SK value associated to current C type in `file'.
		do
			file.putstring ("SK_BOOL");
		end;

end
