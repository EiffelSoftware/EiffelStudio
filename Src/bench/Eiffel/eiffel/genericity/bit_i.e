class BIT_I

inherit
	BASIC_I
		redefine
			dump, is_bit, same_as,
			description, sk_value, generate_cecil_value, hash_code,
			is_pointer, 
			metamorphose, append_signature,
			gen_type_string, generated_id, make_gen_type_byte_code
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

	dump (file: FILE) is
			-- Debug purpose
		do
			file.putstring ("BIT ")
			file.putint (size)
		end

	same_as (other: TYPE_I): BOOLEAN is
			-- Is `other' the equal to Current ?
		local
			other_bit: BIT_I
		do
			other_bit ?= other
			Result := 	other_bit /= Void
						and then
						size = other_bit.size
		end

	description: BITS_DESC is
			-- Type description for skeleton
		do
			!!Result
			Result.set_value (size)
		end

	generate_cecil_value (file: INDENT_FILE) is
			-- Generate Cecil type value.
		do
			file.putstring ("SK_BIT + (uint32) ")
			file.putint (size)
		end

	c_string: STRING is "char *"
			-- String generated for the type.

	separate_get_macro: STRING is "not_implemented"
			-- String generated to access the argument to a separate call

	separate_send_macro: STRING is "not_implemented"
			-- String generated to return the result of a separate call

	generate (file: INDENT_FILE) is
			-- Generate C type in file `file'.
		do
			file.putstring ("char *")
		end

	generate_cast (file: INDENT_FILE) is
			-- Generate C cast in file `file'.
		do
			file.putstring ("(char *) ")
		end

	generate_access_cast (file: INDENT_FILE) is
			-- Generate access C cast in file `file'.
		do
			file.putstring ("(char **) ")
		end

	generate_size (file: INDENT_FILE) is
			-- Generate size of C type
		do
			file.putstring ("sizeof(EIF_REFERENCE)")
		end

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
	(reg, value: REGISTRABLE; file: INDENT_FILE; workbench_mode: BOOLEAN) is
			-- Generate the metamorphism from simple type to reference and
			-- put result in register `reg'. The value of the basic type is
			-- held in `value'. 
		do
			reg.print_register
			file.putstring (" = ")
			value.print_register
		end

	generate_union (file: INDENT_FILE) is
			-- Generate discriminant of C structure "item" associated
			-- to the current C type in `file'.
		do
			 file.putstring ("it_bit")
		end

	generate_sk_value (file: INDENT_FILE) is
			-- Generate SK value associated to current C type in `file'.
		do
			file.putstring ("SK_BIT + (uint32) ")
			file.putint (size)
		end

	type_a: BITS_A is
		do
			!!Result
			Result.set_bit_count (size)
		end

feature -- Generic conformance

	generated_id (final_mode : BOOLEAN) : INTEGER is

		do
			Result := -7        -- Code for BITs
		end

	gen_type_string (final_mode : BOOLEAN) : STRING is

		do
			!!Result.make (0)
			Result.append_integer (generated_id (final_mode))
			Result.append (", ")
			Result.append_integer (size)
			Result.append (", ")
		end

	make_gen_type_byte_code (ba : BYTE_ARRAY) is

		do
			ba.append_short_integer (generated_id (False))
			ba.append_short_integer (size)
		end

end
