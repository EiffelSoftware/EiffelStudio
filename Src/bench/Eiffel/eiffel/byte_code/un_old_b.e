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
		do
			!!Result;
			Result.set_expr (expr.enlarged);
			context.old_expressions.put_right (Result);
		end;

	operator_constant: CHARACTER is
			-- Byte code constant associated to current binary
			-- operation
		do
			-- FIXME
		end;

feature 

	make_byte_code (ba: BYTE_ARRAY) is
		do
			-- FIXME
		end;

end
