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
			buffer.putstring (" / ");
		end;

	generate_simple is
			-- Generate a simple assignment operation
		do
			buffer.putstring (" /= ");
		end;

	print_register is
			-- Print expression value
		do
			if left.type.is_long and then right.type.is_long then
				buffer.putstring (" ((EIF_DOUBLE)");
				left.print_register;
				generate_operator;
				right.print_register;
				buffer.putchar (')');
			else
				left.print_register;
				generate_operator;
				right.print_register;
			end;
		end;

end
