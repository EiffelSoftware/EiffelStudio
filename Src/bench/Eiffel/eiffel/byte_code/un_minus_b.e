class UN_MINUS_B 

inherit

	UNARY_B
		rename
			Bc_uminus as operator_constant,
			Il_uminus as il_operator_constant
		redefine
			generate_operator, is_built_in
		end;
	
feature

	generate_operator is
			-- Generate the unary operator
		do
			buffer.putchar ('-');
		end;

	is_built_in: BOOLEAN is
			-- Is the current binary operator a built-in one ?
		do
			Result := context.real_type (expr.type).is_numeric;
		end;

end
