-- Abstract description of a parenthesized expression

class PARAN_AS

inherit

	EXPR_AS
		redefine
			simple_format
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

	simple_format (ctxt: FORMAT_CONTEXT) is
		do
			ctxt.begin;
			ctxt.put_text_item (ti_L_parenthesis);
			expr.simple_format (ctxt);
			if ctxt.last_was_printed then
				ctxt.put_text_item (ti_R_parenthesis);
				ctxt.commit;
			end;
		end;

feature {PARAN_AS}	-- Replication

	set_expr (e: like expr) is
		require
			valid_arg: e /= Void
		do
			expr := e
		end;

end
