class BIN_XOR_B

inherit

	BOOL_BINARY_B
		redefine
			is_commutative, print_register, built_in_enlarged
		end;

feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		do
			v.process_bin_xor_b (Current)
		end

feature -- Enlarging

	built_in_enlarged: EXPR_B is
			-- Enlarge node. Try to get rid of useless code if possible.
		local
			l_left_val, l_right_val: VALUE_I
		do
			left := left.enlarged
			right := right.enlarged
			if context.final_mode then
				l_left_val := left.evaluate
				l_right_val := right.evaluate
				if l_left_val.is_boolean and then l_left_val.same_type (l_right_val) then
					create {BOOL_CONST_B} Result.make (not l_left_val.is_equivalent (l_right_val))
				else
					access := access.enlarged
					Result := Current
				end
			else
				access := access.enlarged
				Result := Current
			end
		end

feature

	is_commutative: BOOLEAN is True;
			-- Operation is commutative.

	print_register is
			-- Print the expression
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer
			buf.put_string ("((");
			left.print_register;
			buf.put_string (") != (");
			right.print_register;
			buf.put_string ("))");
		end;

end
