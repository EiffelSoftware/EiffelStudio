indexing
	description: "Real data type for code generation"
	date: "$Date$"
	revision: "$Revision$"

class REAL_32_I

inherit
	BASIC_I
		redefine
			is_real_32,
			is_numeric,
			same_as, element_type,
			description, sk_value, hash_code,
			heaviest, default_create, tuple_code
		end

	BYTE_CONST
		export
			{NONE} all
		redefine
			default_create
		end

	SHARED_IL_CODE_GENERATOR
		export
			{NONE} all
		redefine
			default_create
		end

create
	default_create

feature {NONE} -- Initialization

	default_create is
			-- Initialize instance of REAL_32_I.
		do
			make (system.real_32_class.compiled_class.class_id)
		end

feature -- Access

	description: REAL_32_DESC is
			-- Type description for skeleton
		do
			create Result
		end

	hash_code: INTEGER is
			-- Hash code for current type
		once
			Result := Real_32_code
		end

	sk_value: INTEGER is
			-- Generate SK value associated to the current type.
		do
			Result := Sk_real32
		end

	type_a: REAL_32_A is
		do
			create Result
		end

	element_type: INTEGER_8 is
			-- Pointer element type
		do
			Result := {MD_SIGNATURE_CONSTANTS}.Element_type_r4
		end

	tuple_code: INTEGER_8 is
			-- Tuple code for class type
		do
			Result := {SHARED_GEN_CONF_LEVEL}.real_32_tuple_code
		end

	level: INTEGER is
			-- Internal code for generation
		do
			Result := C_real32
		end

	reference_type: CL_TYPE_I is
			-- Assocated reference type of Current.
		do
			create Result.make (system.real_32_ref_class.compiled_class.class_id)
		end

feature -- Status report

	is_real_32: BOOLEAN is True
			-- Is the type a REAL_32 type ?

	is_numeric: BOOLEAN is True
			-- Is the type a numeric one ?

	heaviest (other : TYPE_I) : TYPE_I is
			-- `other' if `other' is heavier than Current,
			-- Current otherwise.
		do
			if other.is_real_64 then
				Result := other
			else
				Result := Current
			end
		end

feature -- Comparison

	same_as (other: TYPE_I): BOOLEAN is
			-- Is `other' equal to Current ?
		do
			Result := other.is_real_32
		end

feature -- C code generation

	c_string: STRING is "EIF_REAL_32"
			-- String generated for the type.
		
	union_tag: STRING is "farg"

	generate_union (buffer: GENERATION_BUFFER) is
			-- Generate discriminant of C structure "item" associated
			-- to the current C type in `buffer'.
		do
			buffer.put_string ("it_real32")
		end

	generate_sk_value (buffer: GENERATION_BUFFER) is
			-- Generate SK value associated to current C type in `buffer'.
		do
			buffer.put_string ("SK_REAL32")
		end

feature

	make_default_byte_code (ba: BYTE_ARRAY) is
			-- Generate default value of basic type on stack.
		do
				-- For precision purpose, `Bc_real32' accepts
				-- a double value.
			ba.append (Bc_real32)
			ba.append_double (0.0)
		end 

end
