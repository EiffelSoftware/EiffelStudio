deferred class INTERNAL_AS_B

inherit

	INTERNAL_AS
		redefine
			compound
		end;

	ROUT_BODY_AS_B
		undefine
			has_instruction, index_of_instruction,
			number_of_stop_points
		redefine
			type_check, byte_node,
			find_breakable, 
			fill_calls_list, replicate, empty
		end

feature -- Attributes

	compound: EIFFEL_LIST_B [INSTRUCTION_AS_B];
			-- Compound

feature -- test for empty body

	empty : BOOLEAN is
		do
			Result := (compound = Void) or else (compound.empty)
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
			Result.record_separate_calls_on_arguments
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
