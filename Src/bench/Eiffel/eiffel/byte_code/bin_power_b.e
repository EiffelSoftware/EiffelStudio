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
			left_type := left.type;
			right_type := right.type;
			if left_type.is_long then
				result_type := right_type
			elseif left_type.is_float and then
				right_type.is_double
			then
				result_type := right_type
			else
				result_type := left_type
			end;
			if result_type.is_long then
				generated_file.putstring ("(long) math_power((double)");
			elseif result_type.is_float then
				generated_file.putstring ("(float) math_power((double)");
			else
				generated_file.putstring ("(double) math_power((double)");
			end;
			left.print_register;
			generated_file.putstring (",(double)");
			right.print_register;
			generated_file.putstring (")");
		end;

	operator_constant: CHARACTER is
			-- Byte code constant associated to current binary
			-- operation
		do
			Result := Bc_power
		end;

end
