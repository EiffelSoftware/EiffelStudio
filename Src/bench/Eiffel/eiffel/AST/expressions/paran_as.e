indexing
	description:
		"Abstract description of a parenthesized expression. %
		%Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class
	PARAN_AS

inherit
	EXPR_AS
		redefine
			type_check, byte_node, format
		end

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

feature -- Attributes

	expr: EXPR_AS
			-- Parenthesized expression

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (expr, other.expr)
		end

feature -- Type check, byte code and dead code removal

	type_check is
			-- Type check an parenthesized expression
		do
			expr.type_check
		end

	byte_node: PARAN_B is
			-- Associated byte code
		do
			!! Result
			Result.set_expr (expr.byte_node)
		end

	format (ctxt: FORMAT_CONTEXT) is
		do
			ctxt.begin
			simple_format (ctxt)
			if ctxt.last_was_printed then
				ctxt.commit
			else
				ctxt.rollback
			end
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_text_item (ti_L_parenthesis)
			ctxt.format_ast (expr)
			ctxt.put_text_item_without_tabs (ti_R_parenthesis)
		end

feature {PARAN_AS}	-- Replication

	set_expr (e: like expr) is
			-- FIXME: move to bench specific???
		require
			valid_arg: e /= Void
		do
			expr := e
		end

end -- class PARAN_AS
