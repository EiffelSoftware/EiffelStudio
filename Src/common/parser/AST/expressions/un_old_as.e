class UN_OLD_AS

inherit

	UNARY_AS
		redefine
			type_check, byte_node, operator_is_keyword
		end;

feature -- Type check

	prefix_feature_name: STRING is
			-- Internal name of the prefixed feature
		once
		end; -- prefix_feature_name

feature -- Type check, byte code and dead code removal

	type_check is
			-- Type check
		local
			vaol1: VAOL1;
			vaol2: VAOL2;
		do
			if not context.level1 then
					-- Old expression found somewhere else that in a
					-- postcondition
				!!vaol1;
				context.init_error (vaol1);
				vaol1.set_old_expr (Current);
				Error_handler.insert_error (vaol1);
			end;

				-- Expression type check
			expr.type_check;

			if context.item.conform_to (Void_type) then
					-- Not an expression
				!!vaol2;
				context.init_error (vaol2);
				vaol2.set_old_expr (Current);
				Error_handler.insert_error (vaol2);
			end;
		end;

	byte_node: UN_OLD_B is
			-- Associated byte code
		local
			old_expr: EXPR_B;
		do
			!!Result;
			old_expr := expr.byte_node;
			Result.set_expr (old_expr);
			Result.add_old_expression;
		end;

	operator_name: STRING is "old";
	
	operator_is_keyword: BOOLEAN is true;
end
