class BIN_NE_B 

inherit
	BIN_EQUAL_B
		rename
			Bc_ne as operator_constant,
			Bc_true_compar as obvious_operator_constant,
			il_ne as il_operator_constant
		redefine
			generate_equal,
			generate_operator, enlarged,
			generate_bit_equal,
			generate_il_modifier_opcode
		end;
	
feature

	generate_operator is
			-- Generate the operator
		do
			buffer.putstring (" != ");
		end;

	generate_boolean_constant is
			-- Generate true constant
		do
			buffer.putstring ("EIF_TRUE");
		end;
	
	generate_equal is
			-- Generate non-equality.
		do
			buffer.putchar ('!');
			{BIN_EQUAL_B} Precursor;
		end;

	generate_bit_equal is
			-- Generate non-equality for bits.
		do
			buffer.putchar ('!');
			{BIN_EQUAL_B} Precursor;
		end;

	enlarged: EXPR_B is
			-- Enlarge node
		local
			l_left_val, l_right_val: VALUE_I
		do
			left := left.enlarged
			right := right.enlarged
			if context.final_mode then
				l_left_val := left.evaluate
				l_right_val := right.evaluate
				if
					l_left_val.same_type (l_right_val) and then
					l_left_val.is_equivalent (l_right_val)
				then
					create {BOOL_CONST_B} Result.make (False)
				else
						-- They are either not of the same type, or if they are they might
						-- have different values. For the moment, we simply proceed to
						-- traditional code generation (no optimization done, as you could
						-- have an INTEGER_8 constant of value 1, and an INTEGER constant of value 1
						-- and no comparison features at the moment enables us to tell they
						-- are the same value without computation.
					create {BIN_NE_BL} Result.make (left, right)
				end
			else
				create {BIN_NE_BL} Result.make (left, right)
			end
		end

feature -- IL code generation

	generate_il_boolean_constant is
			-- Generate IL True constant
		do
			il_generator.put_boolean_constant (True)
		end

	generate_il_modifier_opcode is
			-- Generate `not' operator.
		do
			il_generator.generate_unary_operator (Il_not)
		end
		
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
