indexing

	description: 
		"AST representation of a parenthesized expression.";
	date: "$Date$";
	revision: "$Revision$"

class PARAN_AS

inherit

	EXPR_AS

feature {AST_FACTORY} -- Initialization

	initialize (e: like expr) is
			-- Create a new PARAN AST node.
		require
			e_not_void: e /= Void
		do
			expr := e
		ensure
			expr_set: expr = e
		end

feature {NONE} -- Initialization

	set is
			-- Yacc initialization
		do
			expr ?= yacc_arg (0);
		ensure then
			expr_exists: expr /= Void;
		end;

feature -- Property

	expr: EXPR_AS;
			-- Parenthesized expression

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (expr, other.expr)
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_text_item (ti_L_parenthesis);
			ctxt.format_ast (expr);
			ctxt.put_text_item_without_tabs (ti_R_parenthesis);
		end;

feature {PARAN_AS}	-- Replication

	set_expr (e: like expr) is
			-- FIXME: move to bench specific???
		require
			valid_arg: e /= Void
		do
			expr := e
		end;

end -- class PARAN_AS
