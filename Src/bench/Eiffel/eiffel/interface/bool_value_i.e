class BOOL_VALUE_I 

inherit

	VALUE_I
		redefine
			generate, is_boolean
		end;
	
feature 

	bool_val: BOOLEAN;
			-- Integer constant value

	set_bool_val (i: BOOLEAN) is
			-- Assign `i' to `bool_val'.
		do
			bool_val := i;
		end;

	is_boolean: BOOLEAN is
			-- Is the constant value a boolean one ?
		do
			Result := True;
		end;

	valid_type (t: TYPE_A): BOOLEAN is
			-- Is the current value compatible with `t' ?
		do
			Result := t.is_boolean;
		end;

	generate (file: INDENT_FILE) is
			-- Generate value in `file'.
		do
			if bool_val then
				file.putstring ("'\01'");
			else
				file.putstring ("'\0'");
			end;
		end;

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a boolean constant value.
		do
			ba.append (Bc_bool);
			if bool_val then
				ba.append ('%/001/');
			else
				ba.append ('%U');
			end;
		end;

	vqmc: VQMC is
		do
			!VQMC1!Result;
		end;

	trace is
		do
			io.error.putbool (bool_val);
		end;

end
