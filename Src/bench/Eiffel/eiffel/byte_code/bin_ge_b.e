class BIN_GE_B 

inherit

	COMP_BINARY_B
		rename
			Bc_ge as operator_constant,
			il_ge as il_operator_constant
		redefine
			generate_operator
		end;
	
feature

	generate_operator is
			-- Generate the operator
		do
			buffer.putstring (" >= ");
		end;

end
