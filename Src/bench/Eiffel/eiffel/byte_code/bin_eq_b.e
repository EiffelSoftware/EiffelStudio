class BIN_EQ_B 

inherit

	BIN_EQUAL_B
		redefine
			enlarged, generate_operator
		end
	
feature

	generate_operator is
			-- Generate the operator
		do
			generated_file.putstring (" == ");
		end;

	generate_boolean_constant is
			-- Generate false constant
		do
			generated_file.putstring ("EIF_FALSE");
		end;

	enlarged: BIN_EQ_BL is
			-- Enlarge node
		do
			!!Result;
			Result.fill_from (Current);
		end;

feature -- Byte code generation

	operator_constant: CHARACTER is
			-- Byte code constant associated to current binary
			-- operation
		do
			Result := Bc_eq
		end;

    make_expanded_eq_test (ba: BYTE_ARRAY) is
            -- Make byte code for current expanded equality
		do
			ba.append (Bc_standard_equal);
		end;

    make_bit_eq_test (ba: BYTE_ARRAY) is
            -- Make byte code for current bit equality
		do
			ba.append (Bc_bit_standard_equal);
		end;

	obvious_operator_constant: CHARACTER is 
			-- Byte code operator associated to an obvious false
			-- comparison
		do
			Result := Bc_false_compar;
		end;

end
