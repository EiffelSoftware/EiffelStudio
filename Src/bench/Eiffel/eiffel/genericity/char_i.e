class CHAR_I

inherit

	BASIC_I
		redefine
			dump,
			is_char,
			same_as,
			description, sk_value, generate_cecil_value, hash_code
		end

feature

	level: INTEGER is
			-- Internal code for generation
		do
			Result := C_char;
		end;

	is_char: BOOLEAN is
			-- Is the type a char type ?
		do
			Result := True;
		end;

	same_as (other: TYPE_I): BOOLEAN is
			-- Is `other' equal to `Current' ?
		do
			Result := other.is_char;
		end;

	description: CHAR_DESC is
			-- Type description for skeleton
		do
			!!Result
		end;

	dump (file: UNIX_FILE) is
			-- Debug purpose
		do
			file.putstring ("CHAR");
		end;

	generate_cecil_value (file: UNIX_FILE) is
			-- Generate cecil type value
		do
			file.putstring ("SK_CHAR");
		end;

	generate (file: UNIX_FILE) is
			-- Generate C type in file `file'.
		do
			file.putstring ("char ");
		end;

	generate_cast (file: UNIX_FILE) is
			-- Generate C type cast in file `file'.
		do
			file.putstring ("(char) ");
		end;

	generate_access_cast (file: UNIX_FILE) is
			-- Generate access C cast in file `file'.
		do
			file.putstring ("(char *) ");
		end;

	generate_function_cast (file: UNIX_FILE) is
			-- Generate C function cast in file `file'.
		do
			file.putstring ("(char (*)()) ");
		end;

	generate_size (file: UNIX_FILE) is
			-- Generate size of C type
		do
			file.putstring ("sizeof(char)");
		end;

	hash_code: INTEGER is
			-- Hash code for current type
		do
			Result := Character_code;
		end;

	associated_reference: CLASS_TYPE is
			-- Reference class associated with simple type
		do
			Result :=
				system.character_ref_class.compiled_class.types.first;
		end;

	sk_value: INTEGER is
			-- Generate SK value associated to the current type.
		do
			Result := Sk_char;
		end;

	generate_union (file: UNIX_FILE) is
			-- Generate discriminant of C structure "item" associated
			-- to the current C type in `file'.
		do
			file.putstring ("it_char");
		end;

	generate_sk_value (file: UNIX_FILE) is
			-- Generate SK value associated to current C type in `file'.
		do
			file.putstring ("SK_CHAR");
		end;

end
