class BIN_XOR_B 

inherit

	BOOL_BINARY_B
		redefine
			is_commutative, print_register
		end;
	
feature 

	is_commutative: BOOLEAN is true;
			-- Operation is commutative.

	print_register is
			-- Print the expression
		do
			generated_file.putchar ('(');
			left.print_register;
			generated_file.putstring (" != ");
			right.print_register;
			generated_file.putchar (')');
		end;

	operator_constant: CHARACTER is
			-- Byte code constant associated to current binary
			-- operation
		do
			Result := Bc_xor
		end;

end
