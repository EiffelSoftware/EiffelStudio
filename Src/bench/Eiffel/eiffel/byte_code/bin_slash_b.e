class BIN_SLASH_B 

inherit

	NUM_BINARY_B
		redefine
			generate_operator, is_simple,
			generate_simple
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
			Result := Bc_slash
		end;

end
