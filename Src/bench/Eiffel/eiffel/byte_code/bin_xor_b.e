class BIN_XOR_B 

inherit

	BOOL_BINARY_B
		rename
			Bc_xor as operator_constant
		redefine
			is_commutative, print_register
		end;
	
feature 

	is_commutative: BOOLEAN is True;
			-- Operation is commutative.

	print_register is
			-- Print the expression
		do
			generated_file.putstring ("((");
			left.print_register;
			generated_file.putstring (") != (");
			right.print_register;
			generated_file.putstring ("))");
		end;

end
