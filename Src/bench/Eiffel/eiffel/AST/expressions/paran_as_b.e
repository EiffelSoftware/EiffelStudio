indexing

	description:
		"Abstract description of a parenthesized expression. %
		%Version for Bench.";
	date: "$Date$";
	revision: "$Revision$"

class PARAN_AS_B

inherit

	PARAN_AS
		redefine
			expr
		end;

	EXPR_AS_B
		redefine
			type_check, byte_node, format,
			fill_calls_list, replicate
		end

feature -- Attributes

	expr: EXPR_AS_B;
			-- Parenthesized expression

feature -- Type check, byte code and dead code removal

	type_check is
			-- Type check an parenthesized expression
		do
			expr.type_check;
		end;

	byte_node: PARAN_B is
			-- Associated byte code
		do
			!!Result;
			Result.set_expr (expr.byte_node);
		end;

	format (ctxt: FORMAT_CONTEXT_B) is
		do
			ctxt.begin;
			simple_format (ctxt);
			if ctxt.last_was_printed then
				ctxt.commit;
			else
				ctxt.rollback;
			end;
		end;

feature	-- Replication

	fill_calls_list (l: CALLS_LIST) is
			-- find calls to Current
		do
			expr.fill_calls_list (l);
		end;

	replicate (ctxt: REP_CONTEXT): like Current is
			-- Adapt to replication
		do	
			Result := clone (Current);
			Result.set_expr (expr.replicate (ctxt))
		end;

end -- class PARAN_AS_B
