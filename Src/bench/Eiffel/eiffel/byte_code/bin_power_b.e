class BIN_POWER_B 

inherit

	NUM_BINARY_B
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
		do
			generated_file.putstring ("(double) math_power((double)");
			left.print_register;
			generated_file.putstring (",(double)");
			right.print_register;
			generated_file.putchar (')');
		end;

	operator_constant: CHARACTER is
			-- Byte code constant associated to current binary
			-- operation
		do
			Result := Bc_power
		end;

end
