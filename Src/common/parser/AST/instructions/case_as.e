indexing

	description: 
		"AST representation ao an alternative of a multi_branch instruction";
	date: "$Date$";
	revision: "$Revision$"

class CASE_AS

inherit

	AST_EIFFEL
		redefine
			number_of_stop_points
		end

feature {NONE} -- Initialization

	set is
			-- Yacc initialization
		do
			interval ?= yacc_arg (0);
			compound ?= yacc_arg (1);
		ensure then
			interval_exists: interval /= Void;
		end;

feature -- Properties

	interval: EIFFEL_LIST [INTERVAL_AS];
			-- Interval of the alternative

	compound: EIFFEL_LIST [INSTRUCTION_AS];
			-- Compound

feature -- Access

	number_of_stop_points: INTEGER is
			-- Number of stop points
		do
			if compound /= Void then
				Result := compound.number_of_stop_points
			end;
			Result := Result + 1
		end;

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_text_item (ti_When_keyword);
			ctxt.put_space;
			ctxt.set_separator (ti_Comma);
			ctxt.set_no_new_line_between_tokens;
			ctxt.format_ast (interval);
			ctxt.put_space;
			ctxt.put_text_item_without_tabs (ti_Then_keyword);
			ctxt.put_space;
			ctxt.new_line;
			if compound /= void then
				ctxt.indent;
				ctxt.set_separator (ti_Semi_colon);
				ctxt.set_new_line_between_tokens;
				ctxt.format_ast (compound);
				ctxt.new_line;
				ctxt.exdent;
			end;
			ctxt.put_breakable;
		end;

feature {CASE_AS} -- Replication

	set_interval (i: like interval) is
		require
			valid_arg: i /= Void
		do
			interval := i
		end;

	set_compound (c: like compound) is
		do
			compound := c
		end;

end -- class CASE_AS
