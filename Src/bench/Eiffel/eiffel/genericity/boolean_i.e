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

	dump (buffer: GENERATION_BUFFER) is
			-- Debug purpose
		do
			buffer.putstring ("BOOLEAN")
		end

	generate_cecil_value (buffer: GENERATION_BUFFER) is
			-- Generate cecil type value
		do
			buffer.putstring ("SK_BOOL")
		end

	c_string: STRING is "EIF_BOOLEAN"
			-- String generated for the type.

	union_tag: STRING is "barg"

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

	generate_sk_value (buffer: GENERATION_BUFFER) is
			-- Generate SK value associated to current C type in `buffer'.
		do
			buffer.putstring ("SK_BOOL")
		end

	type_a: BOOLEAN_A is
		do
			!! Result
		end

	separate_get_macro: STRING is "CURGB"
			-- String generated to access the argument to a separate call

	separate_send_macro: STRING is "CURSQRB"
			-- String generated to return the result of a separate call

	generate (buffer: GENERATION_BUFFER) is
			-- Generate C type in `buffer'.
		do
			buffer.putstring ("EIF_BOOLEAN ")
		end

	generate_cast (buffer: GENERATION_BUFFER) is
			-- Generate C type cast in `buffer'.
		do
			buffer.putstring ("(EIF_BOOLEAN) ")
		end

	generate_access_cast (buffer: GENERATION_BUFFER) is
			-- Generate access C cast in `buffer'.
		do
			buffer.putstring ("(EIF_BOOLEAN *) ")
		end

	generate_size (buffer: GENERATION_BUFFER) is
			-- Generate size of C type
		do
			buffer.putstring ("sizeof(EIF_BOOLEAN)")
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
			Result := -3        -- Code for BOOLEAN
		end

feature

	make_basic_creation_byte_code (ba : BYTE_ARRAY) is

		do
			ba.append (Bc_bool)
			ba.append ('%U')
		end 

end
