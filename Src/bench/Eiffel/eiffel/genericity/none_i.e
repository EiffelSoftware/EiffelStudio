class NONE_I

inherit
	TYPE_I
		redefine
			is_none, is_void, is_bit, is_basic, 
			is_reference, same_as,
			description, sk_value, generate_cecil_value, hash_code,
			generated_id,
			generate_gen_type_il
		end

	TYPE_C
		redefine
			is_void, is_bit, is_pointer
		end

	SHARED_C_LEVEL

feature -- Status report

	element_type: INTEGER_8 is
			-- NONE element type
		do
			Result := {MD_SIGNATURE_CONSTANTS}.Element_type_object
		end

	tuple_code: INTEGER_8 is
			-- Formal tuple code. Should not be called.
		do
			Result := {SHARED_GEN_CONF_LEVEL}.reference_tuple_code
		end

feature

	level: INTEGER is
			-- Level for generated C code
		do
			Result := C_ref
		end

	is_none: BOOLEAN is True
			-- Is the type a none type ?

	is_void: BOOLEAN is False
			-- A NONE type is not a void C type.

	is_basic: BOOLEAN is False
			-- A NONE type is not a basic type.

	is_bit: BOOLEAN is False
			-- A NONE type is not a bit.

	is_reference: BOOLEAN is True
			-- A NONE type is a reference

	is_pointer: BOOLEAN is True
			-- A NONE type is a pointer

	name: STRING is "NONE"
			-- Name of current type

	il_type_name (a_prefix: STRING): STRING is
			-- Name of current class type.
		once
			Result := name
		end

	same_as (other: TYPE_I): BOOLEAN is
			-- Is `other' the equal to Current ?
		do
			Result := other.is_none
		end

	description: REFERENCE_DESC is
			-- Type description for skeleton
		do
			Result := Reference_c_type.description
			Result.set_type_i (Current)
		end

	generate_cecil_value (buffer: GENERATION_BUFFER) is
			-- Generate Cecil type value.
		do
			generate_sk_value (buffer)
		end

	c_string: STRING is "EIF_REFERENCE"
			-- String generated for the type.

	union_tag: STRING is "rarg"

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
	
	type_a: NONE_A is
		do
			create Result
		end

	c_type: TYPE_C is
			-- C type
		do
			Result := Current
		end

feature -- Generic conformance

	generated_id (final_mode : BOOLEAN) : INTEGER is
			-- Id corresponding to current type.
		do
			Result := None_type
		end

feature -- Generic conformace for IL

	generate_gen_type_il (il_generator: IL_CODE_GENERATOR; use_info: BOOLEAN) is
			-- `use_info' is true iff we generate code for a 
			-- creation instruction.
		do
			il_generator.generate_none_type_instance
		end

end -- class NONE_I

