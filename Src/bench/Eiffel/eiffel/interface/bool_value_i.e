class BOOL_VALUE_I 

inherit

	VALUE_I
		redefine
			generate, is_boolean
		end;
	
feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := bool_val = other.bool_val
		end

feature 

	bool_val: BOOLEAN;
			-- Integer constant value

	set_bool_val (i: BOOLEAN) is
			-- Assign `i' to `bool_val'.
		do
			bool_val := i;
		end;

	is_boolean: BOOLEAN is True
			-- Is the constant value a boolean one ?

	valid_type (t: TYPE_A): BOOLEAN is
			-- Is the current value compatible with `t' ?
		do
			Result := t.is_boolean;
		end;

	generate (buffer: GENERATION_BUFFER) is
			-- Generate value in `file'.
		do
			if bool_val then
				buffer.putstring ("'\01'");
			else
				buffer.putstring ("'\0'");
			end;
		end;

	generate_il is
			-- Generate IL code for boolean constant value.
		do
			il_generator.put_boolean_constant (bool_val)	
		end

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

	dump: STRING is
		do
			Result := bool_val.out			
		end;

end
