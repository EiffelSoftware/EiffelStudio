class INT_CONST_B 

inherit

	EXPR_B
		redefine
			print_register, make_byte_code,
			is_simple_expr, is_predefined, generate_il
		end;
	
feature 

	value: INTEGER;
			-- Character value

	set_value (v: INTEGER) is
			-- Assign `v' to `value'.
		do
			value := v;
		end;

	type: TYPE_I is
			-- Integer type
		once
			Result := Long_c_type;
		end;

	print_register is
			-- Print integer constant
			--| The '()' are present for the case where int_val=INT32_MIN,
			--| ie: if we printed -INT32_MIN in Eiffel, we would get --INT32_MIN in C.
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer
			buf.putchar ('(')
			buf.putint (value)
			buf.putstring ("L)")
		end;

	used (r: REGISTRABLE): BOOLEAN is
			-- False
		do
		end; -- used

	is_simple_expr: BOOLEAN is true;
			-- A constant is a simple expression

	is_predefined: BOOLEAN is true
			-- A constant is a predefined structure.


feature -- IL code generation

	generate_il is
			-- Generate IL code for integer constant.
		do
			il_generator.put_integer_32_constant (value)
		end

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for an integer constant.
		do
			ba.append (Bc_int);
			ba.append_integer (value);
		end; -- make_byte_code

end
