-- Abstract description ao an alternative of a multi_branch instruction

class CASE_AS

inherit

	AST_EIFFEL
		redefine
			type_check, byte_node,
			find_breakable
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
		do
			!!Result;
			Result.set_interval (interval.byte_node);
			if compound /= Void then
				Result.set_compound (compound.byte_node);
			end;
		end;

feature -- Debugging

	find_breakable is
		do
			if compound /= Void then
				compound.find_breakable
			end
		end

end
