class BIN_MINUS_B 

inherit

	NUM_BINARY_B
		redefine
			generate_operator, is_simple,
			generate_simple, generate_plus_plus,
			is_additive
		end;
	
feature 

	is_simple: BOOLEAN is
			-- Operation is usually simple (C can compact it in affectations)
		do
			Result := is_built_in;
		end;

	is_additive: BOOLEAN is true;
			-- Operation is additive (in the mathematical sense).

	
	generate_operator is
			-- Generate the operator
		do
			generated_file.putstring (" - ");
		end;

	
	generate_simple is
			-- Generate a simple assignment operation
		do
			generated_file.putstring (" -= ");
		end;

	generate_plus_plus is
			-- Generate a --
		do
			generated_file.putstring ("--");
		end;

	operator_constant: CHARACTER is
			-- Byte code constant associated to current binary
			-- operation
		do
			Result := Bc_minus
		end;

end
