indexing

	description:
			"Abstract description ao an alternative of a multi_branch %
			%instruction. Version for Bench.";
	date: "$Date$";
	revision: "$Revision$"

class CASE_AS_B

inherit

	CASE_AS
		redefine
			interval, compound
		end;

	AST_EIFFEL_B
		undefine
			line_number

		redefine
			type_check, byte_node, find_breakable, fill_calls_list, replicate
		end

feature -- Attributes

	interval: EIFFEL_LIST_B [INTERVAL_AS_B];
			-- Interval of the alternative

	compound: EIFFEL_LIST_B [INSTRUCTION_AS_B];
			-- Compound

feature {NONE} -- Type check, byte code production, dead code removal

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
			Result.set_line_number (line_number)
		end;

feature -- Debugging

	find_breakable is
		do
			if compound /= Void then
				compound.find_breakable
			end;
			record_break_node
		end

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

end -- class CASE_AS_B
