class STRING_VALUE_I 

inherit

	VALUE_I
		redefine
			is_string, append_clickable_signature
		end;
	SHARED_WORKBENCH;
	CHARACTER_ROUTINES

feature 

	str_val: STRING;
			-- Integer constant value

	set_str_val (i: STRING) is
			-- Assign `i' to `str_val'.
		do
			str_val := i;
		end;

	is_string: BOOLEAN is
			-- Is the current constant a string one ?
		do
			Result := True;
		end;

	generate (file: INDENT_FILE) is
			-- Generate value in `file'.
		do
			file.putstring ("RTMS(%"");
			file.escape_string (str_val);
			file.putstring ("%")");
		end;

	valid_type (t: TYPE_A): BOOLEAN is
			-- Is the current value compatible with `t' ?
		local
			class_type: CL_TYPE_A;
		do
			class_type ?= t;
			Result := 	class_type /= Void
						and then
						class_type.base_type = System.string_id;
		end;

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a string constant value.
		do
			ba.append (Bc_string);
			ba.append_raw_string (str_val);
		end;

	vqmc: VQMC is
		do
			!VQMC5!Result;
		end;

	dump: STRING is
		do
			!! Result.make (str_val.count + 2);
			Result.extend ('"');
			Result.append (str_val);
			Result.extend ('"');
		end;

	append_clickable_signature (a_clickable: CLICK_WINDOW) is
		do
			a_clickable.put_char ('"');
			a_clickable.put_string (eiffel_string (str_val));
			a_clickable.put_char ('"');
		end

end
