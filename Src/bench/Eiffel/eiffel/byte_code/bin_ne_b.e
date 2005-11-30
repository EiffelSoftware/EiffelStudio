class BIN_NE_B

inherit
	BIN_EQUAL_B
		redefine
			generate_equal,
			generate_operator, enlarged,
			generate_bit_equal
		end;

feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		do
			v.process_bin_ne_b (Current)
		end

feature

	generate_operator is
			-- Generate the operator
		do
			buffer.put_string (" != ");
		end;

	generate_boolean_constant is
			-- Generate true constant
		do
			buffer.put_string ("EIF_TRUE");
		end;

	generate_equal is
			-- Generate non-equality.
		do
			buffer.put_character ('!');
			Precursor {BIN_EQUAL_B};
		end;

	generate_bit_equal is
			-- Generate non-equality for bits.
		do
			buffer.put_character ('!');
			Precursor {BIN_EQUAL_B};
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

end
