class STRING_VALUE_I 

inherit

	VALUE_I
		redefine
			is_string, append_signature,
			string_value
		end;
	SHARED_WORKBENCH;
	CHARACTER_ROUTINES

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := str_val.is_equal (other.str_val)
		end

feature 

	str_val: STRING;
			-- Integer constant value

	set_str_val (i: STRING) is
			-- Assign `i' to `str_val'.
		do
			str_val := i;
		end;

	is_string: BOOLEAN is True
			-- Is the current constant a string one ?

	generate (buffer: GENERATION_BUFFER) is
			-- Generate value in `buffer'.
		do
			buffer.putstring ("RTMS_EX(%"")
			buffer.escape_string (buffer,str_val)
			buffer.putchar('"')
			buffer.putchar(',')
			buffer.putint(str_val.count)
			buffer.putchar (')')
		end;

	valid_type (t: TYPE_A): BOOLEAN is
			-- Is the current value compatible with `t' ?
		local
			class_type: CL_TYPE_A;
		do
			class_type ?= t;
			Result := 	class_type /= Void
						and then class_type.base_class_id = System.string_id
		end;

	generate_il is
			-- Generate IL code for string constant value.
		do
			il_generator.put_manifest_string (str_val)
		end

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a string constant value.
		do
			ba.append (Bc_string);
			ba.append_integer (str_val.count)
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

	append_signature (st: STRUCTURED_TEXT) is
		do
			st.add_char ('"');
			st.add_string (eiffel_string (str_val));
			st.add_char ('"');
		end;

	string_value: STRING is
		do
			Result := eiffel_string (str_val)
		end

end
