class BIN_DIV_B 

inherit

	NUM_BINARY_B
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
			generated_file.putstring (" / ");
		end;

	generate_simple is
			-- Generate a simple assignment operation
		do
			generated_file.putstring (" /= ");
		end;

	operator_constant: CHARACTER is
			-- Byte code constant associated to current binary
			-- operation
		do
			Result := Bc_div
		end;

	is_built_in: BOOLEAN is
			-- Is the current binary operator a built-in one ?
		do
			Result := context.real_type (left.type).is_long;
		end;

end
