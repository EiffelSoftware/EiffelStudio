class UN_OLD_AS

inherit

	UNARY_AS
		redefine
			type_check, byte_node, operator_is_keyword, format,
			replicate, fill_calls_list
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
			old_as: UN_OLD_AS;
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

			old_as ?= expr;
			if 
				context.item.conform_to (Void_type) or else
				(old_as /= Void)
			then
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


	format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text
		do
			ctxt.begin;
			expr.format (ctxt);
			if not ctxt.last_was_printed then
				ctxt.rollback
			else
				ctxt.need_dot;
				ctxt.prepare_for_prefix ("_prefix_old");
				ctxt.put_current_feature;
				if ctxt.last_was_printed then
					ctxt.commit;
				else
					ctxt.rollback;
				end;
			end;
		end; 
			
	operator_name: STRING is "old";
	
	operator_is_keyword: BOOLEAN is true;

feature	-- Replication
	
	fill_calls_list (l: CALLS_LIST) is
			-- find calls to Current
		do
			expr.fill_calls_list (l);
		end;

	replicate (ctxt: REP_CONTEXT): like Current is
			-- Adapt to replication
		do
			Result := twin;
			Result.set_expr (expr.replicate (ctxt));
		end;
end
