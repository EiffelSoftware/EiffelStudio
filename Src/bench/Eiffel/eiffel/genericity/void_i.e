class VOID_I

inherit

	TYPE_I
		redefine
			is_void, same_as
		end;
	TYPE_C
		undefine
			is_void, is_bit
		end;
	SHARED_C_LEVEL;

feature

	level: INTEGER is
			-- Internal type value for generation
		do
			Result := C_void;
		end;

	c_type: TYPE_C is
			-- C type
		do
			Result := Current;
		end;

	dump (file: UNIX_FILE) is
			-- Debug purpose
		do
			file.putstring ("void");
		end;

	same_as (other: TYPE_I): BOOLEAN is
			-- Is `other' the equal to Current ?
		do
			Result := other.is_void;
		end;

	is_void: BOOLEAN is True;
			-- Type is a void one

	description: ATTR_DESC is
		do
		end;

	generate_cecil_value (f: UNIX_FILE) is
			-- Generate Cecil type value.
		do
		ensure then
			False
		end;

	generate (file: UNIX_FILE) is
			-- Generation
		do
			file.putstring ("void ");
		end;

	generate_cast (file: UNIX_FILE) is
			-- Generation of a cast
		do
			file.putstring ("(void) ");
		end;

	generate_access_cast (file: UNIX_FILE) is
			-- Generate access C cast in file `file'.
		do
		ensure then
			False
		end;

	generate_function_cast (file: UNIX_FILE) is
			-- Generate C function cast in file `file'.
		do
			file.putstring ("(void (*)()) ");
		end;

	generate_size (file: UNIX_FILE) is
			-- Generate size of C type
		do
			file.putstring ("sizeof(void)");
		end;

	hash_code: INTEGER is
			-- Hash code for current type
		once
			Result := Void_code;
		end;

	sk_value: INTEGER is
			-- Generate SK value associated to the current type.
		do
			Result := Sk_void;
		end;

	generate_union (file: UNIX_FILE) is
			-- Generate discriminant of C structure "item" associated
			-- to the current C type in `file'.
		do
		ensure then
			False
		end;

	generate_sk_value (file: UNIX_FILE) is
			-- Generate SK value associated to current C type in `file'.
		do
		ensure then
			False
		end;
end
