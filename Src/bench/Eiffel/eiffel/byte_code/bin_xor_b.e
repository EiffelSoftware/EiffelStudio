class BIN_XOR_B 

inherit

	BOOL_BINARY_B
		rename
			Bc_xor as operator_constant,
			il_xor as il_operator_constant
		redefine
			is_commutative, print_register
		end;
	
feature 

	is_commutative: BOOLEAN is True;
			-- Operation is commutative.

	print_register is
			-- Print the expression
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer
			buf.putstring ("((");
			left.print_register;
			buf.putstring (") != (");
			right.print_register;
			buf.putstring ("))");
		end;

end
