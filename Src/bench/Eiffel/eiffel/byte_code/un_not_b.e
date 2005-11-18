class UN_NOT_B

inherit
	UNARY_B
		rename
			Il_not as il_operator_constant
		redefine
			generate_operator, is_built_in, print_register,
			enlarged
		end;

feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		do
			v.process_un_not_b (Current)
		end

feature

	print_register is
			-- print expression value
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer
			buf.put_string ("(EIF_BOOLEAN) !")
			expr.print_register
		end

	generate_operator is
			-- Generate the unary operator
		do
			buffer.put_character ('!');
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
					create {BOOL_CONST_B} Result.make (not l_val.boolean_value)
				else
					if access /= Void then
						access := access.enlarged
					end
					Result := Current
				end
			end
		end

end
