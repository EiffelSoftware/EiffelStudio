class BIN_DIV_B 

inherit

	NUM_BINARY_B
		rename
			Bc_div as operator_constant,
			il_div as il_operator_constant
		redefine
			generate_operator, is_simple,
			generate_simple, is_built_in
		end;
	
feature 

	is_simple: BOOLEAN is
			-- Operation is usually simple (C can compact it in affectations)
		do
			Result := is_built_in;
		end;

	generate_operator is
			-- Generate the operator
		do
			buffer.putstring (" / ");
		end;

	generate_simple is
			-- Generate a simple assignment operation
		do
			buffer.putstring (" /= ");
		end;

	is_built_in: BOOLEAN is
			-- Is the current binary operator a built-in one ?
		do
			Result := context.real_type (left.type).is_long;
		end;

end
