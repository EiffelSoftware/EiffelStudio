class BIT_I

inherit
	BASIC_I
		redefine
			dump, is_bit, same_as,
			description, sk_value, generate_cecil_value, hash_code,
			is_pointer, 
			metamorphose, append_signature,
			generate_cid, generated_id, make_gen_type_byte_code,
			generate_cid_array, generate_cid_init,
			generate_basic_creation
		end

feature

	level: INTEGER is
			-- Internal code for generation
		do
			Result := C_ref
		end; -- level

	size: INTEGER
			-- Bit size

	set_size (i: INTEGER) is
			-- Assign `i' to `size'.
		do
			size := i
		end

	is_bit: BOOLEAN is True
			-- Is the type a long type ?

	is_pointer: BOOLEAN is True
			-- Is the type a pointer type ?

	append_signature (st: STRUCTURED_TEXT) is
		do
			st.add_string ("BIT ")
			st.add_int (size)
		end

	dump (buffer: GENERATION_BUFFER) is
			-- Debug purpose
		do
			buffer.putstring ("BIT ")
			buffer.putint (size)
		end

	same_as (other: TYPE_I): BOOLEAN is
			-- Is `other' the equal to Current ?
		local
			other_bit: BIT_I
		do
			if other.is_bit then
				other_bit ?= other
				Result := other_bit /= Void and then size = other_bit.size
			end
		end

	description: BITS_DESC is
			-- Type description for skeleton
		do
			!!Result
			Result.set_value (size)
		end

	generate_cecil_value (buffer: GENERATION_BUFFER) is
			-- Generate Cecil type value.
		do
			buffer.putstring ("SK_BIT + (uint32) ")
			buffer.putint (size)
		end

	c_string: STRING is "EIF_REFERENCE"
			-- String generated for the type.

	union_tag : STRING is "rarg"

	separate_get_macro: STRING is "not_implemented"
			-- String generated to access the argument to a separate call

	separate_send_macro: STRING is "not_implemented"
			-- String generated to return the result of a separate call

	hash_code: INTEGER is
			-- Hash code for current type
		do
			Result := Other_code + size
		end

	associated_reference: CLASS_TYPE is
			-- Reference class associated with simple type
		do
			Result := system.bit_class.compiled_class.types.first
		end

	sk_value: INTEGER is
			-- Generate SK value associated to the current type.
		do
			Result := Sk_bit + size
		end

	metamorphose
	(reg, value: REGISTRABLE; buffer: GENERATION_BUFFER; workbench_mode: BOOLEAN) is
			-- Generate the metamorphism from simple type to reference and
			-- put result in register `reg'. The value of the basic type is
			-- held in `value'. 
		do
			reg.print_register
			buffer.putstring (" = ")
			value.print_register
		end

	generate_union (buffer: GENERATION_BUFFER) is
			-- Generate discriminant of C structure "item" associated
			-- to the current C type in `buffer'.
		do
			 buffer.putstring ("it_bit")
		end

	generate_sk_value (buffer: GENERATION_BUFFER) is
			-- Generate SK value associated to current C type in `buffer'.
		do
			buffer.putstring ("SK_BIT + (uint32) ")
			buffer.putint (size)
		end

	type_a: BITS_A is
		do
			create Result.make (size)
		end

feature -- Generic conformance

	generated_id (final_mode : BOOLEAN) : INTEGER is
		do
			Result := Bit_type
		end

	generate_cid (buffer : GENERATION_BUFFER; final_mode, use_info : BOOLEAN) is

		do
			buffer.putint (generated_id (final_mode))
			buffer.putstring (", ")
			buffer.putint (size)
			buffer.putstring (", ")
		end

	make_gen_type_byte_code (ba : BYTE_ARRAY; use_info : BOOLEAN) is
		do
			ba.append_short_integer (generated_id (False))
			ba.append_short_integer (size)
		end

	generate_cid_array (buffer : GENERATION_BUFFER; 
						final_mode, use_info : BOOLEAN; idx_cnt : COUNTER) is
		local
			dummy : INTEGER
		do
			generate_cid (buffer, final_mode, use_info)

			-- Increment counter twice
			dummy := idx_cnt.next
			dummy := idx_cnt.next
		end

	generate_cid_init (buffer : GENERATION_BUFFER; 
					   final_mode, use_info : BOOLEAN; idx_cnt : COUNTER) is
		local
			dummy : INTEGER
		do
			-- Only increment counter twice.
			dummy := idx_cnt.next
			dummy := idx_cnt.next
		end

feature

	generate_basic_creation (buffer : GENERATION_BUFFER) is

		do
			buffer.putstring ("RTLB(")
			buffer.putint (size)
			buffer.putchar (')')
		end
	
	make_basic_creation_byte_code (ba : BYTE_ARRAY) is

		do
			ba.append_integer (size)
		end 

end
