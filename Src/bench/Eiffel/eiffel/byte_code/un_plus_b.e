class UN_PLUS_B

inherit
	UNARY_B
		rename
			Il_uplus as il_operator_constant
		redefine
			generate_operator, is_built_in
		end;

feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		do
			v.process_un_plus_b (Current)
		end

feature

	generate_operator is
			-- Generate the unary operator
		do
		end;

	is_built_in: BOOLEAN is
			-- Is the current binary operator a built-in one ?
		do
			Result := context.real_type (expr.type).is_numeric;
		end;

end
