class BIN_STAR_B 

inherit
	NUM_BINARY_B
		rename
			Bc_star as operator_constant,
			il_star as il_operator_constant
		redefine
			generate_operator, is_commutative,
			is_simple, generate_simple
		end;
	
feature 

	is_commutative: BOOLEAN is true;
			-- Operation is commutative.

	is_simple: BOOLEAN is
			-- Operation is usually simple (C can compact it in affectations)
		do
			Result := is_built_in;
		end;

	generate_operator is
			-- Generate the operator
		do
			buffer.putstring (gc_star);
		end;

	generate_simple is
			-- Generate a simple assignment operation
		do
			buffer.putstring (" *= ");
		end; -- generate_simple

end
