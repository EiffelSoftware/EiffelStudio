class BIN_SLASH_B 

inherit

	NUM_BINARY_B
		rename
			Bc_slash as operator_constant,
			il_slash as il_operator_constant
		redefine
			generate_operator, is_simple,
			generate_simple, print_register,
			generate_standard_il
		end;

feature -- Access

	is_simple: BOOLEAN is
			-- Operation is usually simple (C can compact it in affectations)
		do
			Result := is_built_in;
		end;

feature -- IL code generation

	generate_standard_il is
			-- Generate standard IL code for binary expression.
		do
			left.generate_il
			il_generator.convert_to_double
			right.generate_il
			il_generator.convert_to_double
			il_generator.generate_binary_operator (il_operator_constant)
		end

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
