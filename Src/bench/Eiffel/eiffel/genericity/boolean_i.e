class BOOLEAN_I

inherit
	BASIC_I
		redefine
			is_boolean,
			dump,
			same_as,
			description, hash_code, sk_value, generate_cecil_value,
			generated_id
		end

feature

	level: INTEGER is
			-- Internal code for generation
		do
			Result := C_char
		end

	is_boolean: BOOLEAN is True
			-- Type is a boolean one.

	same_as (other: TYPE_I): BOOLEAN is
			-- Is `other' equal to `Current' ?
		do
			Result := other.is_boolean
		end

	description: BOOLEAN_DESC is
			-- Type description for skeleton
		do
			!! Result
		end

	dump (file: FILE) is
			-- Debug purpose
		do
			file.putstring ("BOOLEAN")
		end

	generate_cecil_value (file: INDENT_FILE) is
			-- Generate cecil type value
		do
			file.putstring ("SK_BOOL")
		end

	c_string: STRING is "EIF_BOOLEAN"
			-- String generated for the type.

	hash_code: INTEGER is
			-- Hash code for current type
		once
			Result := Boolean_code
		end

	associated_reference: CLASS_TYPE is
			-- Reference class associated with simple type
		do
			Result := system.boolean_ref_class.compiled_class.types.first
		end

	sk_value: INTEGER is
			-- Generate SK value associated to the current type.
		do
			Result := Sk_bool
		end

	generate_sk_value (file: INDENT_FILE) is
			-- Generate SK value associated to current C type in `file'.
		do
			file.putstring ("SK_BOOL")
		end

	type_a: BOOLEAN_A is
		do
			!! Result
		end

	separate_get_macro: STRING is "CURGB"
			-- String generated to access the argument to a separate call

	separate_send_macro: STRING is "CURSQRB"
			-- String generated to return the result of a separate call

	generate (file: INDENT_FILE) is
			-- Generate C type in file `file'.
		do
			file.putstring ("EIF_BOOLEAN ")
		end

	generate_cast (file: INDENT_FILE) is
			-- Generate C type cast in file `file'.
		do
			file.putstring ("(EIF_BOOLEAN) ")
		end

	generate_access_cast (file: INDENT_FILE) is
			-- Generate access C cast in file `file'.
		do
			file.putstring ("(EIF_BOOLEAN *) ")
		end

	generate_size (file: INDENT_FILE) is
			-- Generate size of C type
		do
			file.putstring ("sizeof(EIF_BOOLEAN)")
		end

	generate_union (file: INDENT_FILE) is
			-- Generate discriminant of C structure "item" associated
			-- to the current C type in `file'.
		do
			file.putstring ("it_char")
		end

feature -- Generic conformance

	generated_id (final_mode : BOOLEAN) : INTEGER is

		do
			Result := -3        -- Code for BOOLEAN
		end

end
