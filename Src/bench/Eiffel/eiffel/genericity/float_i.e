indexing
	description: "Real data type for code generation"
	date: "$Date$"
	revision: "$Revision$"

class FLOAT_I

inherit
	BASIC_I
		redefine
			is_float,
			is_numeric,
			same_as, element_type, il_convert_from,
			description, sk_value, generate_cecil_value, hash_code,
			generate_byte_code_cast, heaviest,
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
			-- Initialize instance of FLOAT_I.
		do
			make (system.real_class.compiled_class.class_id)
		end

feature -- Access

	description: REAL_DESC is
			-- Type description for skeleton
		do
			create Result
		end

	hash_code: INTEGER is
			-- Hash code for current type
		once
			Result := Real_code
		end

	sk_value: INTEGER is
			-- Generate SK value associated to the current type.
		do
			Result := Sk_float
		end

	type_a: REAL_A is
		do
			create Result
		end

	element_type: INTEGER_8 is
			-- Pointer element type
		do
			Result := feature {MD_SIGNATURE_CONSTANTS}.Element_type_r4
		end

	tuple_code: INTEGER_8 is
			-- Tuple code for class type
		do
			Result := feature {SHARED_GEN_CONF_LEVEL}.real_tuple_code
		end

	level: INTEGER is
			-- Internal code for generation
		do
			Result := C_float
		end

feature -- Status report

	is_float: BOOLEAN is True
			-- Is the type a float type ?

	is_numeric: BOOLEAN is True
			-- Is the type a numeric one ?

	heaviest (other : TYPE_I) : TYPE_I is
			-- `other' if `other' is heavier than Current,
			-- Current otherwise.
		do
			if other.is_double then
				Result := other
			else
				Result := Current
			end
		end

feature -- Comparison

	same_as (other: TYPE_I): BOOLEAN is
			-- Is `other' equal to Current ?
		do
			Result := other.is_float
		end

feature -- Byte code generation

	generate_byte_code_cast (ba: BYTE_ARRAY) is
			-- Code for interpreter cast
		do
			ba.append (Bc_cast_float)
		end

feature -- C code generation

	generate_cecil_value (buffer: GENERATION_BUFFER) is
			-- Generate Cecil type value.
		do
			buffer.putstring ("SK_FLOAT")
		end

	c_string: STRING is "EIF_REAL"
			-- String generated for the type.
		
	union_tag: STRING is "farg"

	generate_union (buffer: GENERATION_BUFFER) is
			-- Generate discriminant of C structure "item" associated
			-- to the current C type in `buffer'.
		do
			buffer.putstring ("it_float")
		end

	generate_sk_value (buffer: GENERATION_BUFFER) is
			-- Generate SK value associated to current C type in `buffer'.
		do
			buffer.putstring ("SK_FLOAT")
		end

feature -- IL code generation

	il_convert_from (source: TYPE_I) is
			-- Generate convertion from Current to `source' if needed.
		do
			if not source.is_float then
				il_generator.convert_to (Current)
			end
		end
		
feature

	make_default_byte_code (ba: BYTE_ARRAY) is
			-- Generate default value of basic type on stack.
		do
				-- For precision purpose, `Bc_float' accepts
				-- a double value.
			ba.append (Bc_float)
			ba.append_double (0.0)
		end 

end
