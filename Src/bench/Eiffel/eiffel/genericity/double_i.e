class
	REAL_64_I

inherit
	BASIC_I
		redefine
			is_real_64,
			is_numeric,
			same_as, element_type,
			description, sk_value, hash_code,
			default_create, tuple_code
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
			-- Initialize new instance of REAL_64_I.
		do
			make (system.real_64_class.compiled_class.class_id)
		end
		
feature -- Status report

	element_type: INTEGER_8 is
			-- Pointer element type
		do
			Result := {MD_SIGNATURE_CONSTANTS}.Element_type_r8
		end

	tuple_code: INTEGER_8 is
			-- Tuple code for class type
		do
			Result := {SHARED_GEN_CONF_LEVEL}.real_64_tuple_code
		end

	reference_type: CL_TYPE_I is
			-- Assocated reference type of Current.
		do
			create Result.make (system.real_64_ref_class.compiled_class.class_id)
		end

feature

	level: INTEGER is
			-- Internal code for generation
		do
			Result := C_real64
		end

	is_real_64: BOOLEAN is True
			-- Is the type a double type ?

	is_numeric: BOOLEAN is True
			-- Is the type a numeric one ?

	same_as (other: TYPE_I): BOOLEAN is
			-- Is `other' equal to Current ?
		do
			Result := other.is_real_64
		end

	description: REAL_64_DESC is
			-- Type description for skeleton
		do
			create Result
		end

	c_string: STRING is "EIF_REAL_64"
			-- String generated for the type.
		
	union_tag: STRING is "darg"

	hash_code: INTEGER is
			-- Hash code for current type
		once
			Result := Real_64_code
		end

	sk_value: INTEGER is
			-- Generate SK value associated to the current type.
		do
			Result := Sk_real64
		end

	generate_union (buffer: GENERATION_BUFFER) is
			-- Generate discriminant of C structure "item" associated
			-- to the current C type in `buffer'.
		do
			buffer.put_string ("it_real64")
		end

	generate_sk_value (buffer: GENERATION_BUFFER) is
			-- Generate SK value associated to current C type in `buffer'.
		do
			buffer.put_string ("SK_REAL64")
		end

	type_a: REAL_64_A is
		do
			create Result
		end

feature

	make_default_byte_code (ba: BYTE_ARRAY) is
			-- Generate default value of basic type on stack.
		do
			ba.append (Bc_real64)
			ba.append_double (0.0)
		end 

end
