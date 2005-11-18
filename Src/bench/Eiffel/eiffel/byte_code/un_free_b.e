class UN_FREE_B

inherit

	UNARY_B


feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		do
			v.process_un_free_b (Current)
		end

feature -- IL code generation

	il_operator_constant: INTEGER is
		do
			check False end
		end

end
