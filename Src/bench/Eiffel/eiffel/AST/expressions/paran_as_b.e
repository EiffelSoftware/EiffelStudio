-- Abstract description of a parenthesized expression

class PARAN_AS

inherit

	EXPR_AS
		redefine
			type_check, byte_node, format,
			fill_calls_list, replicate
		end

feature -- Attributes

	expr: EXPR_AS;
			-- Parenthesized expression

feature -- Initialization

	set is
			-- Yacc initialization
		do
			expr ?= yacc_arg (0);
		ensure then
			expr_exists: expr /= Void;
		end;

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

	format (ctxt: FORMAT_CONTEXT) is
		do
			ctxt.begin;
			ctxt.put_text_item (ti_L_parenthesis);
			expr.format (ctxt);
			if ctxt.last_was_printed then
				ctxt.put_text_item (ti_R_parenthesis);
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

feature {PARAN_AS}	-- Replication

	set_expr (e: like expr) is
		require
			valid_arg: e /= Void
		do
			expr := e
		end;


end
