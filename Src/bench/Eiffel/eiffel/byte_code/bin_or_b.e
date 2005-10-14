-- The "or" is optimized as an "or else"

class BIN_OR_B 

inherit
	B_OR_ELSE_B
		redefine
			is_or, process
		end
		
feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		do
			v.process_bin_or_b (Current)
		end
	
feature -- Status report

	is_or: BOOLEAN is True
			-- Current is a plain `or' expression.

end
