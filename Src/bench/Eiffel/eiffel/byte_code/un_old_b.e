class UN_OLD_B 

inherit

	UNARY_B
		redefine
			type, enlarged, make_byte_code
		end;
	
feature 

	type: TYPE_I is
			-- Type of the expression
		do
			Result := expr.type;
		end; -- type

	enlarged: UN_OLD_BL is
			-- Enlarge node and update information in BYTE_CODE
		local
			old_exps: LINKED_LIST [UN_OLD_B]
		do
			!!Result;
			Result.set_expr (expr.enlarged);
			old_exps := Context.byte_code.c_old_expressions;
			Context.byte_code.c_old_expressions.add (Result);
		end;

	add_old_expression is
			-- Add Current to old_expressions.
		do
			Context.old_expressions.add (Current);
		end;

	operator_constant: CHARACTER is
			-- Byte code constant associated to current binary
			-- operation
		do
			Result := Bc_old
		end;

feature -- Byte code generation

	make_initial_byte_code (ba: BYTE_ARRAY) is
			-- Make byte code at the start of the routine.
		do
			expr.make_byte_code (ba);
			ba.append (operator_constant);
		end;

	make_byte_code (ba: BYTE_ARRAY) is
			-- Do nothing.
		do
		end;

end
