class REFERENCE_I

inherit

	TYPE_I
		rename
			same_type as general_same_type
		redefine
			is_reference,
			same_as
		end;
	TYPE_C
		undefine
			is_void, is_bit
		redefine
			is_pointer
		end;
	SHARED_C_LEVEL
		rename
			same_type as general_same_type
		end

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

	append_signature (a_clickable: OUTPUT_WINDOW) is
		do
			a_clickable.put_string ("REFERENCE");
		end;

	dump (file: FILE) is
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

	generate_cecil_value (f: INDENT_FILE) is
			-- Generate Cecil type value.
		do
			f.putstring ("SK_DTYPE");
		end;

	generate (file: INDENT_FILE) is
			-- Generate C type in file `file'.
		do
			file.putstring ("EIF_REFERENCE ");
		end;

	generate_access_cast (file: INDENT_FILE) is
			-- Generate access C cast in file `file'.
		do
			file.putstring ("(EIF_REFERENCE *) ");
		end;

	generate_cast (file: INDENT_FILE) is
			-- Generate C cast in file `file'.
		do
			file.putstring ("(EIF_REFERENCE) ");
		end;

	generate_function_cast (file: INDENT_FILE) is
			-- Generate C function cast in file `file'.
		do
			file.putstring ("(EIF_REFERENCE(*)()) ");
		end;

	generate_size (file: INDENT_FILE) is
			-- Generate size of C type
		do
			file.putstring ("sizeof(EIF_REFERENCE)");
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

	cecil_value: INTEGER is
		do
			Result := Sk_dtype;
		end;

	generate_union (file: INDENT_FILE) is
			-- Generate discriminant of C structure "item" associated
			-- to the current C type in `file'.
		do
			file.putstring ("it_ref");
		end;

	generate_sk_value (file: INDENT_FILE) is
			-- Generate SK value associated to current C type in `file'.
		do
			file.putstring ("SK_REF");
		end;

	type_a: TYPE_A is
		do
			Result := System.any_class.compiled_class.actual_type
		end

end
