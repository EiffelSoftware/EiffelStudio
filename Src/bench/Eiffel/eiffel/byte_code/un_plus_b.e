class UN_PLUS_B 

inherit

	UNARY_B
		redefine
			generate_operator, is_built_in
		end;
	
feature

	generate_operator is
			-- Generate the unary operator
		do
		end;

	operator_constant: CHARACTER is
			-- Byte code constant associated to current binary
			-- operation
		do
			Result := Bc_uplus;
		end;

	is_built_in: BOOLEAN is
			-- Is the current binary operator a built-in one ?
		do
			Result := context.real_type (expr.type).is_numeric;
		end;

end
