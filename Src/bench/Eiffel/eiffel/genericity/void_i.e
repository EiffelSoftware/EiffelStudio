class VOID_I

inherit
	TYPE_I
		redefine
			is_void, same_as
		end

	TYPE_C
		export
			{NONE} generate_access_cast
		undefine
			is_void, is_bit
		end

	SHARED_C_LEVEL

feature

	level: INTEGER is
			-- Internal type value for generation
		do
			Result := C_void
		end

	c_type: TYPE_C is
			-- C type
		do
			Result := Current
		end

	append_signature (st: STRUCTURED_TEXT) is
		do
			st.add_string ("VOID")
		end

	dump (buffer: GENERATION_BUFFER) is
			-- Debug purpose
		do
			buffer.putstring ("void")
		end

	il_type_name: STRING is
			-- Name of current class type.
		do
			Result := "void"
		end

	same_as (other: TYPE_I): BOOLEAN is
			-- Is `other' the equal to Current ?
		do
			Result := other.is_void
		end

	is_void: BOOLEAN is True
			-- Type is a void one

	description: ATTR_DESC is
		do
			Result := Reference_c_type.description
		end

	generate_cecil_value (buffer: GENERATION_BUFFER) is
			-- Generate Cecil type value.
		do
		ensure then
			False
		end

	c_string: STRING is "void"
			-- String generated for the type.
			
	c_string_id: INTEGER is
			-- String ID generated for type.
		once
			Result := Names_heap.void_name_id
		end

	union_tag: STRING is "rarg"

	separate_get_macro: STRING is "not_implemented"
			-- String generated to access the argument to a separate call

	separate_send_macro: STRING is "not_implemented"
			-- String generated to return the result of a separate call

	hash_code: INTEGER is
			-- Hash code for current type
		once
			Result := Void_code
		end

	sk_value: INTEGER is
			-- Generate SK value associated to the current type.
		do
			Result := Sk_void
		end

	cecil_value: INTEGER is
		do
			Result := Sk_void
		end

	generate_union (buffer: GENERATION_BUFFER) is
			-- Generate discriminant of C structure "item" associated
			-- to the current C type in `buffer'.
		do
		ensure then
			False
		end

	generate_sk_value (buffer: GENERATION_BUFFER) is
			-- Generate SK value associated to current C type in `buffer'.
		do
			buffer.putstring ("SK_VOID")
		end

	type_a: TYPE_A is
		do
			!VOID_A!Result
		end

end
