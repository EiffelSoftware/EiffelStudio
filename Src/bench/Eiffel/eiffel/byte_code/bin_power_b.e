class BIN_POWER_B 

inherit
	NUM_BINARY_B
		rename
			Bc_power as operator_constant
		redefine
			print_register
		end

feature

	print_register is
			-- Print expression value
		local
			left_type: TYPE_I;
			right_type: TYPE_I;
			result_type: TYPE_I;
			buf: GENERATION_BUFFER
		do
			buf := buffer
			buf.putstring ("(EIF_DOUBLE) math_power ((EIF_DOUBLE)");
			left.print_register;
			buf.putstring (",(EIF_DOUBLE)");
			right.print_register;
			buf.putchar (')');
		end;

end
