class FLOAT_I

inherit
	BASIC_I
		redefine
			dump,
			is_float,
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
			Result := C_float
		end

	byte_code_cast: CHARACTER is
			-- Code for interpreter cast
		do
			Result := Bc_cast_float
		end

	is_float: BOOLEAN is True
			-- Is the type a float type ?

	is_numeric: BOOLEAN is True
			-- Is the type a numeric one ?

	same_as (other: TYPE_I): BOOLEAN is
			-- Is `other' equal to Current ?
		do
			Result := other.is_float
		end

	dump (file: FILE) is
			-- Debug purpose
		do
			file.putstring ("FLOAT")
		end

	description: REAL_DESC is
			-- Type description for skeleton
		do
			!!Result
		end

	generate_cecil_value (file: INDENT_FILE) is
			-- Generate Cecil type value.
		do
			file.putstring ("SK_FLOAT")
		end

	c_string: STRING is "EIF_REAL"
			-- String generated for the type.

	separate_get_macro: STRING is "CURGR"
			-- String generated to access the argument to a separate call

	separate_send_macro: STRING is "CURSQRR"
			-- String generated to return the result of a separate call

	generate (file: INDENT_FILE) is
			-- Generate C type in file `file'.
		do
			file.putstring ("EIF_REAL ")
		end

	generate_cast (file: INDENT_FILE) is
			-- Generate C cast in file `file'.
		do
			file.putstring ("(EIF_REAL) ")
		end

	generate_access_cast (file: INDENT_FILE) is
			-- Generate access C cast in file `file'.
		do
			file.putstring ("(EIF_REAL *) ")
		end

	generate_size (file: INDENT_FILE) is
			-- Generate size of C type
		do
			file.putstring ("sizeof(EIF_REAL)")
		end

	hash_code: INTEGER is
			-- Hash code for current type
		once
			Result := Real_code
		end

	associated_reference: CLASS_TYPE is
			-- Reference class associated with simple type
		do
			Result := system.real_ref_class.compiled_class.types.first
		end

	sk_value: INTEGER is
			-- Generate SK value associated to the current type.
		do
			Result := Sk_float
		end

	generate_union (file: INDENT_FILE) is
			-- Generate discriminant of C structure "item" associated
			-- to the current C type in `file'.
		do
			file.putstring ("it_float")
		end

	generate_sk_value (file: INDENT_FILE) is
			-- Generate SK value associated to current C type in `file'.
		do
			file.putstring ("SK_FLOAT")
		end

	type_a: REAL_A is
		do
			!!Result
		end

feature -- Generic conformance

	generated_id (final_mode : BOOLEAN) : INTEGER is

		do
			Result := -5        -- Code for REAL
		end

end
