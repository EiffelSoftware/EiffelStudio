-- Abstract description ao an alternative of a multi_branch instruction

class CASE_AS

inherit

	AST_EIFFEL
		redefine
			simple_format
		end

feature -- Attributes

	interval: EIFFEL_LIST [INTERVAL_AS];
			-- Interval of the alternative

	compound: EIFFEL_LIST [INSTRUCTION_AS];
			-- Compound

feature -- Initialization

	set is
			-- Yacc initialization
		do
			interval ?= yacc_arg (0);
			compound ?= yacc_arg (1);
		ensure then
			interval_exists: interval /= Void;
		end;

feature -- Formatter

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.begin;
			ctxt.put_text_item (ti_When_keyword);
			ctxt.put_space;
			ctxt.set_separator (ti_Comma);
			ctxt.no_new_line_between_tokens;
			interval.simple_format (ctxt);
			ctxt.put_space;
			ctxt.put_text_item (ti_Then_keyword);
			ctxt.put_space;
			if compound /= void then
				ctxt.indent_one_more;
				ctxt.next_line;
				ctxt.set_separator (ti_Semi_colon);
				ctxt.new_line_between_tokens;
				compound.simple_format(ctxt)
			end;	
			ctxt.put_breakable;
			ctxt.commit
		end;			

feature {CASE_AS}	-- Replication

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

end
