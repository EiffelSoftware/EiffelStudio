class BIN_STAR_B 

inherit
	NUM_BINARY_B
		rename
			Bc_star as operator_constant,
			il_star as il_operator_constant
		redefine
			generate_operator, is_commutative,
			is_simple, generate_simple,
			is_reverted
		end
	
feature -- Status report

	is_commutative: BOOLEAN is true
			-- Operation is commutative.

	is_reverted: BOOLEAN is true
			-- Has result of expression to be converted back to original type of expression
			-- so that result does not depend on implicit conversion performed by an underlying
			-- platform to a type with higher precision?

feature -- C code generation

	is_simple: BOOLEAN is
			-- Operation is usually simple (C can compact it in affectations)
		do
			Result := is_built_in
		end

	generate_operator is
			-- Generate the operator
		do
			buffer.put_string (gc_star)
		end

	generate_simple is
			-- Generate a simple assignment operation
		do
			buffer.put_string (" *= ")
		end

end
