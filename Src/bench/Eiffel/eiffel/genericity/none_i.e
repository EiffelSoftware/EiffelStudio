class NONE_I

inherit
	TYPE_I
		redefine
			dump, is_none, is_void, is_bit, is_basic, same_as,
			description, sk_value, generate_cecil_value, hash_code,
			cecil_value, append_signature, generated_id
		end

	TYPE_C
		redefine
			is_void, is_bit
		end

	SHARED_C_LEVEL

feature

	level: INTEGER is
			-- Level for generated C code
		do
			Result := C_void
		end

	is_none: BOOLEAN is True
			-- Is the type a none type ?

	is_void: BOOLEAN is True
			-- Is the type a C void type ?

	is_basic: BOOLEAN is False
			-- A NONE type is not a basic type.

	is_bit: BOOLEAN is False
			-- A NONE type is not a bit.

	append_signature (st: STRUCTURED_TEXT) is
		do
			st.add_string ("NONE")
		end

	dump (buffer: GENERATION_BUFFER) is
			-- Debug purpose
		do
			buffer.putstring ("NONE")
		end

	same_as (other: TYPE_I): BOOLEAN is
			-- Is `other' the equal to Current ?
		do
			Result := other.is_none
		end

	description: ATTR_DESC is
			-- Type description for skeleton
		do
			-- Do nothing
		ensure then
			False
		end

	generate_cecil_value (buffer: GENERATION_BUFFER) is
			-- Generate Cecil type value.
		do
			buffer.putstring ("SK_DTYPE")
		end

	c_string: STRING is "char *"
			-- String generated for the type.

	union_tag: STRING is "rarg"

	separate_get_macro: STRING is "not_implemented"
			-- String generated to access the argument to a separate call

	separate_send_macro: STRING is "not_implemented"
			-- String generated to return the result of a separate call

	generate (buffer: GENERATION_BUFFER) is
			-- Generate C type in `buffer'.
		do
			buffer.putstring ("char *")
		end

	generate_cast (buffer: GENERATION_BUFFER) is
			-- Generate C cast in `buffer'.
		do
			buffer.putstring ("(char *) ")
		end

	generate_access_cast (buffer: GENERATION_BUFFER) is
			-- Generate access C cast in `buffer'.
		do
			buffer.putstring ("(char **) ")
		end

	generate_size (buffer: GENERATION_BUFFER) is
			-- Generate size of C type
		do
			buffer.putstring ("sizeof(char *)")
		end

	hash_code: INTEGER is
			-- Hash code for current type
		once
			Result := None_code
		end

	associated_reference: CLASS_TYPE is
			-- Void
		do
		end

	sk_value: INTEGER is
			-- Generate SK value associated to the current type.
		do
			Result := Sk_ref
		end

	cecil_value: INTEGER is
		do
			Result := Sk_dtype
		end

	generate_union (buffer: GENERATION_BUFFER) is
			-- Generate discriminant of C structure "item" associated
			-- to the current C type in `buffer'.
		do
			buffer.putstring ("it_ref")
		end

	generate_sk_value (buffer: GENERATION_BUFFER) is
			-- Generate SK value associated to current C type in `buffer'.
		do
			buffer.putstring ("SK_REF")
		end

	type_a: NONE_A is
		do
			!! Result
		end

	c_type: TYPE_C is
			-- C type
		do
			Result ?= Current
		end

feature -- Generic conformance

	generated_id (final_mode : BOOLEAN) : INTEGER is

		do
			Result := -9        -- Code for NONE
		end

end
