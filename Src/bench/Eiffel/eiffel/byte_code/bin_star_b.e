class BIN_STAR_B

inherit
	NUM_BINARY_B
		redefine
			generate_operator, is_commutative,
			is_simple, generate_simple
		end

feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		do
			v.process_bin_star_b (Current)
		end

feature -- Status report

	is_commutative: BOOLEAN is true
			-- Operation is commutative.

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
