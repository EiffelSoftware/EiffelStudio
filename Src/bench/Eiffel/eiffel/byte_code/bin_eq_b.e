class BIN_EQ_B 

inherit
	BIN_EQUAL_B
		rename
			Bc_eq as operator_constant,
			Bc_false_compar as obvious_operator_constant,
			il_eq as il_operator_constant
		redefine
			enlarged, generate_operator
		end
	
feature

	generate_operator is
			-- Generate the operator
		do
			buffer.putstring (" == ");
		end;

	generate_boolean_constant is
			-- Generate false constant
		do
			buffer.putstring ("EIF_FALSE");
		end;

	enlarged: BIN_EQ_BL is
			-- Enlarge node
		do
			!! Result;
			Result.fill_from (Current);
		end;

feature -- IL code generation

	generate_il_boolean_constant is
			-- Generate IL True constant
		do
			il_generator.put_boolean_constant (False)
		end

feature -- Byte code generation

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

end
