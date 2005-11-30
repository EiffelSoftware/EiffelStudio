class UN_FREE_B

inherit
	UNARY_B


feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		do
			v.process_un_free_b (Current)
		end

end
