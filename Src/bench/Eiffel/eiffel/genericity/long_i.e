class LONG_I

inherit
	BASIC_I
		redefine
			dump,
			is_long,
			is_numeric,
			same_as,
			description, sk_value, generate_cecil_value, hash_code,
			byte_code_cast, generated_id, heaviest
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

	heaviest (other : TYPE_I) : TYPE_I is

		do
			Result := other
		end

	dump (buffer: GENERATION_BUFFER) is
			-- Debug purpose
		do
			buffer.putstring ("LONG")
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

	generate_cecil_value (buffer: GENERATION_BUFFER) is
			-- Generate Cecil type value.
		do
			buffer.putstring ("SK_INT")
		end

	c_string: STRING is "EIF_INTEGER"
			-- String generated for the type.

	union_tag: STRING is "iarg"

	separate_get_macro: STRING is "CURGI"
			-- String generated to access the argument to a separate call

	separate_send_macro: STRING is "CURSQRI"
			-- String generated to return the result of a separate call

	generate (buffer: GENERATION_BUFFER) is
			-- Generate C type in `buffer'.
		do
			buffer.putstring ("EIF_INTEGER ")
		end

	generate_cast (buffer: GENERATION_BUFFER) is
			-- Generate C cast in `buffer'.
		do
			buffer.putstring ("(EIF_INTEGER) ")
		end

	generate_access_cast (buffer: GENERATION_BUFFER) is
			-- Generate access C cast in `buffer'.
		do
			buffer.putstring ("(EIF_INTEGER *) ")
		end

	generate_size (buffer: GENERATION_BUFFER) is
			-- Generate size of C type
		do
			buffer.putstring ("sizeof(EIF_INTEGER)")
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

	generate_union (buffer: GENERATION_BUFFER) is
			-- Generate discriminant of C structure "item" associated
			-- to the current C type in `buffer'.
		do
			buffer.putstring ("it_long")
		end

	generate_sk_value (buffer: GENERATION_BUFFER) is
			-- Generate SK value associated to current C type in `buffer'.
		do
			buffer.putstring ("SK_INT")
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

feature

	make_basic_creation_byte_code (ba : BYTE_ARRAY) is

		do
			ba.append (Bc_int)
			ba.append_integer (0)
		end 

end
