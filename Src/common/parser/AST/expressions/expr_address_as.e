indexing

	description: 
		"AST representation of an Eiffel expression pointer.";
	date: "$Date$";
	revision: "Revision $"

class EXPR_ADDRESS_AS

inherit

	EXPR_AS

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

feature {NONE} -- Initialization

	set is
			-- Yacc initialization
		do
			expr ?= yacc_arg (0);
			if not is_allowed then
				Error_handler.make_syntax_error
			end
		ensure then
			expr_exists: expr /= Void
		end;

feature -- Properties

	expr: EXPR_AS;
			-- Expression to address

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (expr, other.expr)
		end

feature {NONE} -- Implementation

	is_allowed: BOOLEAN is
			-- Is this construct allowed?
		do
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_text_item (ti_Dollar);
			ctxt.put_text_item_without_tabs (ti_L_parenthesis);
			ctxt.format_ast (expr);
			ctxt.put_text_item_without_tabs (ti_R_parenthesis);
		end;

end -- class ADDRESS_AS
