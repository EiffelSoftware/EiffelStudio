indexing
	description: 
		"AST representation of a elsif clause of a condition instruction"
	date: "$Date$"
	revision: "$Revision$"

class
	ELSIF_AS

inherit
	AST_EIFFEL
		redefine
			is_equivalent, location
		end

feature {AST_FACTORY} -- Initialization

	initialize (e: like expr; c: like compound; l: like location) is
			-- Create a new ELSIF AST node.
		require
			e_not_void: e /= Void
		do
			expr := e
			compound := c
			location := l
		ensure
			expr_set: expr = e
			compound_set: compound = c
			location_set: location = l
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_elseif_as (Current)
		end

feature -- Attributes

	expr: EXPR_AS
			-- Conditional expression

	compound: EIFFEL_LIST [INSTRUCTION_AS]
			-- Compound

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (expr, other.expr) and
				equivalent (compound, other.compound)
		end

feature -- Access

	location: TOKEN_LOCATION
			-- Location of Current AST

--feature {AST_EIFFEL} -- Output
--
--	simple_format (ctxt: FORMAT_CONTEXT) is
--			-- Reconstitute text.
--		do
--			ctxt.put_text_item (ti_Elseif_keyword);
--			ctxt.put_space;
--			ctxt.new_expression;
--			ctxt.format_ast (expr);
--			ctxt.put_space;
--			ctxt.put_text_item_without_tabs (ti_Then_keyword);
--			ctxt.indent;
---			ctxt.set_separator (ti_Semi_colon);
--			ctxt.set_new_line_between_tokens;
--			ctxt.new_line;
--			if compound /= Void then
--				ctxt.format_ast (compound);
--			end
--			ctxt.new_line;
--			ctxt.put_breakable;
--		end

feature {ELSIF_AS} -- Replication

	set_expr (e: like expr) is
		require
			valid_arg: e /= Void
		do
			expr := e
		end

	set_compound (c: like compound) is
		do
			compound := c
		end

end -- class ELSIF_AS
