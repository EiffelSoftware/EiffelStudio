class DOUBLE_I

inherit

	BASIC_I
		redefine
			dump,
			is_double,
			is_numeric,
			same_as,
			description, sk_value, generate_cecil_value, hash_code,
			byte_code_cast
		end;
	BYTE_CONST

feature

	level: INTEGER is
			-- Internal code for generation
		do
			Result := C_double;
		end;

	byte_code_cast: CHARACTER is
			-- Code for interpreter cast
		do
			Result := Bc_cast_double;
		end;

	is_double: BOOLEAN is
			-- Is the type a double type ?
		do
			Result := True;
		end;

	is_numeric: BOOLEAN is
			-- Is the type a numeric one ?
		do
			Result := True;
		end;

	same_as (other: TYPE_I): BOOLEAN is
			-- Is `other' equal to Current ?
		do
			Result := other.is_double
		end;

	dump (file: UNIX_FILE) is
			-- Debug purpose
		do
			file.putstring ("DOUBLE");
		end;

	description: DOUBLE_DESC is
			-- Type description for skeleton
		do
			!!Result
		end;

	generate_cecil_value (file: UNIX_FILE) is
			-- Generate Cecil type value.
		do
			file.putstring ("SK_DOUBLE");
		end;

	generate (file: UNIX_FILE) is
			-- Generate C type in file `file'.
		do
			file.putstring ("double ");
		end;

	generate_cast (file: UNIX_FILE) is
			-- Generate C cast in file `file'.
		do
			file.putstring ("(double) ");
		end;

	generate_access_cast (file: UNIX_FILE) is
			-- Generate access C cast in file `file'.
		do
			file.putstring ("(double *) ");
		end;

	generate_function_cast (file: UNIX_FILE) is
			-- Generate C function cast in file `file'.
		do
			file.putstring ("(double (*)()) ");
		end;

	generate_size (file: UNIX_FILE) is
			-- Generate size of C type
		do
			file.putstring ("sizeof(double)");
		end;

	hash_code: INTEGER is
			-- Hash code for current type
		once
			Result := Double_code;
		end;

	associated_reference: CLASS_TYPE is
			-- Reference class associated with simple type
		do
			Result := system.double_ref_class.compiled_class.types.first;
		end;

	sk_value: INTEGER is
			-- Generate SK value associated to the current type.
		do
			Result := Sk_double
		end;

	generate_union (file: UNIX_FILE) is
			-- Generate discriminant of C structure "item" associated
			-- to the current C type in `file'.
		do
			file.putstring ("it_double");
		end;

	generate_sk_value (file: UNIX_FILE) is
			-- Generate SK value associated to current C type in `file'.
		do
			file.putstring ("SK_DOUBLE");
		end;

end
