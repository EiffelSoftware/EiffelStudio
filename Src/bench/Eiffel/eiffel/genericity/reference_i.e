class REFERENCE_I

inherit

	TYPE_I
		redefine
			is_reference,
			same_as
		end;
	TYPE_C
		undefine
			is_void
		redefine
			is_pointer
		end;
	SHARED_C_LEVEL;

feature

	level: INTEGER is
			-- Internal code for generation
		do
			Result := C_ref;
		end;

	is_pointer: BOOLEAN is True;
			-- The C type is a reference type.

	is_reference: BOOLEAN is True;
			-- is the C type a reference type ?

	dump (file: UNIX_FILE) is
			-- Debug purpose
		do
			file.putstring ("REFERENCE");
		end;

	same_as (other: TYPE_I): BOOLEAN is
			-- Is `other' equal to Current ?
		do
			Result := other.is_reference;
		end;

	c_type: TYPE_C is
			-- C type
		once
			Result := Current;
		end;

	description: REFERENCE_DESC is
			-- Type description for skeleton
		do
			!!Result
		end;

	generate_cecil_value (f: UNIX_FILE) is
			-- Generate Cecil type value.
		do
			f.putstring ("SK_DTYPE");
		end;

	generate (file: UNIX_FILE) is
			-- Generate C type in file `file'.
		do
			file.putstring ("char *");
		end;

	generate_access_cast (file: UNIX_FILE) is
			-- Generate access C cast in file `file'.
		do
			file.putstring ("(char **) ");
		end;

	generate_cast (file: UNIX_FILE) is
			-- Generate C cast in file `file'.
		do
			file.putstring ("(char *) ");
		end;

	generate_function_cast (file: UNIX_FILE) is
			-- Generate C function cast in file `file'.
		do
			file.putstring ("(char *(*)()) ");
		end;

	generate_size (file: UNIX_FILE) is
			-- Generate size of C type
		do
			file.putstring ("sizeof(char *)");
		end;

	hash_code: INTEGER is
			-- Hash code for current type
		once
			Result := Reference_code;
		end;

	sk_value: INTEGER is
			-- Generate SK value associated to the current type.
		do
			Result := Sk_ref;
		end;

	generate_union (file: UNIX_FILE) is
			-- Generate discriminant of C structure "item" associated
			-- to the current C type in `file'.
		do
			file.putstring ("it_ref");
		end;

	generate_sk_value (file: UNIX_FILE) is
			-- Generate SK value associated to current C type in `file'.
		do
			file.putstring ("SK_REF");
		end;

end
