indexing
	description: 
		"AST representation of a parenthesized expression."
	date: "$Date$"
	revision: "$Revision$"

class
	PARAN_AS

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

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_paran_as (Current)
		end

feature -- Attributes

	expr: EXPR_AS;
			-- Parenthesized expression

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (expr, other.expr)
		end

--feature {AST_EIFFEL} -- Output
--
--	simple_format (ctxt: FORMAT_CONTEXT) is
--			-- Reconstitute text.
--		do
--			ctxt.put_text_item (ti_L_parenthesis);
--			ctxt.format_ast (expr);
--			ctxt.put_text_item_without_tabs (ti_R_parenthesis);
--		end

feature {PARAN_AS}	-- Replication

	set_expr (e: like expr) is
			-- FIXME: move to bench specific???
		require
			valid_arg: e /= Void
		do
			expr := e
		end

end -- class PARAN_AS
