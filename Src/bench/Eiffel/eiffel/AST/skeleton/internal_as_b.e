deferred class INTERNAL_AS

inherit

	ROUT_BODY_AS
		redefine
			type_check, byte_node,
			find_breakable, format,
			fill_calls_list, replicate
		end

feature -- Attributes

	compound: EIFFEL_LIST [INSTRUCTION_AS];
			-- Compound

feature -- Initialization

	set is
			-- Yacc initialization
		do
			compound ?= yacc_arg (0);
		end

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

	format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.begin;
			ctxt.put_keyword(begin_keyword);
			if compound /= void then
				ctxt.indent_one_more;
				ctxt.next_line;
				ctxt.set_separator(";");
				ctxt.new_line_between_tokens;
				ctxt.separator_is_special;
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

	Replicate (ctxt: REP_CONTEXT): like Current is
			-- Adapt to Replication
		do
			Result := twin;
			if compound /= void then
				Result.set_compound (
					compound.replicate (ctxt.new_ctxt))
			end
		end;			

feature {INTERNAL_AS} -- Replication
	
	set_compound (c: like compound) is
		do
			compound := c;
		end;	
feature {} -- Formatter
	
	begin_keyword: STRING is 
		deferred
		end;
	
 
end
