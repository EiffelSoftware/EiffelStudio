indexing

	description:
		"Abstract description of a call as an expression. %
		%Version for Bench.";
	date: "$Date$";
	revision: "$Revision$"

class EXPR_CALL_AS_B

inherit

	EXPR_CALL_AS
		redefine
			call
		end;

	EXPR_AS_B
		redefine
			type_check, byte_node, 
			 fill_calls_list, replicate
		end

feature -- Attributes

	call: CALL_AS_B;
			-- Expression call

feature -- Type check, byte code and dead code removal

	type_check is
			-- Type check of a call as an expression.
		do
				-- Put an actual type of the current analyzed class
			context.begin_expression;
				-- Type check the call
			call.type_check;
		end;

	byte_node: CALL_B is
			-- Associated byte code.
		do
			Result := call.byte_node;
		end;

feature	-- Replication

	fill_calls_list (l: CALLS_LIST) is
			-- Find calls to Current.
		do
			call.fill_calls_list (l);
		end;

	replicate (ctxt: REP_CONTEXT): like Current is
			-- Adapt to replication.
		do
			Result := clone (Current);
			Result.set_call (call.replicate (ctxt));
		end;

end -- class EXPR_CALL_AS_B
