class BIN_LT_B

inherit

	COMP_BINARY_B
		rename
			il_lt as il_operator_constant
		redefine
			generate_operator
		end;

feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		do
			v.process_bin_lt_b (Current)
		end

feature

	generate_operator is
			-- Generate the operator
		do
			buffer.put_string (" < ");
		end;

end
