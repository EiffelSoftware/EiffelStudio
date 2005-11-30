class UN_MINUS_B

inherit

	UNARY_B
		redefine
			generate_operator, is_built_in
		end

feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		do
			v.process_un_minus_b (Current)
		end

feature

	generate_operator is
			-- Generate the unary operator
		do
			buffer.put_character ('-')
		end

	is_built_in: BOOLEAN is
			-- Is the current binary operator a built-in one ?
		do
			Result := context.real_type (expr.type).is_numeric
		end

end
