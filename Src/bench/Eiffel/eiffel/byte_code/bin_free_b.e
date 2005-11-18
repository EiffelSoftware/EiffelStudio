class BIN_FREE_B

inherit

	BINARY_B

feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		do
			v.process_bin_free_b (Current)
		end

feature -- Status

	is_built_in: BOOLEAN is
			-- Is the current binary operator a built-in one ?
		do
			-- Do nothing
		end

feature -- IL code generation

	il_operator_constant: INTEGER is
			-- IL code constant associated to current binary
			-- operation
		do
			check False end
		end

end
