indexing

	description: 
		"AST representation of a tagged expression.";
	date: "$Date$";
	revision: "$Revision$"

class TAGGED_AS

inherit

	EXPR_AS

feature {NONE} -- Initialization

	set is
			-- Yacc initialization
		do
			tag ?= yacc_arg (0);
			expr ?= yacc_arg (1);
		ensure then
			expr_exists: expr /= Void;
		end;

feature -- Properties

	tag: ID_AS;
			-- Expression tag

	expr: EXPR_AS;
			-- Expression

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (tag, other.tag) and then
				equivalent (expr, other.expr)
		end

	is_equiv (other: like Current): BOOLEAN is
			-- Is `other' tagged as equivalent to Current?
		do
			Result := equivalent (tag, other.tag) and then equivalent (expr, other.expr)
		end;	

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			if tag /= Void then
				ctxt.put_string (tag);
				ctxt.put_text_item_without_tabs (ti_Colon);
				ctxt.put_space
			end;
			ctxt.new_expression;
			ctxt.format_ast (expr);
		end;

feature {TAGGED_AS}	-- Replication

	set_expr (e: like expr) is
		require
			valid_arg: e /= Void
		do
			expr := e;
		end

end -- class TAGGED_AS
