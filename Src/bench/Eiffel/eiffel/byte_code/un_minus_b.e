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
		local
			l_buf: like buffer
		do
			l_buf := buffer
				-- Space is important here otherwise eweasel test ccomp042
				-- would fail like in `d := - - 3.5'.
			l_buf.put_character (' ');
			l_buf.put_character ('-');
		end;

	is_built_in: BOOLEAN is
			-- Is the current binary operator a built-in one ?
		do
			Result := context.real_type (expr.type).is_numeric;
		end;

end
