class REFERENCE_I

inherit
	TYPE_I
		redefine
			is_reference,
			same_as
		end

	TYPE_C
		undefine
			is_void, is_bit
		redefine
			is_pointer
		end

	SHARED_C_LEVEL

feature

	level: INTEGER is
			-- Internal code for generation
		do
			Result := C_ref
		end

	is_pointer: BOOLEAN is True
			-- The C type is a reference type.

	is_reference: BOOLEAN is True
			-- is the C type a reference type ?

	append_signature (st: STRUCTURED_TEXT) is
		do
			st.add_string ("REFERENCE")
		end

	dump (buffer: GENERATION_BUFFER) is
			-- Debug purpose
		do
			buffer.putstring ("REFERENCE")
		end

	same_as (other: TYPE_I): BOOLEAN is
			-- Is `other' equal to Current ?
		do
			Result := other.is_reference
		end

	c_type: TYPE_C is
			-- C type
		once
			Result := Current
		end

	description: REFERENCE_DESC is
			-- Type description for skeleton
		do
			!!Result
		end

	generate_cecil_value (f: GENERATION_BUFFER) is
			-- Generate Cecil type value.
		do
			f.putstring ("SK_DTYPE")
		end

	c_string: STRING is "EIF_REFERENCE"
			-- String generated for the type.

	union_tag: STRING is "rarg"

	separate_get_macro: STRING is "CURGSO"
			-- String generated to access the argument to a separate call

	separate_send_macro: STRING is "CURSQRSO"
			-- String generated to return the result of a separate call

	generate (buffer: GENERATION_BUFFER) is
			-- Generate C type in `buffer'.
		do
			buffer.putstring ("EIF_REFERENCE ")
		end

	generate_access_cast (buffer: GENERATION_BUFFER) is
			-- Generate access C cast in `buffer'.
		do
			buffer.putstring ("(EIF_REFERENCE *) ")
		end

	generate_cast (buffer: GENERATION_BUFFER) is
			-- Generate C cast in `buffer'.
		do
			buffer.putstring ("(EIF_REFERENCE) ")
		end

	generate_size (buffer: GENERATION_BUFFER) is
			-- Generate size of C type
		do
			buffer.putstring ("sizeof(EIF_REFERENCE)")
		end

	hash_code: INTEGER is
			-- Hash code for current type
		once
			Result := Reference_code
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

	type_a: TYPE_A is
		do
			Result := System.any_class.compiled_class.actual_type
		end

end
