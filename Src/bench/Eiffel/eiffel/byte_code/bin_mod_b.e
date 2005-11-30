class BIN_MOD_B

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
			v.process_bin_mod_b (Current)
		end

feature

	is_simple: BOOLEAN is
			-- Operation is usually simple (C can compact it in affectations)
		do
			Result := is_built_in;
		end;

	generate_operator is
			-- Generate the operator
		do
			buffer.put_string (" %% ");
		end;

	generate_simple is
			-- Generate a simple assignment operation
		do
			buffer.put_string (" %%= ");
		end;

	is_built_in: BOOLEAN is
			-- Is the current binary operator a built-in one ?
		local
			l_type: TYPE_I
		do
			l_type := context.real_type (type)
			Result := l_type.is_integer or l_type.is_natural
		end;

end
