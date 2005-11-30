class BIN_SLASH_B

inherit

	NUM_BINARY_B
		redefine
			generate_operator, is_simple,
			generate_simple, print_register
		end;

feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		do
			v.process_bin_slash_b (Current)
		end

feature -- Access

	is_simple: BOOLEAN is
			-- Operation is usually simple (C can compact it in affectations)
		do
			Result := is_built_in;
		end;

feature -- C code generation

	generate_operator is
			-- Generate the operator
		do
			buffer.put_string (" / ");
		end;

	generate_simple is
			-- Generate a simple assignment operation
		do
			buffer.put_string (" /= ");
		end;

	print_register is
			-- Print expression value
		local
			l_buf: like buffer
			l_type: TYPE_I
		do
			l_buf := buffer
			type.c_type.generate_cast (l_buf)

			l_buf.put_character ('(')
			l_type := context.real_type (left.type)
			l_type.c_type.generate_conversion_to_real_64 (l_buf)
			left.print_register
			l_buf.put_character (')')

			generate_operator

			l_buf.put_character (' ')
			l_type := context.real_type (right.type)
			l_type.c_type.generate_conversion_to_real_64 (l_buf)
			right.print_register
			l_buf.put_character (')')
			l_buf.put_character (')')
		end;

end
