class CHAR_I

inherit
	BASIC_I
		redefine
			dump,
			is_char,
			same_as,
			description, sk_value, generate_cecil_value, hash_code,
			generated_id
		end

feature

	level: INTEGER is
			-- Internal code for generation
		do
			Result := C_char
		end

	is_char: BOOLEAN is True
			-- Is the type a char type ?

	same_as (other: TYPE_I): BOOLEAN is
			-- Is `other' equal to `Current' ?
		do
			Result := other.is_char
		end

	description: CHAR_DESC is
			-- Type description for skeleton
		do
			!!Result
		end

	dump (buffer: GENERATION_BUFFER) is
			-- Debug purpose
		do
			buffer.putstring ("CHAR")
		end

	generate_cecil_value (buffer: GENERATION_BUFFER) is
			-- Generate cecil type value
		do
			buffer.putstring ("SK_CHAR")
		end

	c_string: STRING is "EIF_CHARACTER"
			-- String generated for the type.

	hash_code: INTEGER is
			-- Hash code for current type
		do
			Result := Character_code
		end

	associated_reference: CLASS_TYPE is
			-- Reference class associated with simple type
		do
			Result := system.character_ref_class.compiled_class.types.first
		end

	sk_value: INTEGER is
			-- Generate SK value associated to the current type.
		do
			Result := Sk_char
		end

	generate_sk_value (buffer: GENERATION_BUFFER) is
			-- Generate SK value associated to current C type in `buffer'.
		do
			buffer.putstring ("SK_CHAR")
		end

	type_a: CHARACTER_A is
		do
			!! Result
		end

	separate_get_macro: STRING is "CURGC"
			-- String generated to access the argument to a separate call

	separate_send_macro: STRING is "CURSQRC"
			-- String generated to return the result of a separate call

	generate (buffer: GENERATION_BUFFER) is
			-- Generate C type in `buffer'.
		do
			buffer.putstring ("EIF_CHARACTER ")
		end

	generate_cast (buffer: GENERATION_BUFFER) is
			-- Generate C type cast in `buffer'.
		do
			buffer.putstring ("(EIF_CHARACTER) ")
		end

	generate_access_cast (buffer: GENERATION_BUFFER) is
			-- Generate access C cast in `buffer'.
		do
			buffer.putstring ("(EIF_CHARACTER *) ")
		end

	generate_size (buffer: GENERATION_BUFFER) is
			-- Generate size of C type
		do
			buffer.putstring ("sizeof(EIF_CHARACTER)")
		end

	generate_union (buffer: GENERATION_BUFFER) is
			-- Generate discriminant of C structure "item" associated
			-- to the current C type in `buffer'.
		do
			buffer.putstring ("it_char")
		end

feature -- Generic conformance

	generated_id (final_mode : BOOLEAN) : INTEGER is

		do
			Result := -2        -- Code for CHARACTER
		end

end
