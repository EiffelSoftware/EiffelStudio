class FLOAT_VALUE_I 

inherit

	VALUE_I
		redefine
			generate, is_real
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
		do
			real_val := i;
		end;

	is_real: BOOLEAN is True
			-- Is the current constant a real one ?

	valid_type (t: TYPE_A): BOOLEAN is
			-- Is the current value compatible with `t' ?
		do
			Result := t.is_real or t.is_double;
		end;

	generate (buffer: GENERATION_BUFFER) is
			-- Generate value in `buffer'.
		do
			buffer.putstring (real_val);
		end;

	generate_il is
			-- Generate IL code for real constant value.
		do
			il_generator.put_double_constant (real_val.to_double)	
		end

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a real constant value
		do
			ba.append (Bc_float);
				--|Note: It is actually a double which
				--|is appended to the byte code despite
				--|the name `append_real'
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
