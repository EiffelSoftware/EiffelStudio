class UN_NOT_B 

inherit
	UNARY_B
		rename
			Bc_not as operator_constant,
			Il_not as il_operator_constant
		redefine
			generate_operator, is_built_in, print_register,
			enlarged
		end;
	
feature

	print_register is
			-- print expression value
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer
			buf.putstring ("(EIF_BOOLEAN) !")
			expr.print_register
		end

	generate_operator is
			-- Generate the unary operator
		do
			buffer.putchar ('!');
		end;

	is_built_in: BOOLEAN is
			-- Is the current binary operator a built-in one ?
		do
			Result := context.real_type (expr.type).is_boolean;
		end;

feature -- Enlarging

	enlarged: EXPR_B is
			-- Enlarge expression.
		local
			l_val: VALUE_I
		do
			if not is_built_in or not context.final_mode then
				Result := Precursor {UNARY_B}
			else
				expr := expr.enlarged
				l_val := expr.evaluate
				if l_val.is_boolean then
					create {CONSTANT_B} Result.make (l_val.unary_not)
				else
					if access /= Void then
						access := access.enlarged
					end
					Result := Current
				end
			end
		end

end
