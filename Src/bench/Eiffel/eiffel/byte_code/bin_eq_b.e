class BIN_EQ_B

inherit
	BIN_EQUAL_B
		rename
			il_eq as il_operator_constant
		redefine
			enlarged, generate_operator
		end

feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		do
			v.process_bin_eq_b (Current)
		end

feature

	generate_operator is
			-- Generate the operator
		do
			buffer.put_string (" == ");
		end;

	generate_boolean_constant is
			-- Generate false constant
		do
			buffer.put_string ("EIF_FALSE");
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
					create {BOOL_CONST_B} Result.make (True)
				else
						-- They are either not of the same type, or if they are they might
						-- have different values. For the moment, we simply proceed to
						-- traditional code generation (no optimization done, as you could
						-- have an INTEGER_8 constant of value 1, and an INTEGER constant of value 1
						-- and no comparison features at the moment enables us to tell they
						-- are the same value without computation.
					create {BIN_EQ_BL} Result.make (left, right)
				end
			else
				create {BIN_EQ_BL} Result.make (left, right)
			end
		end;

feature -- IL code generation

	generate_il_boolean_constant is
			-- Generate IL True constant
		do
			il_generator.put_boolean_constant (False)
		end

end
