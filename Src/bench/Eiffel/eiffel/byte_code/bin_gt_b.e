class BIN_GT_B 

inherit

	COMP_BINARY_B
		rename
			Bc_gt as operator_constant
		redefine
			generate_operator
		end;
	
feature

	generate_operator is
			-- Generate the operator
		do
			buffer.putstring (" > ");
		end;

end
