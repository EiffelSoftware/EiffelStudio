class LONG_I

inherit
	BASIC_I
		redefine
			dump,
			is_long,
			is_numeric,
			same_as,
			description, sk_value, generate_cecil_value, hash_code,
			byte_code_cast, generated_id
		end

	BYTE_CONST

feature

	level: INTEGER is
			-- Internal code for generation
		do
			Result := C_long
		end

	byte_code_cast: CHARACTER is
			-- Code for interpreter cast
		do
			Result := Bc_cast_long
		end

	is_long: BOOLEAN is True
			-- Is the type a long type ?

	is_numeric: BOOLEAN is True
			-- Is the type a numeric one ?

	dump (file: FILE) is
			-- Debug purpose
		do
			file.putstring ("LONG")
		end

	same_as (other: TYPE_I): BOOLEAN is
			-- Is `other' the equal to Current ?
		do
			Result := other.is_long
		end

	description: INTEGER_DESC is
			-- Type description for skeleton
		do
			!! Result
		end

	generate_cecil_value (file: INDENT_FILE) is
			-- Generate Cecil type value.
		do
			file.putstring ("SK_INT")
		end

	c_string: STRING is "EIF_INTEGER"
			-- String generated for the type.

	separate_get_macro: STRING is "CURGI"
			-- String generated to access the argument to a separate call

	separate_send_macro: STRING is "CURSQRI"
			-- String generated to return the result of a separate call

	generate (file: INDENT_FILE) is
			-- Generate C type in file `file'.
		do
			file.putstring ("EIF_INTEGER ")
		end

	generate_cast (file: INDENT_FILE) is
			-- Generate C cast in file `file'.
		do
			file.putstring ("(EIF_INTEGER) ")
		end

	generate_access_cast (file: INDENT_FILE) is
			-- Generate access C cast in file `file'.
		do
			file.putstring ("(EIF_INTEGER *) ")
		end

	generate_size (file: INDENT_FILE) is
			-- Generate size of C type
		do
			file.putstring ("sizeof(EIF_INTEGER)")
		end

	hash_code: INTEGER is
			-- Hash code for current type
		once
			Result := Integer_code
		end

	associated_reference: CLASS_TYPE is
			-- Reference class associated with simple type
		do
			Result := system.integer_ref_class.compiled_class.types.first
		end

	sk_value: INTEGER is
			-- Generate SK value associated to the current type.
		do
			Result := Sk_int
		end

	generate_union (file: INDENT_FILE) is
			-- Generate discriminant of C structure "item" associated
			-- to the current C type in `file'.
		do
			file.putstring ("it_long")
		end

	generate_sk_value (file: INDENT_FILE) is
			-- Generate SK value associated to current C type in `file'.
		do
			file.putstring ("SK_INT")
		end

	type_a: INTEGER_A is
		do
			!! Result
		end

feature -- Generic conformance

	generated_id (final_mode : BOOLEAN) : INTEGER is

		do
			Result := -4        -- Code for INTEGER
		end

end
