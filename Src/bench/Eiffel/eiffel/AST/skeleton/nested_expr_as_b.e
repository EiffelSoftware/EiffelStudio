-- Abstract description of a nested call `target.message' where the target
-- is a parenthesized expression

class NESTED_EXPR_AS

inherit

	CALL_AS
		redefine
			type_check, byte_node
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
			context.change_item (t);

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

end
