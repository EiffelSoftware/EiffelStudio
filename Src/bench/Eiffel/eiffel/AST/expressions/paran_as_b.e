-- Abstract description of a parenthesized expression

class PARAN_AS

inherit

	EXPR_AS
		redefine
			type_check, byte_node, format
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
			ctxt.put_special(" (");
			expr.format (ctxt);
			if ctxt.last_was_printed then
				ctxt.put_special(") ");
				ctxt.commit;
			else
				ctxt.rollback;
			end;
		end;

end
