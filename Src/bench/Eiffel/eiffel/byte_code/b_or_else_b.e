-- Byte code for "or else"

class B_OR_ELSE_B 

inherit

	BOOL_BINARY_B
		rename
			Bc_or as operator_constant,
			il_or as il_operator_constant
		redefine
			built_in_enlarged, generate_operator, make_standard_byte_code,
			is_commutative, generate_standard_il
		end;
	
feature -- Status report

	is_or: BOOLEAN is
			-- Is Current just `or', i.e. order does not matter?
		do
		end

feature -- Enlarging

	built_in_enlarged: EXPR_B is
			-- Enlarge node. Try to get rid of useless code if possible.
		local
			l_b_or_else_bl: B_OR_ELSE_BL
			l_bool_val: VALUE_I
			l_is_normal: BOOLEAN
		do
			left := left.enlarged
			right := right.enlarged
			if context.final_mode then
				l_bool_val := left.evaluate
				if l_bool_val.is_boolean then
					if l_bool_val.boolean_value then
							-- Expression will always be True.
							-- case of: True_expression or XXX
							--       or True_expression or else XXX
						create {BOOL_CONST_B} Result.make (True)
					else
						Result := right
					end
				else
					l_bool_val := right.evaluate
					if l_bool_val.is_boolean then
						if not l_bool_val.boolean_value or not is_or then
								-- case of: XXX or False_expression
								--       or XXX or else False_expression
								--       or XXX or else True_expression
								-- We always need to return left-hand side, even for third
								-- case because `or else' implies a certain order of
								-- evaluation.
							Result := left
						else
							check
								valid_simplification: l_bool_val.boolean_value and is_or
							end
								-- Expression will always be True.
								-- case of: XXX or True_expression
								-- Note: you cannot do such an optimization with a `or else'
								-- statement as the order matter (see above comments).
							create {BOOL_CONST_B} Result.make (True)
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
				create l_b_or_else_bl
				l_b_or_else_bl.init (access.enlarged)
				l_b_or_else_bl.set_left (left)
				l_b_or_else_bl.set_right (right)
				Result := l_b_or_else_bl
			end
		end

	generate_operator is
			-- Generate the operator
		do
			buffer.putstring (" || ");
		end;

	is_commutative: BOOLEAN is
			-- Is operation commutative ?
		do
			Result := not has_call;
		end;

feature -- IL code generation

	generate_standard_il is
			-- Generate IL code for `or else' expression.
		local
			or_else_label, final_label: IL_LABEL
		do
			or_else_label := il_label_factory.new_label
			final_label := il_label_factory.new_label
			generate_il_with_label (or_else_label)
			il_generator.branch_to (final_label)
			il_generator.mark_label (or_else_label)
			il_generator.put_boolean_constant (True)
			il_generator.mark_label (final_label)
		end

	generate_il_with_label (or_else_label: IL_LABEL) is
		local
			b: like Current
		do
			b ?= left
			if b /= Void then
				b.generate_il_with_label (or_else_label)
			else
				left.generate_il
			end
			il_generator.branch_on_true (or_else_label)
			right.generate_il
		end

feature -- Byte code generation

	make_standard_byte_code (ba: BYTE_ARRAY) is
			-- Generate standard byte code for binary expression
		do
			left.make_byte_code (ba);
			ba.append (Bc_or_else);
			ba.mark_forward;
			right.make_byte_code (ba);
			ba.append (operator_constant); -- Bc_or
			ba.write_forward;
		end;

end
