indexing

	description: "Abstract description of a multi_branch instruction";
	date: "$Date$";
	revision: "$Revision$"

class INSPECT_AS

inherit

	INSTRUCTION_AS

feature -- Attributes

	switch: EXPR_AS;
			-- Expression to inspect

	case_list: EIFFEL_LIST [CASE_AS];
			-- Alternatives

	else_part: EIFFEL_LIST [INSTRUCTION_AS];
			-- Else part

feature -- Initialization

	set is
			-- Yacc alternatives
		do
			switch ?= yacc_arg (0);
			case_list ?= yacc_arg (1);
			else_part ?= yacc_arg (2);
		ensure then
			switch_exists: switch /= Void
		end;

feature -- Equivalence

	is_equiv (other: INSTRUCTION_AS): BOOLEAN is
			-- Is `other' instruction equivalent to Current?
		local
			inspect_as: INSPECT_AS
		do
			inspect_as ?= other
			if inspect_as /= Void then
				-- May be equivalent
				Result := equiv (inspect_as)
			else
				-- NOT equivalent
				Result := False
			end
		end;

	equiv (other: like Current): BOOLEAN is
			-- Is `other' inspect_as equivalent to Current?
		do
			Result := deep_equal (switch, other.switch)
			if Result then
				-- May be equivalent
				Result := deep_equal (case_list, other.case_list)
				if Result then
					-- May be equivalent
					Result := deep_equal (else_part, other.else_part)
				end
			end
		end;

feature -- Simple formatting

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_breakable;
			ctxt.put_text_item (ti_Inspect_keyword);
			ctxt.put_space;
			ctxt.indent;
			ctxt.format_ast (switch);
			ctxt.exdent;
			ctxt.new_line;
			if case_list /= void then
				ctxt.set_separator (Void);
				ctxt.set_no_new_line_between_tokens;
				ctxt.reversed_format_list (case_list);
			end;
			if else_part /= void then
				ctxt.put_text_item (ti_Else_keyword);
				ctxt.indent;
				ctxt.new_line;
				ctxt.set_separator (ti_Semi_colon);
				ctxt.set_new_line_between_tokens;
				ctxt.reversed_format_list (else_part);
				ctxt.new_line;
				ctxt.exdent;
				ctxt.put_breakable;
			end;
			ctxt.put_text_item (ti_End_keyword);
		end;

feature {INSPECT_AS} -- Replication

	set_switch (s: like switch) is
			-- Set `switch' to `s'.
		require
			valid_arg: s /= Void
		do
			switch := s
		end;

	set_case_list (c: like case_list) is
			-- Set `case_list' to `c'.
		do
			case_list := c
		end;

	set_else_part (e: like else_part) is
			-- Set `else_part' to `e'.
		do
			else_part := e
		end;

end -- class INSPECT_AS
