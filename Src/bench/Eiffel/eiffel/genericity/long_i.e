class LONG_I

inherit
	BASIC_I
		redefine
			dump,
			is_long,
			is_numeric,
			same_as,
			description, sk_value, generate_cecil_value, hash_code,
			generate_byte_code_cast, generated_id, heaviest, typecode
		end

	BYTE_CONST

create
	make

feature -- Initialization

	make (n: INTEGER) is
			-- Create instance of LONG_I represented on `n' bits.
		require
			valid_n: n = 8 or n = 16 or n = 32 or n = 64
		do
			size := n
		ensure
			size_set: size = n
		end

feature -- Access

	size: INTEGER
			-- Current is stored on `size' bits.

	level: INTEGER is
			-- Internal code for generation
		do
			inspect size
			when 8 then Result := C_int8
			when 16 then Result := C_int16
			when 32 then Result := C_int32
			when 64 then Result := C_int64
			end
		end

	typecode: INTEGER is
			-- Typecode for TUPLE element.
		do
			inspect size
			when 8 then Result := feature {SHARED_TYPECODE}.integer_8_code
			when 16 then Result := feature {SHARED_TYPECODE}.integer_16_code
			when 32 then Result := feature {SHARED_TYPECODE}.integer_code
			when 64 then Result := feature {SHARED_TYPECODE}.integer_64_code
			end	
		end

	generate_byte_code_cast (ba: BYTE_ARRAY) is
			-- Code for interpreter cast
		do
			ba.append (Bc_cast_long)
			ba.append_integer (size)
		end

	is_long: BOOLEAN is True
			-- Is the type a long type ?

	is_numeric: BOOLEAN is True
			-- Is the type a numeric one ?

	heaviest (other : TYPE_I) : TYPE_I is
		do
			Result := other
		end

	dump (buffer: GENERATION_BUFFER) is
			-- Debug purpose
		do
			buffer.putstring ("EIF_INTEGER_")
			buffer.putint (size)
		end

	same_as (other: TYPE_I): BOOLEAN is
			-- Is `other' the equal to Current ?
		local
			o: like Current
		do
			if other.is_long then
				o ?= other
				Result := size = o.size
			end
		end

	description: INTEGER_DESC is
			-- Type description for skeleton
		do
			create Result.make (size)
		end

	generate_cecil_value (buffer: GENERATION_BUFFER) is
			-- Generate Cecil type value.
		do
			buffer.putstring ("SK_INT")
			buffer.putint (size)
		end

	c_string: STRING is
			-- String generated for the type.
		do
			inspect size
			when 8 then Result := String_integer_8
			when 16 then Result := String_integer_16
			when 32 then Result := String_integer_32
			when 64 then Result := String_integer_64
			end
		end

	c_string_id: INTEGER is
			-- String generated for the type.
		do
			inspect size
			when 8 then Result := String_integer_8_id
			when 16 then Result := String_integer_16_id
			when 32 then Result := String_integer_32_id
			when 64 then Result := String_integer_64_id
			end
		end

	union_tag: STRING is
			-- Union name to specify type for Agents
		do
			inspect size
			when 8 then Result := Union_tag_8
			when 16 then Result := Union_tag_16
			when 32 then Result := Union_tag_32
			when 64 then Result := Union_tag_64
			end
		end

	separate_get_macro: STRING is
			-- String generated to access the argument to a separate call
		do
			create Result.make (7)
			Result.append ("CURGI")
			Result.append_integer (size)
		end

	separate_send_macro: STRING is
			-- String generated to return the result of a separate call
		do
			create Result.make (9)
			Result.append ("CURSQRI")
			Result.append_integer (size)
		end

	hash_code: INTEGER is
			-- Hash code for current type
		do
			inspect size
			when 8 then Result := Integer8_code
			when 16 then Result := Integer16_code
			when 32 then Result := Integer32_code
			when 64 then Result := Integer64_code
			end
		end

	associated_reference: CLASS_TYPE is
			-- Reference class associated with simple type
		do
			inspect size
			when 8 then Result := system.integer_8_ref_class.compiled_class.types.first
			when 16 then Result := system.integer_16_ref_class.compiled_class.types.first
			when 32 then Result := system.integer_32_ref_class.compiled_class.types.first
			when 64 then Result := system.integer_64_ref_class.compiled_class.types.first
			end
		end

	sk_value: INTEGER is
			-- Generate SK value associated to the current type.
		do
			inspect size
			when 8 then Result := Sk_int8
			when 16 then Result := Sk_int16
			when 32 then Result := Sk_int32
			when 64 then Result := Sk_int64
			end
		end

	generate_union (buffer: GENERATION_BUFFER) is
			-- Generate discriminant of C structure "item" associated
			-- to the current C type in `buffer'.
		do
			buffer.putstring ("it_int")
			buffer.putint (size)
		end

	generate_sk_value (buffer: GENERATION_BUFFER) is
			-- Generate SK value associated to current C type in `buffer'.
		do
			buffer.putstring ("SK_INT")
			buffer.putint (size)
		end

	type_a: INTEGER_A is
		do
			create Result.make (size)
		end

feature -- Generic conformance

	generated_id (final_mode : BOOLEAN) : INTEGER is

		do
			inspect size
			when 8 then Result := Integer_8_type
			when 16 then Result := Integer_16_type
			when 32 then Result := Integer_32_type
			when 64 then Result := Integer_64_type
			end
		end

feature

	make_basic_creation_byte_code (ba : BYTE_ARRAY) is

		do
			inspect size
			when 8 then ba.append (Bc_int8)
			when 16 then ba.append (Bc_int16)
			when 32 then ba.append (Bc_int32)
			when 64 then ba.append (Bc_int64)
			end
			ba.append_integer (0)
		end 

feature {NONE} -- Constants for generation

	String_integer_8: STRING is "EIF_INTEGER_8"
	String_integer_16: STRING is "EIF_INTEGER_16"
	String_integer_32: STRING is "EIF_INTEGER_32"
	String_integer_64: STRING is "EIF_INTEGER_64"

	String_integer_8_id: INTEGER is
		once
			Result := Names_heap.eif_integer_8_name_id
		end
		
	String_integer_16_id: INTEGER is
		once
			Result := Names_heap.eif_integer_16_name_id
		end

	String_integer_32_id: INTEGER is
		once
			Result := Names_heap.eif_integer_32_name_id
		end

	String_integer_64_id: INTEGER is
		once
			Result := Names_heap.eif_integer_64_name_id
		end

	Union_tag_8: STRING is "i8arg"
	Union_tag_16: STRING is "i16arg"
	Union_tag_32: STRING is "i32arg"
	Union_tag_64: STRING is "i64arg"

invariant

	correct_size: size = 8 or size = 16 or size = 32 or size = 64

end
