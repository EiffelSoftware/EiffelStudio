class UN_OLD_B 

inherit

	UNARY_B
		redefine
			type, make_byte_code, enlarged
		end;
	
feature 

	position: INTEGER;
			-- Position of old in local declaration.
			--| The old expression will be held in the local
			--| registers of the interpreter, that is, the old
			--| old expression value will be stored in local
			--| according to `position'. So when the old expression
			--! will be interpretered, the interpreter will retrieve
			--| the value from the local register.

	set_position (i: INTEGER) is
			-- Assign `i' to position
		do
			position := i
		end;

	type: TYPE_I is
			-- Type of the expression
		do
			Result := expr.type;
		end; -- type

	add_old_expression is
			-- Add Current to old_expressions.
		do
			Context.old_expressions.put_front (Current);
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
			old_expr.extend (Result);
		end;

	operator_constant: CHARACTER is
			-- Byte code constant associated to current binary
			-- operation
		do
			Result := Bc_old
		end;

feature -- Byte code generation

	make_initial_byte_code (ba: BYTE_ARRAY) is
			-- Make byte code at the start of the routine
			-- and place the result in local register with
			-- position.
		require
			valid_position: position > 0;
		do
			expr.make_byte_code (ba);
			ba.append (operator_constant);
			ba.append_short_integer (position);
		end;

	make_byte_code (ba: BYTE_ARRAY) is
			-- Retrieve the byte code for the old expression
			-- from local register with position `position'.
		require else
			valid_position: position > 0;
		do
			ba.append (Bc_retrieve_old);
			ba.append_short_integer (position);
		end;

end
