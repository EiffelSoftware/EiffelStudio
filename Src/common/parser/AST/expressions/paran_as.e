indexing

	description: "Abstract description of a parenthesized expression";
	date: "$Date$";
	revision: "$Revision$"

class PARAN_AS

inherit

	EXPR_AS
		redefine
			simple_format
		end;

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

feature -- Simple formatting

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.begin;
			ctxt.put_text_item (ti_L_parenthesis);
			expr.simple_format (ctxt);
			ctxt.put_text_item (ti_R_parenthesis);
			ctxt.commit;
		end;

feature {PARAN_AS}	-- Replication

	set_expr (e: like expr) is
		require
			valid_arg: e /= Void
		do
			expr := e
		end;

end -- class PARAN_AS
