class POINTER_I

inherit
	BASIC_I
		redefine
			is_feature_pointer,
			same_as,
			description, sk_value, hash_code,
			element_type, default_create, tuple_code
		end

create
	default_create

feature {NONE} -- Initialization

	default_create is
			-- Initialize new instance of BOOLEAN_I
		do
			make (system.pointer_class.compiled_class.class_id)
		end

feature -- Status report

	element_type: INTEGER_8 is
			-- Pointer element type
		do
			Result := {MD_SIGNATURE_CONSTANTS}.Element_type_i
		end

	tuple_code: INTEGER_8 is
			-- Tuple code for class type
		do
			Result := {SHARED_GEN_CONF_LEVEL}.pointer_tuple_code
		end

	reference_type: CL_TYPE_I is
			-- Assocated reference type of Current.
		do
			create Result.make (system.pointer_ref_class.compiled_class.class_id)
		end

feature

	level: INTEGER is
			-- Internal code for generation
		do
			Result := C_pointer
		end

	is_feature_pointer: BOOLEAN is True
			-- Is the type a feature pointer type ?

	same_as (other: TYPE_I): BOOLEAN is
			-- Is `other' the equal to Current ?
		local
			l_ptr: POINTER_I
		do
			l_ptr ?= other
			Result := l_ptr /= Void
		end

	description: POINTER_DESC is
			-- Type description for skeleton
		do
			create Result
		end

	c_string: STRING is "EIF_POINTER"
			-- String generated for the type.
		
	union_tag: STRING is "parg"

	hash_code: INTEGER is
			-- Hash code for current type
		once
			Result := Pointer_code
		end

	sk_value: INTEGER is
			-- Generate SK value associated to the current type.
		do
			Result := Sk_pointer
		end

	generate_union (buffer: GENERATION_BUFFER) is
			-- Generate discriminant of C structure "item" associated
			-- to the current C type in `buffer'.
		do
			buffer.put_string ("it_ptr")
		end

	generate_sk_value (buffer: GENERATION_BUFFER) is
			-- Generate SK value associated to current C type in `buffer'.
		do
			buffer.put_string ("SK_POINTER")
		end
	
	type_a: POINTER_A is
		do
			create Result
		end

feature

	make_default_byte_code (ba: BYTE_ARRAY) is
			-- Generate default value of basic type on stack.
		do
			ba.append (Bc_null_pointer)
		end 

end
