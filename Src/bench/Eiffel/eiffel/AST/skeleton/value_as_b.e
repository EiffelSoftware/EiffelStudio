indexing

	description: "Node for Eiffel terminals. Version for Bench.";
	date: "$Date$";
	revision: "$Revision$"

class VALUE_AS_B

inherit

	VALUE_AS
		redefine
			terminal
		end;

	EXPR_AS_B
		redefine
			type_check, byte_node, 
			fill_calls_list, replicate
		end

feature -- Attributes

	terminal: ATOMIC_AS_B;
			-- terminal

feature -- Type check, byte code and dead code removal

	value_i: VALUE_I is
			-- Terminal value
		do
			Result := terminal.value_i;
		end;

	type_check is
			-- Type check atomic value
		do
			terminal.type_check;
		end;

	byte_node: EXPR_B is
			-- Associated byte node
		do
			Result := terminal.byte_node;
		end;

feature -- Replicate

	-- Only one type of terminal need treatment: ARRAY_AS
	-- for others, Do nothing

	fill_calls_list (l: CALLS_LIST) is
			-- find calls to Current
		do
			terminal.fill_calls_list (l);
		end;

	replicate (ctxt: REP_CONTEXT): like Current is
			-- Adapt to replication
		do
			Result := clone (Current);
			Result.set_terminal (terminal.replicate (ctxt))
		end;

end -- class VALUE_AS_B
