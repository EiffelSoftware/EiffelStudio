-- Byte code for semi-strict "implies"

class
	B_IMPLIES_B 

inherit
	BOOL_BINARY_B
		redefine
			built_in_enlarged, print_register, make_standard_byte_code,
			generate_il
		end

feature 

	built_in_enlarged: EXPR_B is
			-- Enlarge node. Try to get rid of useless code if possible.
		local
			l_b_implies_bl: B_IMPLIES_BL
			l_bool_val: VALUE_I
			l_is_normal: BOOLEAN
		do
			left := left.enlarged
			if context.final_mode then
				l_bool_val := left.evaluate
				if l_bool_val.is_boolean then
					if not l_bool_val.boolean_value then
							-- Expression is always True as left-hand side is False.
						create {CONSTANT_B} Result.make (create {BOOL_VALUE_I}.make (True))
					else
						right := right.enlarged
						l_bool_val := right.evaluate
						if l_bool_val.is_boolean then
								-- Expression is always True.
							create {CONSTANT_B} Result.make (l_bool_val)
						else
							Result := right
						end
					end
				else
					l_is_normal := True
				end
			else
				l_is_normal := True
			end
			
			if l_is_normal then
					-- Normal code transformation.
				create l_b_implies_bl
				l_b_implies_bl.init (access.enlarged)
				l_b_implies_bl.set_left (left)
				l_b_implies_bl.set_right (right.enlarged)
				Result := l_b_implies_bl
			end
		end			

	print_register is
			-- Print the expression
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer
			buf.putstring ("(!(");
			left.print_register;
			buf.putstring (") || (");
			right.print_register;
			buf.putstring ("))");
		end;

feature -- IL code generation

	il_operator_constant: INTEGER is
			-- IL code constant associated to current binary operation.
		do
			check False end
		end

	generate_il is
			-- Generate IL code for `implies' expression.
		local
			unary_not: UN_NOT_B
			binary_or_else: B_OR_ELSE_B
		do
			create unary_not
			unary_not.set_expr (left)
			create binary_or_else
			binary_or_else.set_left (unary_not)
			binary_or_else.set_right (right)
			binary_or_else.generate_standard_il
		end

feature -- Byte code generation

	operator_constant: CHARACTER is
			-- Byte code constant associated to current binary
			-- operation
		do
			-- Do nothing
		ensure then
			False
		end; -- operator_constant

	make_standard_byte_code (ba: BYTE_ARRAY) is
			-- Generate standard byte code for binary expression
		local
			unary_not: UN_NOT_B;
			binary_or_else: B_OR_ELSE_B;
		do
			!!unary_not;
			unary_not.set_expr (left);
			!!binary_or_else;
			binary_or_else.set_left (unary_not);
			binary_or_else.set_right (right);
			binary_or_else.make_standard_byte_code (ba);
		end;

end
