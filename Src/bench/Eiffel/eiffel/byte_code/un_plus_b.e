class UN_PLUS_B 

inherit
	UNARY_B
		rename
			Bc_uplus as operator_constant,
			Il_uplus as il_operator_constant
		redefine
			generate_operator, is_built_in
		end;
	
feature

	generate_operator is
			-- Generate the unary operator
		do
		end;

	is_built_in: BOOLEAN is
			-- Is the current binary operator a built-in one ?
		do
			Result := context.real_type (expr.type).is_numeric;
		end;

end
