indexing
	description: 
		"AST representation of a conditional instruction"
	date: "$Date$"
	revision: "$Revision$"

class
	IF_AS

inherit
	INSTRUCTION_AS

feature {AST_FACTORY} -- Initialization

	initialize (cnd: like condition; cmp: like compound;
		ei: like elsif_list; e: like else_part; l: like location) is
			-- Create a new IF AST node.
		require
			cnd_not_void: cnd /= Void
			l_not_void: l /= Void
		do
			condition := cnd
			compound := cmp
			elsif_list := ei
			else_part := e
			location := clone (l)
		ensure
			condition_set: condition = cnd
			compound_set: compound = cmp
			elsif_list_set: elsif_list = ei
			else_part_set: else_part = e
			location_set: location.is_equal (l)
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_if_as (Current)
		end

feature -- Attributes

	condition: EXPR_AS
			-- Conditional expression

	compound: EIFFEL_LIST [INSTRUCTION_AS]
			-- Compound

	elsif_list: EIFFEL_LIST [ELSIF_AS]
			-- Elsif list

	else_part: EIFFEL_LIST [INSTRUCTION_AS]
			-- Else part

feature -- Comparison 

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (compound, other.compound) and then
				equivalent (condition, other.condition) and then
				equivalent (else_part, other.else_part) and then
				equivalent (elsif_list, other.elsif_list)
		end

--feature {AST_EIFFEL} -- Output
--
--	simple_format (ctxt: FORMAT_CONTEXT) is
--			-- Reconstitute text
--		do
--			ctxt.put_breakable;
--			ctxt.put_text_item (ti_If_keyword);
--			ctxt.put_space;
--			ctxt.new_expression;
--			ctxt.format_ast (condition);
--			ctxt.put_space;
--			ctxt.put_text_item_without_tabs (ti_Then_keyword);
--			if compound /= Void then
--				ctxt.indent;
--				ctxt.new_line;
--				ctxt.set_new_line_between_tokens;
--				ctxt.format_ast (compound);
--				ctxt.exdent;
--			end
--			ctxt.new_line;
--			ctxt.put_breakable 
--			if elsif_list /= void then
--				ctxt.set_separator (ti_Empty);
--				ctxt.set_no_new_line_between_tokens;
--				ctxt.format_ast (elsif_list);
--				ctxt.set_separator (ti_Semi_colon);
--			end
--			if else_part /= void then
--				ctxt.put_text_item (ti_Else_keyword);
--				ctxt.indent;
--				ctxt.new_line;
--				ctxt.set_new_line_between_tokens;
--				ctxt.format_ast (else_part);
--				ctxt.exdent;
--				ctxt.new_line;
--				ctxt.put_breakable 
--			end
--			ctxt.put_text_item (ti_End_keyword);
--		end
		 			   
feature {IF_AS} -- Replication

	set_condition (c: like condition) is
			-- Set `condition' to `c'.
		require
			valid_arg: c /= Void
		do
			condition := c
		end

	set_compound (c: like compound) is
			-- Set `compound' to `c'.
		do
			compound := c
		end

	set_elsif_list (e: like elsif_list) is
			-- Set `elsif_list' to `e'.
		do
			elsif_list := e
		end

	set_else_part (e: like else_part) is
			-- Set `else_part' to `e'.
		do
			else_part := e
		end

end -- class IF_AS
