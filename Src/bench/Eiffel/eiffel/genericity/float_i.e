class FLOAT_I

inherit
	BASIC_I
		redefine
			dump,
			is_float,
			is_numeric,
			same_as,
			description, sk_value, generate_cecil_value, hash_code,
			generate_byte_code_cast, generated_id, heaviest
		end

	BYTE_CONST

feature

	level: INTEGER is
			-- Internal code for generation
		do
			Result := C_float
		end

	generate_byte_code_cast (ba: BYTE_ARRAY) is
			-- Code for interpreter cast
		do
			ba.append (Bc_cast_float)
		end

	is_float: BOOLEAN is True
			-- Is the type a float type ?

	is_numeric: BOOLEAN is True
			-- Is the type a numeric one ?

	heaviest (other : TYPE_I) : TYPE_I is

		do
			if other.is_double then
				Result := other
			else
				Result := Current
			end
		end

	same_as (other: TYPE_I): BOOLEAN is
			-- Is `other' equal to Current ?
		do
			Result := other.is_float
		end

	dump (buffer: GENERATION_BUFFER) is
			-- Debug purpose
		do
			buffer.putstring ("EIF_REAL")
		end

	description: REAL_DESC is
			-- Type description for skeleton
		do
			!!Result
		end

	generate_cecil_value (buffer: GENERATION_BUFFER) is
			-- Generate Cecil type value.
		do
			buffer.putstring ("SK_FLOAT")
		end

	c_string: STRING is "EIF_REAL"
			-- String generated for the type.

	union_tag: STRING is "farg"

	separate_get_macro: STRING is "CURGR"
			-- String generated to access the argument to a separate call

	separate_send_macro: STRING is "CURSQRR"
			-- String generated to return the result of a separate call

	hash_code: INTEGER is
			-- Hash code for current type
		once
			Result := Real_code
		end

	associated_reference: CLASS_TYPE is
			-- Reference class associated with simple type
		do
			Result := system.real_ref_class.compiled_class.types.first
		end

	sk_value: INTEGER is
			-- Generate SK value associated to the current type.
		do
			Result := Sk_float
		end

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

	type_a: REAL_A is
		do
			!!Result
		end

feature -- Generic conformance

	generated_id (final_mode : BOOLEAN) : INTEGER is

		do
			Result := Real_type
		end
feature

	make_basic_creation_byte_code (ba : BYTE_ARRAY) is

		do
			ba.append (Bc_float)
			ba.append_real (0.0)
		end 

end
