class BIN_LT_B 

inherit

	COMP_BINARY_B
		redefine
			generate_operator
		end;

feature

	generate_operator is
			-- Generate the operator
		do
			generated_file.putstring (" < ");
		end;

	operator_constant: CHARACTER is
			-- Byte code constant associated to current binary
			-- operation
		do
			Result := Bc_lt
		end;

end
