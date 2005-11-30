indexing
	description: "+ operator"
	date: "$date: $"
	revision: "$revision: $"

class BIN_PLUS_B

inherit

	NUM_BINARY_B
		redefine
			generate_operator, is_commutative,
			is_simple, generate_simple, generate_plus_plus,
			is_additive
		end

feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		do
			v.process_bin_plus_b (Current)
		end

feature -- Status report

	is_commutative: BOOLEAN is True
			-- Operation is commutative.

	is_simple: BOOLEAN is
			-- Operation is usually simple (C can compact it in affectations)
		do
			Result := is_built_in
		end

	is_additive: BOOLEAN is true
			-- Operation is additive.

feature -- C code generaiton

	generate_operator is
			-- Generate the operator
		do
			buffer.put_string (gc_plus)
		end

	generate_simple is
			-- Generate a simple assignment operation
		do
			buffer.put_string (" += ")
		end

	generate_plus_plus is
			-- Generate a ++ operation
		do
			buffer.put_string ("++")
		end

end
