class BIT_I

inherit

	BASIC_I
		redefine
			dump, is_bit, same_as,
			description, sk_value, generate_cecil_value, hash_code,
			is_pointer, 
			metamorphose
		end;

feature

	level: INTEGER is
			-- Internal code for generation
		do
			Result := C_ref
		end; -- level

	size: INTEGER;
			-- Bit size

	set_size (i: INTEGER) is
			-- Assign `i' to `size'.
		do
			size := i;
		end;

	is_bit: BOOLEAN is true;
			-- Is the type a long type ?

	is_pointer: BOOLEAN is true;
			-- Is the type a pointer type ?

	dump (file: UNIX_FILE) is
			-- Debug purpose
		do
			file.putstring ("BIT ");
			file.putint (size);
		end;

	same_as (other: TYPE_I): BOOLEAN is
			-- Is `other' the equal to Current ?
		local
			other_bit: BIT_I;
		do
			other_bit ?= other;
			Result := 	other_bit /= Void
						and then
						size = other_bit.size
		end;

	description: BITS_DESC is
			-- Type description for skeleton
		do
			!!Result;
			Result.set_value (size);
		end;

	generate_cecil_value (file: UNIX_FILE) is
			-- Generate Cecil type value.
		do
			file.putstring ("SK_BIT + (uint32) ");
			file.putint (size);
		end;

	generate (file: UNIX_FILE) is
			-- Generate C type in file `file'.
		do
			file.putstring ("char *");
		end;

	generate_cast (file: UNIX_FILE) is
			-- Generate C cast in file `file'.
		do
			file.putstring ("(char *) ");
		end;

	generate_access_cast (file: UNIX_FILE) is
			-- Generate access C cast in file `file'.
		do
			file.putstring ("(char **) ");
		end;

	generate_function_cast (file: UNIX_FILE) is
			-- Generate C function cast in file `file'.
		do
			file.putstring ("(char *(*)()) ");
		end;

	generate_size (file: UNIX_FILE) is
			-- Generate size of C type
		do
			file.putstring ("BITOFF(");
			file.putint (size);
			file.putstring (")");
		end;

	hash_code: INTEGER is
			-- Hash code for current type
		do
			Result := Other_code + size;
		end;

	associated_reference: CLASS_TYPE is
			-- Reference class associated with simple type
		do
			Result := system.bit_class.compiled_class.types.first;
		end;

	sk_value: INTEGER is
			-- Generate SK value associated to the current type.
		do
--			Result := Sk_bit + size;
			Result := 671088640 + size;
		end;

	metamorphose
	(reg, value: REGISTRABLE; file: UNIX_FILE; workbench_mode: BOOLEAN) is
			-- Generate the metamorphism from simple type to reference and
		   	-- put result in register `reg'. The value of the basic type is
		   	-- held in `value'. 
		do
			reg.print_register;
			file.putstring (" = ");
			value.print_register;
		end;

	generate_union (file: UNIX_FILE) is
			-- Generate discriminant of C structure "item" associated
			-- to the current C type in `file'.
		do
			 file.putstring ("it_bit")
		end;

	generate_sk_value (file: UNIX_FILE) is
			-- Generate SK value associated to current C type in `file'.
		do
			file.putstring ("SK_BIT + ");
			file.putint (size);
		end;

end
