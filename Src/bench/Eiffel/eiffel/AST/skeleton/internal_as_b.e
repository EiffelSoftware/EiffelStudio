deferred class INTERNAL_AS_B

inherit

	INTERNAL_AS
		redefine
			compound
		end;

	ROUT_BODY_AS_B
		undefine
			simple_format, has_instruction,
			index_of_instruction
		redefine
			type_check, byte_node,
			find_breakable, format,
			fill_calls_list, replicate
		end

feature -- Attributes

	compound: EIFFEL_LIST_B [INSTRUCTION_AS_B];
			-- Compound

feature -- Type check, byte code and dead code removal

	type_check is
			-- Type check compound
		do
			if compound /= Void then
				compound.type_check;
			end;
		end;

	byte_node: STD_BYTE_CODE is
			-- Byte code associated to `compound'
		do
			!!Result;
			if compound /= Void then
				Result.set_compound (compound.byte_node);
			end;
		end;

feature -- Debugger
 
	find_breakable is
			-- Look for breakable instructions.
		do
			if compound /= Void then
				compound.find_breakable;
			end;
			record_break_node;
		end;

feature -- Formatter

	format (ctxt: FORMAT_CONTEXT_B) is
			-- Reconstitute text.
		do
			ctxt.begin;
			ctxt.put_text_item (begin_keyword);
			if compound /= Void then
				ctxt.indent_one_more;
				ctxt.next_line;
				ctxt.set_separator (ti_Semi_colon);
				ctxt.new_line_between_tokens;
				compound.format(ctxt);
			end;
			ctxt.put_breakable;
			ctxt.commit;
		end;

feature -- Replication
	
	fill_calls_list (l: CALLS_LIST) is
			-- find calls to Current is
		do
			if compound /= void then
				compound.fill_calls_list (l)
			end
		end;

	replicate (ctxt: REP_CONTEXT): like Current is
			-- Adapt to Replication
		do
			Result := clone (Current);
			if compound /= void then
				Result.set_compound (
					compound.replicate (ctxt.new_ctxt))
			end
		end;			

end -- class INTERNAL_AS_B
