-- Node for Eiffel terminals

class VALUE_AS

inherit

	EXPR_AS
		redefine
			type_check, byte_node, format,
			fill_calls_list, replicate
		end

feature -- Attributes

	terminal: ATOMIC_AS;
			-- terminal

feature -- Initilization

	set is
			-- Yacc initialization
		do
			terminal ?= yacc_arg (0);
		ensure then
			terminal_exists: terminal /= Void
		end;

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

feature -- Formatter

	format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			terminal.format (ctxt);
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

feature {VALUE_AS}	-- Replication

	set_terminal (t: like terminal) is
		require
			valid_arg: t /= Void
		do
			terminal := t
		end;

end
