class INT_VALUE_I 

inherit

	VALUE_I
		redefine
			generate, is_integer, is_equal
		end
	
feature 

	int_val: INTEGER;
			-- Integer constant value

	set_int_val (i: INTEGER) is
			-- Assign `i' to `int_val'.
		do
			int_val := i;
		end;

	is_integer: BOOLEAN is
			-- Is the current constant a boolean one ?
		do
			Result := True;
		end;

	valid_type (t: TYPE_A): BOOLEAN is
			-- Is the current value compatible with `t' ?
		do
			Result := t.is_integer;
		end;

	is_equal (other: INT_VALUE_I): BOOLEAN is
			-- Is `other' equal to Current ?
		do
			Result := int_val = other.int_val;
		end;

	generate (file: INDENT_FILE) is
			-- Generate value in `file'.
		do
			file.putint (int_val);
			file.putchar ('L');
		end;

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for an integer constant value.
		do
			ba.append (Bc_int);
			ba.append_integer (int_val);
		end;

	vqmc: VQMC is
		do
			!VQMC3!Result;
		end;

	trace is
		do
			io.error.putint (int_val);
		end;

end
