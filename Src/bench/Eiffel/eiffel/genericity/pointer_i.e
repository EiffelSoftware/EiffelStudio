class POINTER_I

inherit

	BASIC_I
		redefine
			dump,
			is_feature_pointer,
			same_as,
			description, sk_value, hash_code, generate_cecil_value
		end

feature

	level: INTEGER is
			-- Internal code for generation
		do
			Result := C_pointer;
		end;

	is_feature_pointer: BOOLEAN is True;
			-- Is the type a feature pointer type ?

	dump (file: UNIX_FILE) is
			-- Debug purpose
		do
			file.putstring ("POINTER");
		end;

	same_as (other: TYPE_I): BOOLEAN is
			-- Is `other' the equal to Current ?
		do
			Result := other.is_feature_pointer;
		end;

	description: POINTER_DESC is
			-- Type description for skeleton
		do
			!!Result
		end;

	generate_cecil_value (f: UNIX_FILE) is
			-- Generate Cecil type value.
		do
			f.putstring ("SK_POINTER");
		end;

	generate (file: UNIX_FILE) is
			-- Generate C type in file `file'.
		do
			file.putstring ("fnptr ");
		end;

	generate_cast (file: UNIX_FILE) is
			-- Generate C cast in file `file'.
		do
			file.putstring ("(fnptr) ");
		end;

	generate_access_cast (file: UNIX_FILE) is
			-- Generate access C cast in file `file'.
		do
			file.putstring ("(fnptr *) ");
		end;

	generate_function_cast (file: UNIX_FILE) is
			-- Generate C function cast in file `file'.
		do
			file.putstring ("(fnptr (*)()) ");
		end;

	generate_size (file: UNIX_FILE) is
			-- Generate size of C type
		do
			file.putstring ("sizeof(fnptr)");
		end;

	hash_code: INTEGER is
			-- Hash code for current type
		once
			Result := Pointer_code;
		end;

	associated_reference: CLASS_TYPE is
			-- Reference class associated with simple type
		do
			Result := system.pointer_ref_class.compiled_class.types.first;
		end;

	sk_value: INTEGER is
			-- Generate SK value associated to the current type.
		do
			Result := Sk_pointer;
		end;

	generate_union (file: UNIX_FILE) is
			-- Generate discriminant of C structure "item" associated
			-- to the current C type in `file'.
		do
			file.putstring ("it_ptr");
		end;

	generate_sk_value (file: UNIX_FILE) is
			-- Generate SK value associated to current C type in `file'.
		do
			file.putstring ("SK_POINTER");
		end;

end
