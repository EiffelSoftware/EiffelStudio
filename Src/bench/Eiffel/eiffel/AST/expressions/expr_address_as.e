indexing
	description:
		"Abstract description of an Eiffel expression pointer. %
		%Version for Bench"
	date: "$Date$"
	revision: "$Revision$"

class
	EXPR_ADDRESS_AS

inherit
	EXPR_AS
		redefine
			type_check, byte_node, format
		end

	SHARED_TYPES

feature {AST_FACTORY} -- Initialization

	initialize (e: like expr) is
			-- Create a new EXPR_ADDRESS AST node.
		require
			e_not_void: e /= Void
		do
			expr := e
			if not is_allowed then
				Error_handler.make_syntax_error
			end
		ensure
			expr_set: expr = e
		end

feature -- Properties

	expr: EXPR_AS
			-- Expression to address

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (expr, other.expr)
		end

feature -- Type check, byte code and dead code removal

	type_check is
			-- Type check an address access.
		do
			expr.type_check
				-- Replace type of expression by pointer type
			context.replace (pointer_type)
		end

	byte_node: EXPR_ADDRESS_B is
			-- Associated byte code.
		do
			!! Result
			Result.set_expr (expr.byte_node)
		end

	format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
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
			ctxt.put_text_item (ti_Dollar)
			ctxt.put_text_item_without_tabs (ti_L_parenthesis)
			ctxt.format_ast (expr)
			ctxt.put_text_item_without_tabs (ti_R_parenthesis)
		end

feature {NONE} -- Implementation

	is_allowed: BOOLEAN is
			-- Is this construct allowed?
		do
			Result := System.address_expression_allowed
		end

end -- class EXPR_ADDRESS_AS
