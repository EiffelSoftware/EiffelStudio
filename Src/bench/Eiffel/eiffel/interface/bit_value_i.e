class BIT_VALUE_I 

inherit

	VALUE_I
		redefine
			is_bit
		end;
	SHARED_WORKBENCH
	
feature 

	bit_val: STRING;
			-- Integer constant value

	set_bit_val (i: STRING) is
			-- Assign `i' to `bit_val'.
		do
			bit_val := i;
		end;

	is_bit: BOOLEAN is
			-- Is the current constant a bit one ?
		do
			Result := True;
		end;

	generate (file: INDENT_FILE) is
			-- Generate value in `file'.
		do
			file.putstring ("RTMB(%"");
			file.escape_string (bit_val);
			file.putstring ("%")");
		end;

	valid_type (t: TYPE_A): BOOLEAN is
			-- Is the current value compatible with `t' ?
		local
			class_type: BITS_A;
		do
			class_type ?= t;
			Result :=	class_type /= Void 
						and then
						bit_val.count <= class_type.base_type 
		end;

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a string constant value.
		do
			ba.append (Bc_bit);
			ba.append_bit (bit_val);
		end;

	vqmc: VQMC is
		do
			!VQMC6!Result;
		end;

	trace is
		do
			io.error.putstring (bit_val);
		end;

end
