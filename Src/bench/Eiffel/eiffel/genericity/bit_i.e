class BIT_I

inherit
	BASIC_I
		redefine
			is_bit, same_as,
			description, sk_value, hash_code,
			is_pointer, 
			metamorphose,
			generate_cid, make_gen_type_byte_code,
			generate_cid_array, generate_cid_init,
			generate_default_value, generate_expanded_creation, default_create,
			tuple_code, name
		end

create
	default_create

feature {NONE} -- Initialization

	default_create is
			-- Initialize new instance of BOOLEAN_I
		do
			make (system.bit_class.compiled_class.class_id)
		end

feature -- Status report

	tuple_code: INTEGER_8 is
			-- Tuple code for class type
		do
			Result := feature {SHARED_GEN_CONF_LEVEL}.reference_tuple_code
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

	name: STRING is
			-- Debug purpose
		do
			create Result.make (25)
			Result.append ("expanded BIT ")
			Result.append_integer (size)
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
			create Result
			Result.set_value (size)
		end

	c_string: STRING is "EIF_REFERENCE"
			-- String generated for the type.
		
	union_tag : STRING is "rarg"

	hash_code: INTEGER is
			-- Hash code for current type
		do
			Result := Other_code + size
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
				-- FIXME: Manu 08/06/2003: There is no limitation about the size
				-- of a BIT to 2^15, therefore when `size' is greater than 2^15
				-- we have a problem!!!!. It not only applies to current routine
				-- but to all the generic conformance stuff.
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
	
	generate_default_value (buffer : GENERATION_BUFFER) is
			-- Generate default value associated to current basic type.
		do
			buffer.putstring ("RTLB(")
			buffer.putint (size)
			buffer.putchar (')')
		end
	
	make_default_byte_code (ba: BYTE_ARRAY) is
			-- Generate default value of basic type on stack.
		do
			ba.append (Bc_create)
			ba.append (Bc_bit)
			ba.append_integer (size)
		end 

	generate_expanded_creation (byte_code: BYTE_CODE; reg: REGISTRABLE; workbench_mode: BOOLEAN) is
			-- Generate object associated to current.
		local
			l_buffer: GENERATION_BUFFER
		do
			l_buffer := byte_code.buffer
			reg.print_register
			l_buffer.putstring (" = RTLB(")
			l_buffer.putint (size)
			l_buffer.putstring (Gc_rparan_semi_c)
			l_buffer.new_line
		end
		
end
