-- Abstract description of a elsif clause of a condition instruction

class ELSIF_AS

inherit

	AST_EIFFEL
		redefine
			simple_format
		end

feature -- Attributes

	expr: EXPR_AS;
			-- Conditional expression

	compound: EIFFEL_LIST [INSTRUCTION_AS];
			-- Compound

feature -- Initialization

	set is
			-- Yacc initialization
		do
			expr ?= yacc_arg (0);
			compound ?= yacc_arg (1);
		ensure then
			expr_exists: expr /= Void
		end;

feature -- simple_Formatter
	
	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.begin;
			ctxt.put_text_item (ti_Elseif_keyword);
			ctxt.put_space;
		   	ctxt.new_expression;
			expr.simple_format (ctxt);
			ctxt.put_space;
			ctxt.put_text_item (ti_Then_keyword);
			ctxt.indent_one_more;
			ctxt.set_separator (ti_Semi_colon);
			ctxt.new_line_between_tokens;
			ctxt.next_line;
			if compound /= Void then
				compound.simple_format (ctxt);
			end;
			ctxt.put_breakable;
			ctxt.commit;
		end;

feature {ELSIF_AS} -- Replication

	set_expr (e: like expr) is
		require
			valid_arg: e /= Void
		do
			expr := e
		end;

	set_compound (c: like compound) is
		do
			compound := c
		end;
end
