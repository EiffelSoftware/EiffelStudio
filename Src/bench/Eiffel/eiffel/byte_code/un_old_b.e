class UN_OLD_B 

inherit

	UNARY_B
		redefine
			type, make_byte_code, enlarged
		end;
	
feature 

	type: TYPE_I is
			-- Type of the expression
		do
			Result := expr.type;
		end; -- type

	add_old_expression is
			-- Add Current to old_expressions.
		do
			Context.old_expressions.add (Current);
		end;

	enlarged: UN_OLD_BL is
		require else
			valid_old_exprs: Context.byte_code.old_expressions /= Void
		local
			old_expr: LINKED_LIST [UN_OLD_B]
		do
			!!Result;
			Result.set_expr (expr.enlarged);
			old_expr := Context.byte_code.old_expressions;
			old_expr.add (Result);
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

	initialize is
			-- Initialize C code for Current
		do
			-- Do nothing
		end;

end
