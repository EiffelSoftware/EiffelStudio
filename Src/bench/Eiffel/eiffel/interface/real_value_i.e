class REAL_VALUE_I 

inherit

	VALUE_I
		redefine
			generate, is_real
		end
	
feature 

	real_val: STRING;
			-- Integer constant value

	set_real_val (i: STRING) is
			-- Assign `i' to `real_val'.
		do
			real_val := i;
		end;

	is_real: BOOLEAN is
			-- Is the current constant a real one ?
		do
			Result := True;
		end;

	valid_type (t: TYPE_A): BOOLEAN is
			-- Is the current value compatible with `t' ?
		do
			Result := t.is_real or t.is_double;
		end;

	generate (file: INDENT_FILE) is
			-- Generate value in `file'.
		do
			file.putstring ("(double) ");
			file.putstring (real_val);
		end;

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a real constant value
		do
			ba.append (Bc_float);
            ba.append_real (real_val.to_double);
		end;

end
