indexing
	description: "integer // operator"
	date: "$date: $"
	revision: "$revision: $"

class BIN_DIV_B

inherit

	NUM_BINARY_B
		redefine
			generate_operator, is_simple,
			generate_simple, is_built_in
		end

feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		do
			v.process_bin_div_b (Current)
		end

feature -- Status report

	is_simple: BOOLEAN is
			-- Operation is usually simple (C can compact it in affectations)
		do
			Result := is_built_in
		end

	is_built_in: BOOLEAN is
			-- Is the current binary operator a built-in one?
		local
			l_type: TYPE_I
		do
			l_type := context.real_type (left.type)
			Result := l_type.is_integer or l_type.is_natural
		end

feature -- C code generation

	generate_operator is
			-- Generate the operator
		do
			buffer.put_string (" / ")
		end

	generate_simple is
			-- Generate a simple assignment operation
		do
			buffer.put_string (" /= ")
		end

end
