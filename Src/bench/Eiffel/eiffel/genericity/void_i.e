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
			is_bit
		redefine
			is_void
		end

	SHARED_C_LEVEL

feature -- Status report

	element_type: INTEGER_8 is
			-- Void element type
		do
			Result := {MD_SIGNATURE_CONSTANTS}.Element_type_void
		end
		
	tuple_code: INTEGER_8 is
			-- Code for Void.
		do
			-- Nothing
		end
		
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

	il_type_name (a_prefix: STRING): STRING is
			-- Name of current class type.
		once
			Result := name
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
			generate_sk_value (buffer)
		ensure then
			False
		end

	name, c_string: STRING is "void"
			-- String generated for the type.
			
	union_tag: STRING is "rarg"

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
			buffer.put_string ("SK_VOID")
		end

	type_a: TYPE_A is
		do
			create {VOID_A} Result
		end

end
