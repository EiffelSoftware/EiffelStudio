-- Byte code for "and then"

class B_AND_THEN_B 

inherit

	BOOL_BINARY_B
		rename
			Bc_and as operator_constant,
			il_and as il_operator_constant
		redefine
			built_in_enlarged, generate_operator,
			is_commutative, make_standard_byte_code,
			generate_standard_il
		end

feature -- Status report

	is_and: BOOLEAN is
			-- Is Current just `and', i.e. order does not matter?
		do
		end

feature -- Enlarging

	built_in_enlarged: EXPR_B is
			-- Enlarge node. Try to get rid of useless code if possible.
		local
			l_b_and_thn_bl: B_AND_THN_BL
			l_bool_val: VALUE_I
			l_is_normal: BOOLEAN
		do
			left := left.enlarged
			right := right.enlarged
			if context.final_mode then
				l_bool_val := left.evaluate
				if l_bool_val.is_boolean then
					if l_bool_val.boolean_value then
						Result := right
					else
							-- Expression will always be False.
							-- case of: False_expression and XXX
							--       or False_expression and then XXX
						create {BOOL_CONST_B} Result.make (False)
					end
				else
					l_bool_val := right.evaluate
					if l_bool_val.is_boolean then
						if l_bool_val.boolean_value or not is_and then
								-- case of: XXX and True_expression
								--       or XXX and then True_expression
								--       or XXX and then False_expression
								-- We always need to return left-hand side, even
								-- for third case because `and then' implies a certain
								-- order of evaluation.
							Result := left
						else
							check
								valid_simplification: not l_bool_val.boolean_value and is_and
							end
								-- Expression will always be False.
								-- case of: XXX and False_expression
								-- Note: you cannot do such an optimization with a `and then'
								-- statement as the order matter (see above comments).
							create {BOOL_CONST_B} Result.make (False)
						end
					else
						l_is_normal := True
					end
				end
			else
				l_is_normal := True
			end
			
			if l_is_normal then
					-- Normal code transformation.
				create l_b_and_thn_bl
				l_b_and_thn_bl.init (access.enlarged)
				l_b_and_thn_bl.set_left (left)
				l_b_and_thn_bl.set_right (right)
				Result := l_b_and_thn_bl
			end
		end			

	generate_operator is
			-- Generate the operator
		do
			buffer.putstring (" && ");
		end;

	
	is_commutative: BOOLEAN is
			-- Is operation commutative ?
		do
			Result := not has_call;
		end;

feature -- IL code generation

	generate_standard_il is
			-- Generate IL code for `and then' expression.
		local
			and_then_label, final_label: IL_LABEL
		do
			and_then_label := il_label_factory.new_label
			final_label := il_label_factory.new_label
			generate_il_with_label (and_then_label, final_label)
			il_generator.branch_to (final_label)
			il_generator.mark_label (and_then_label)
			il_generator.put_boolean_constant (False)
			il_generator.mark_label (final_label)
		end

	generate_il_with_label (and_then_label, final_label: IL_LABEL) is
		local
			b: like Current
		do
			b ?= left
			if b /= Void then
				b.generate_il_with_label (and_then_label, final_label)
			else
				left.generate_il
			end
			il_generator.branch_on_false (and_then_label)
			right.generate_il
		end

feature -- Byte code generation
	
	make_standard_byte_code (ba: BYTE_ARRAY) is
			-- Generate standard byte code for binary expression
		do
			left.make_byte_code (ba);
			ba.append (Bc_and_then);
			ba.mark_forward;
			right.make_byte_code (ba);
			ba.append (operator_constant); -- Bc_and
			ba.write_forward;
		end;
			
end
