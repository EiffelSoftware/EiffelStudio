-- Abstract description ao an alternative of a multi_branch instruction

class CASE_AS

inherit

	AST_EIFFEL
		redefine
			type_check, byte_node,
			find_breakable, format,
			fill_calls_list, replicate
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

feature -- Type check, byte code production, dead code removal

	type_check is
			-- Type check a multi-branch alternative
		do
			interval.type_check;
			if compound /= Void then
				compound.type_check;
			end;
		end;

	byte_node: CASE_B is
			-- Associated byte code
		local
			tmp: BYTE_LIST [BYTE_NODE];
			tmp2: BYTE_LIST [BYTE_NODE]
		do
			tmp := interval.byte_node;
			tmp := tmp.remove_voids;
			if compound /= Void then
				tmp2 := compound.byte_node
			end;
			if tmp /= Void then
				!!Result;
				Result.set_interval (tmp);
				if compound /= Void then
					Result.set_compound (tmp2);
				end
			end;
		end;


feature -- Debugging

	find_breakable is
		do
			if compound /= Void then
				compound.find_breakable
			end;
			record_break_node
		end

feature -- Formatter

	format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.begin;
			ctxt.put_keyword ("when ");
			ctxt.set_separator (",");
			ctxt.no_new_line_between_tokens;
			interval.format (ctxt);
			ctxt.put_keyword (" then ");
			if compound /= void then
				ctxt.indent_one_more;
				ctxt.next_line;
				ctxt.set_separator(";");
				ctxt.new_line_between_tokens;
				compound.format(ctxt)
			end;	
			ctxt.put_breakable;
			ctxt.commit
		end;			

feature -- Replication

	fill_calls_list (l: CALLS_LIST) is
			-- find calls to Current
		do	
			interval.fill_calls_list (l);
			if compound /= void then
				compound.fill_calls_list (l)
			end;
		end;

	replicate (ctxt: REP_CONTEXT): like Current is
			-- Adapt to replication
		do
			Result := clone (Current);
			Result.set_interval (interval.replicate (ctxt));
			if compound /= void then
				Result.set_compound (
					compound.replicate (ctxt))
			end
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
