class BOOLEAN_I

inherit
	BASIC_I
		redefine
			is_boolean,
			same_as, element_type,
			description, hash_code, sk_value,
			default_create, tuple_code
		end

create
	default_create

feature {NONE} -- Initialization

	default_create is
			-- Initialize new instance of BOOLEAN_I
		do
			make (system.boolean_class.compiled_class.class_id)
		end

feature -- Status report

	element_type: INTEGER_8 is
			-- Pointer element type
		do
			Result := {MD_SIGNATURE_CONSTANTS}.Element_type_boolean
		end

	tuple_code: INTEGER_8 is
			-- Tuple code for class type
		do
			Result := {SHARED_GEN_CONF_LEVEL}.boolean_tuple_code
		end

	reference_type: CL_TYPE_I is
			-- Assocated reference type of Current.
		do
			create Result.make (system.boolean_ref_class.compiled_class.class_id)
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

	c_string: STRING is "EIF_BOOLEAN"
			-- String generated for the type.
		
	union_tag: STRING is "barg"

	hash_code: INTEGER is
			-- Hash code for current type
		once
			Result := Boolean_code
		end

	sk_value: INTEGER is
			-- Generate SK value associated to the current type.
		do
			Result := Sk_bool
		end

	generate_sk_value (buffer: GENERATION_BUFFER) is
			-- Generate SK value associated to current C type in `buffer'.
		do
			buffer.put_string ("SK_BOOL")
		end

	type_a: BOOLEAN_A is
		do
			create Result
		end

	generate_union (buffer: GENERATION_BUFFER) is
			-- Generate discriminant of C structure "item" associated
			-- to the current C type in `buffer'.
		do
			buffer.put_string ("it_char")
		end

feature

	make_default_byte_code (ba: BYTE_ARRAY) is
			-- Generate default value of basic type on stack.
		do
			ba.append (Bc_bool)
			ba.append ('%U')
		end 

end
