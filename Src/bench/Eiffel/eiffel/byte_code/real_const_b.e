class REAL_CONST_B 

inherit

	EXPR_B
		redefine
			print_register, make_byte_code,
			is_simple_expr
		end;
	
feature 

	value: STRING;
			-- Value to generate

	set_value (v: STRING) is
			-- Assign `v' to `value'.
		do
			value := v;
		end;

	type: TYPE_I is
			-- Float type
		once
			Result := Float_c_type;
		end;

	print_register is
			-- Print real value
		do
			generated_file.putstring ("(double) ");
			generated_file.putstring (value);
		end;

	used (r: REGISTRABLE): BOOLEAN is
			-- False
		do
		end;

	is_simple_expr: BOOLEAN is true;
			-- A constant is a simple expresion

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a real manifest constant
		do
			ba.append (Bc_float);
			ba.append_real (value.to_double);
		end;

end
