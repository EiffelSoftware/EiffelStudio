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
			Result := True
		end

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

	dump (file: FILE) is
			-- Debug purpose
		do
			file.putstring ("CHAR");
		end;

	generate_cecil_value (file: INDENT_FILE) is
			-- Generate cecil type value
		do
			file.putstring ("SK_CHAR");
		end;

	c_string: STRING is
			-- String generated for the type.
		do
			Result := "EIF_CHARACTER"
		end

	separate_get_macro: STRING is
			-- String generated to access the argument to a separate call
		do
			Result := "CURGC"
		end

	separate_send_macro: STRING is
			-- String generated to return the result of a separate call
		do
			Result := "CURSQRC"
		end

	generate (file: INDENT_FILE) is
			-- Generate C type in file `file'.
		do
			file.putstring ("EIF_CHARACTER ");
		end;

	generate_cast (file: INDENT_FILE) is
			-- Generate C type cast in file `file'.
		do
			file.putstring ("(EIF_CHARACTER) ");
		end;

	generate_access_cast (file: INDENT_FILE) is
			-- Generate access C cast in file `file'.
		do
			file.putstring ("(EIF_CHARACTER *) ");
		end;

	generate_size (file: INDENT_FILE) is
			-- Generate size of C type
		do
			file.putstring ("sizeof(EIF_CHARACTER)");
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

	generate_union (file: INDENT_FILE) is
			-- Generate discriminant of C structure "item" associated
			-- to the current C type in `file'.
		do
			file.putstring ("it_char");
		end;

	generate_sk_value (file: INDENT_FILE) is
			-- Generate SK value associated to current C type in `file'.
		do
			file.putstring ("SK_CHAR");
		end;

	type_a: CL_TYPE_A is
		do
			!CHARACTER_A!Result
		end

end
