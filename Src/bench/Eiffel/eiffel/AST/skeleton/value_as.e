indexing
	description: "Node for Eiffel terminals. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class VALUE_AS

inherit
	EXPR_AS
		redefine
			type_check, byte_node, 
			fill_calls_list, replicate
		end

feature {NONE} -- Initilization

	set is
			-- Yacc initialization
		do
			terminal ?= yacc_arg (0)
		ensure then
			terminal_exists: terminal /= Void
		end

feature -- Attributes

	terminal: ATOMIC_AS
			-- terminal

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (terminal, other.terminal)
		end

feature -- Type check, byte code and dead code removal

	value_i: VALUE_I is
			-- Terminal value
		do
			Result := terminal.value_i
		end

	type_check is
			-- Type check atomic value
		do
			terminal.type_check
		end

	byte_node: EXPR_B is
			-- Associated byte node
		do
			Result := terminal.byte_node
		end

feature -- Replicate

	-- Only one type of terminal need treatment: ARRAY_AS
	-- for others, Do nothing

	fill_calls_list (l: CALLS_LIST) is
			-- find calls to Current
		do
			terminal.fill_calls_list (l)
		end

	replicate (ctxt: REP_CONTEXT): like Current is
			-- Adapt to replication
		do
			Result := clone (Current)
			Result.set_terminal (terminal.replicate (ctxt))
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.format_ast (terminal)
		end

feature {VALUE_AS, USER_CMD, CMD}	-- Replication

	set_terminal (t: like terminal) is
		require
			valid_arg: t /= Void
		do
			terminal := t
		end

end -- class VALUE_AS
