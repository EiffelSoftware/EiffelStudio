indexing

	description: "Abstract description of a multi_branch instruction";
	date: "$Date$";
	revision: "$Revision$"

class INSPECT_AS

inherit

	INSTRUCTION_AS
		redefine
			simple_format
		end;

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
			ctxt.begin;
			ctxt.put_breakable;
			ctxt.put_text_item (ti_Inspect_keyword);
			ctxt.put_space;
			ctxt.indent_one_more;
			switch.simple_format (ctxt);
			ctxt.indent_one_less;
			ctxt.next_line;
			if case_list /= void then
				ctxt.set_separator (Void);
				ctxt.new_line_between_tokens;
				case_list.reversed_simple_format (ctxt);
				ctxt.next_line;
			end;
			if else_part /= void then
				ctxt.put_text_item (ti_Else_keyword);
				ctxt.indent_one_more;
				ctxt.next_line;
				ctxt.set_separator (ti_Semi_colon);
				ctxt.new_line_between_tokens;
				else_part.simple_format(ctxt);
				ctxt.indent_one_less;
				ctxt.next_line;
				ctxt.put_breakable;
			end;
			ctxt.put_text_item (ti_End_keyword);
			ctxt.commit;
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
