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
			Result := C_pointer
		end

	is_feature_pointer: BOOLEAN is True
			-- Is the type a feature pointer type ?

	dump (file: FILE) is
			-- Debug purpose
		do
			file.putstring ("POINTER")
		end

	same_as (other: TYPE_I): BOOLEAN is
			-- Is `other' the equal to Current ?
		do
			Result := other.is_feature_pointer
		end

	description: POINTER_DESC is
			-- Type description for skeleton
		do
			!!Result
		end

	generate_cecil_value (f: INDENT_FILE) is
			-- Generate Cecil type value.
		do
			f.putstring ("SK_POINTER")
		end

	c_string: STRING is "EIF_POINTER"
			-- String generated for the type.

	separate_get_macro: STRING is "CURGP"
			-- String generated to access the argument to a separate call

	separate_send_macro: STRING is "CURSQRP"
			-- String generated to return the result of a separate call

	generate (file: INDENT_FILE) is
			-- Generate C type in file `file'.
		do
			file.putstring ("EIF_POINTER ")
		end

	generate_cast (file: INDENT_FILE) is
			-- Generate C cast in file `file'.
		do
			file.putstring ("(EIF_POINTER) ")
		end

	generate_access_cast (file: INDENT_FILE) is
			-- Generate access C cast in file `file'.
		do
			file.putstring ("(EIF_POINTER *) ")
		end

	generate_size (file: INDENT_FILE) is
			-- Generate size of C type
		do
			file.putstring ("sizeof(EIF_POINTER)")
		end

	hash_code: INTEGER is
			-- Hash code for current type
		once
			Result := Pointer_code
		end

	associated_reference: CLASS_TYPE is
			-- Reference class associated with simple type
		do
			Result := system.pointer_ref_class.compiled_class.types.first
		end

	sk_value: INTEGER is
			-- Generate SK value associated to the current type.
		do
			Result := Sk_pointer
		end

	generate_union (file: INDENT_FILE) is
			-- Generate discriminant of C structure "item" associated
			-- to the current C type in `file'.
		do
			file.putstring ("it_ptr")
		end

	generate_sk_value (file: INDENT_FILE) is
			-- Generate SK value associated to current C type in `file'.
		do
			file.putstring ("SK_POINTER")
		end

	type_a: POINTER_A is
		do
			!!Result
		end

end
