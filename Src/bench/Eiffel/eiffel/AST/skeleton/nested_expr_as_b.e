indexing

	description:
			"Abstract description of a nested call `target.message' where %
			%the target is a parenthesized expression. Version for Bench.";
	date: "$Date$";
	revision: "$Revision$"

class NESTED_EXPR_AS_B

inherit

	NESTED_EXPR_AS
		redefine
			target, message
		end;

	CALL_AS_B
		redefine
			type_check, byte_node, format, 
			fill_calls_list, replicate
		end

feature -- Attributes

	target: EXPR_AS_B;
			-- Target of the call

	message: CALL_AS_B;
			-- Message send to the target

feature -- Type check, byte code and dead code removal

	type_check is
			-- Type check the call
		local
			t: TYPE_A;
		do
				-- Type check the target
			target.type_check;

			t := context.item;
			context.pop (1);
			context.replace (t);

			if t.is_separate then
					-- The target of a separate call must be an argument
					-- FIXME: the expression can be an argument access only
				Error_handler.make_separate_syntax_error
			end

				-- Type check the message
			message.type_check;
		end;

	byte_node: NESTED_B is
			-- Associated byte code
		local
			access_expr: ACCESS_EXPR_B;
			c: CALL_B;
		do
			!!access_expr;
			access_expr.set_expr (target.byte_node);
			!!Result;
			Result.set_target (access_expr);
			c := message.byte_node;
			Result.set_message (c);
			c.set_parent (Result);
		end;

	format (ctxt: FORMAT_CONTEXT_B) is
		-- Reconstitute text.
		do
			ctxt.begin;
			ctxt.put_text_item (ti_L_parenthesis);
			target.format (ctxt);
			if ctxt.last_was_printed then
				ctxt.put_text_item_without_tabs (ti_R_parenthesis);
				ctxt.need_dot;
				message.format (ctxt);
				if ctxt.last_was_printed then
					ctxt.commit
				else
					ctxt.rollback;
				end
			else
				ctxt.rollback
			end
		end;

    fill_calls_list (l: CALLS_LIST) is
            -- find calls to Current
        do
            target.fill_calls_list (l);
            l.stop_filling;
            message.fill_calls_list (l);
        end;

    Replicate (ctxt: REP_CONTEXT): like Current is
            -- Adapt to replication
        do
            Result := clone (Current);
            Result.set_target (target.replicate (ctxt));
            Result.set_message (message.replicate (ctxt));
        end;

end -- class NESTED_EXPR_AS_B
