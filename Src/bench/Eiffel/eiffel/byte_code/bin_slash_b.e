class BIN_SLASH_B 

inherit

	NUM_BINARY_B
		rename
			Bc_slash as operator_constant
		redefine
			generate_operator, is_simple,
			generate_simple, print_register
		end;

feature 

	is_simple: BOOLEAN is
			-- Operation is usually simple (C can compact it in affectations)
		do
			Result := is_built_in;
		end;

	generate_operator is
			-- Generate the operator
		do
			generated_file.putstring (" / ");
		end;

	generate_simple is
			-- Generate a simple assignment operation
		do
			generated_file.putstring (" /= ");
		end;

	print_register is
			-- Print expression value
		do
			if left.type.is_long and then right.type.is_long then
				generated_file.putstring (" ((EIF_DOUBLE)");
				left.print_register;
				generate_operator;
				right.print_register;
				generated_file.putchar (')');
			else
				left.print_register;
				generate_operator;
				right.print_register;
			end;
		end;

end
