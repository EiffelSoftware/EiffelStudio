-- Abstract description of a nested call `target.message' where the target
-- is a parenthesized expression

class NESTED_EXPR_AS

inherit

	CALL_AS
		redefine
			type_check, byte_node, format, 
			fill_calls_list, replicate
		end

feature -- Attributes

	target: EXPR_AS;
			-- Target of the call

	message: CALL_AS;
			-- Message send to the target

feature -- Initialization

	set is
			-- Yacc initilization
		do
			target ?= yacc_arg (0);
			message ?= yacc_arg (1);
		ensure then
			target_exists: target /= Void;
			message_exists: message /= Void;
		end;

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

	format (ctxt: FORMAT_CONTEXT) is
		-- Reconstitute text.
		do
			ctxt.begin;
			ctxt.put_special ("(");
			target.format (ctxt);
			if ctxt.last_was_printed then
				ctxt.put_special (")");
				ctxt.need_dot;
				ctxt.keep_types;
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

feature {NESTED_EXPR_AS} -- Replication

    set_target (t: like target) is
        require
            valid_arg: t /= Void
        do
            target := t;
        end;


    set_message (m: like message) is
        require
            valid_arg: m /= Void
        do
            message := m;
        end;

end
