indexing
	description: 
		"AST representation of a multi_branch instruction"
	date: "$Date$"
	revision: "$Revision$"

class
	INSPECT_AS

inherit
	INSTRUCTION_AS

feature {AST_FACTORY} -- Initialization

	initialize (s: like switch; c: like case_list; e: like else_part; l: like location) is
			-- Create a new INSPECT AST node.
		require
			s_not_void: s /= Void
			l_not_void: l /= Void
		do
			switch := s
			case_list := c
			else_part := e
			location := clone (l)
		ensure
			switch_set: switch = s
			case_list_set: case_list = c
			else_part_set: else_part = e
			location_set: location.is_equal (l)
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_inspect_as (Current)
		end

feature -- Attributes

	switch: EXPR_AS
			-- Expression to inspect

	case_list: EIFFEL_LIST [CASE_AS]
			-- Alternatives

	else_part: EIFFEL_LIST [INSTRUCTION_AS]
			-- Else part

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (case_list, other.case_list) and then
				equivalent (else_part, other.else_part) and then
				equivalent (switch, other.switch)
		end

--feature {AST_EIFFEL} -- Output
--
--	simple_format (ctxt: FORMAT_CONTEXT) is
--			-- Reconstitute text.
--		do
--			ctxt.put_breakable;
--			ctxt.put_text_item (ti_Inspect_keyword);
--			ctxt.put_space;
--			ctxt.indent;
--			ctxt.format_ast (switch);
--			ctxt.exdent;
--			ctxt.new_line;
--			if case_list /= void then
--				ctxt.set_separator (ti_Empty);
--				ctxt.set_no_new_line_between_tokens;
--				ctxt.reversed_format_list (case_list);
--			end
--			if else_part /= void then
--				ctxt.put_text_item (ti_Else_keyword);
--				ctxt.indent;
--				ctxt.new_line;
--				ctxt.set_separator (ti_Semi_colon);
--				ctxt.set_new_line_between_tokens;
--				ctxt.reversed_format_list (else_part);
--				ctxt.new_line;
--				ctxt.exdent;
--				ctxt.put_breakable;
--			end
--			ctxt.put_text_item (ti_End_keyword);
--		end

feature {INSPECT_AS} -- Replication

	set_switch (s: like switch) is
			-- Set `switch' to `s'.
		require
			valid_arg: s /= Void
		do
			switch := s
		end

	set_case_list (c: like case_list) is
			-- Set `case_list' to `c'.
		do
			case_list := c
		end

	set_else_part (e: like else_part) is
			-- Set `else_part' to `e'.
		do
			else_part := e
		end

end -- class INSPECT_AS
