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

feature -- Status report

	element_type: INTEGER_8 is
			-- Reference element type.
		do
			Result := feature {MD_SIGNATURE_CONSTANTS}.Element_type_object
		end
		
	tuple_code: INTEGER_8 is
			-- Tuple code
		do
			Result := feature {SHARED_GEN_CONF_LEVEL}.reference_tuple_code
		end

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

	name: STRING is "REFERENCE"
			-- Name of current class type

	il_type_name (a_prefix: STRING): STRING is
			-- Name of current class type.
		once
			Result := (create {CL_TYPE_I}.make (system.any_id)).il_type_name (Void)
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
			create Result
		end

	generate_cecil_value (f: GENERATION_BUFFER) is
			-- Generate Cecil type value.
		do
			generate_sk_value (f)
		end

	c_string: STRING is "EIF_REFERENCE"
			-- String generated for the type.

	union_tag: STRING is "rarg"

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
	
	generate_union (buffer: GENERATION_BUFFER) is
			-- Generate discriminant of C structure "item" associated
			-- to the current C type in `buffer'.
		do
			buffer.put_string ("it_ref")
		end

	generate_sk_value (buffer: GENERATION_BUFFER) is
			-- Generate SK value associated to current C type in `buffer'.
		do
			buffer.put_string ("SK_REF")
		end

	type_a: TYPE_A is
		do
			Result := System.any_class.compiled_class.actual_type
		end
	
end
