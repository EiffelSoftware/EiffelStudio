-- Actually DOUBLE_VALUE_I

class REAL_VALUE_I 

inherit

	VALUE_I
		redefine
			generate, is_double
		end
	
feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := real_val.is_equal (other.real_val)
		end

feature 

	real_val: STRING;
			-- Integer constant value

	set_real_val (i: STRING) is
			-- Assign `i' to `real_val'.
			-- Remove the '_' signs in the real number.
		do
			real_val := i;
			real_val.replace_substring_all ("_","")
		end;

	is_double: BOOLEAN is
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
			file.putstring (real_val);
		end;

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a real constant value
		do
			ba.append (Bc_double);
			ba.append_real (real_val.to_double);
		end;

	vqmc: VQMC is
		do
			!VQMC4!Result;
		end;

	dump: STRING is
		do
			Result := real_val
		end;

end
