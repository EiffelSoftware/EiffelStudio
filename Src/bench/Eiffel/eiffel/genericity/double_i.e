class
	DOUBLE_I

inherit
	BASIC_I
		redefine
			is_double,
			is_numeric,
			same_as, element_type, il_convert_from,
			description, sk_value, generate_cecil_value, hash_code,
			generate_byte_code_cast, default_create, tuple_code
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
			-- Initialize new instance of DOUBLE_I.
		do
			make (system.double_class.compiled_class.class_id)
		end
		
feature -- Status report

	element_type: INTEGER_8 is
			-- Pointer element type
		do
			Result := feature {MD_SIGNATURE_CONSTANTS}.Element_type_r8
		end

	tuple_code: INTEGER_8 is
			-- Tuple code for class type
		do
			Result := feature {SHARED_GEN_CONF_LEVEL}.double_tuple_code
		end

feature

	level: INTEGER is
			-- Internal code for generation
		do
			Result := C_double
		end

	generate_byte_code_cast (ba: BYTE_ARRAY) is
			-- Code for interpreter cast
		do
			ba.append (Bc_cast_double)
		end

	is_double: BOOLEAN is True
			-- Is the type a double type ?

	is_numeric: BOOLEAN is True
			-- Is the type a numeric one ?

	same_as (other: TYPE_I): BOOLEAN is
			-- Is `other' equal to Current ?
		do
			Result := other.is_double
		end

	description: DOUBLE_DESC is
			-- Type description for skeleton
		do
			create Result
		end

	generate_cecil_value (buffer: GENERATION_BUFFER) is
			-- Generate Cecil type value.
		do
			buffer.putstring ("SK_DOUBLE")
		end

	c_string: STRING is "EIF_DOUBLE"
			-- String generated for the type.
		
	union_tag: STRING is "darg"

	hash_code: INTEGER is
			-- Hash code for current type
		once
			Result := Double_code
		end

	sk_value: INTEGER is
			-- Generate SK value associated to the current type.
		do
			Result := Sk_double
		end

	generate_union (buffer: GENERATION_BUFFER) is
			-- Generate discriminant of C structure "item" associated
			-- to the current C type in `buffer'.
		do
			buffer.putstring ("it_double")
		end

	generate_sk_value (buffer: GENERATION_BUFFER) is
			-- Generate SK value associated to current C type in `buffer'.
		do
			buffer.putstring ("SK_DOUBLE")
		end

	type_a: DOUBLE_A is
		do
			create Result
		end

feature -- IL code generation

	il_convert_from (source: TYPE_I) is
			-- Generate convertion from Current to `source' if needed.
		do
			if not source.is_double then
				il_generator.convert_to (Current)
			end
		end

feature

	make_default_byte_code (ba: BYTE_ARRAY) is
			-- Generate default value of basic type on stack.
		do
			ba.append (Bc_double)
			ba.append_double (0.0)
		end 

end
