class BOOLEAN_I

inherit
	BASIC_I
		redefine
			is_boolean,
			dump,
			same_as, element_type,
			description, hash_code, sk_value, generate_cecil_value,
			generated_id
		end

feature -- Status report

	element_type: INTEGER_8 is
			-- Pointer element type
		do
			Result := feature {MD_SIGNATURE_CONSTANTS}.Element_type_boolean
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
			create Result
		end

	dump (buffer: GENERATION_BUFFER) is
			-- Debug purpose
		do
			buffer.putstring ("EIF_BOOLEAN")
		end

	generate_cecil_value (buffer: GENERATION_BUFFER) is
			-- Generate cecil type value
		do
			buffer.putstring ("SK_BOOL")
		end

	c_string: STRING is "EIF_BOOLEAN"
			-- String generated for the type.

	c_string_id: INTEGER is
			-- String ID generated for Current
		once
			Result := Names_heap.eif_boolean_name_id
		end
		
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
			create Result
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
			Result := Boolean_type
		end

feature

	make_default_byte_code (ba: BYTE_ARRAY) is
			-- Generate default value of basic type on stack.
		do
			ba.append (Bc_bool)
			ba.append ('%U')
		end 

end
