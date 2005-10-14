class BIN_AND_B 

inherit
	B_AND_THN_BL
		redefine
			is_and, process
		end
		
feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		do
			v.process_bin_and_b (Current)
		end
	
feature -- Status report

	is_and: BOOLEAN is True
			-- Current is a plain `and' expression.

end -- class BIN_AND_B
