class BIN_PLUS_B 

inherit

	NUM_BINARY_B
		rename
			Bc_plus as operator_constant
		redefine
			generate_operator, is_commutative,
			is_simple, generate_simple, generate_plus_plus,
			is_additive
		end;
	
feature 

	is_commutative: BOOLEAN is True
			-- Operation is commutative.

	is_simple: BOOLEAN is
			-- Operation is usually simple (C can compact it in affectations)
		do
			Result := is_built_in
		end

	is_additive: BOOLEAN is true;
			-- Operation is additive.

	generate_operator is
			-- Generate the operator
		do
			generated_file.putstring (gc_plus)
		end

	generate_simple is
			-- Generate a simple assignment operation
		do
			generated_file.putstring (" += ")
		end

	generate_plus_plus is
			-- Generate a ++ operation
		do
			generated_file.putstring ("++")
		end

end
