class BIN_NE_B 

inherit
	BIN_EQUAL_B
		rename
			Bc_ne as operator_constant,
			Bc_true_compar as obvious_operator_constant
		redefine
			generate_equal,
			generate_operator, enlarged,
			generate_bit_equal
		end;
	
feature

	generate_operator is
			-- Generate the operator
		do
			generated_file.putstring (" != ");
		end;

	generate_boolean_constant is
			-- Generate true constant
		do
			generated_file.putstring ("EIF_TRUE");
		end;
	
	generate_equal is
			-- Generate non-equality.
		do
			generated_file.putchar ('!');
			{BIN_EQUAL_B} Precursor;
		end;

	generate_bit_equal is
			-- Generate non-equality for bits.
		do
			generated_file.putchar ('!');
			{BIN_EQUAL_B} Precursor;
		end;

	enlarged: BIN_NE_BL is
			-- Enlarge node
		do
			!!Result;
			Result.fill_from (Current);
		end;

feature -- Byte code generation
	
    make_expanded_eq_test (ba: BYTE_ARRAY) is
            -- Make byte code for current expanded equality
        do
            ba.append (Bc_standard_equal);
			ba.append (Bc_not);
        end;
 
    make_bit_eq_test (ba: BYTE_ARRAY) is
            -- Make byte code for current bit equality
        do
            ba.append (Bc_bit_standard_equal);
			ba.append (Bc_not);
        end;
 
end
