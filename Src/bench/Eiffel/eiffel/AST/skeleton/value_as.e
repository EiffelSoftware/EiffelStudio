indexing
	description: "Node for Eiffel terminals. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class VALUE_AS

inherit
	EXPR_AS
		redefine
			type_check, byte_node
		end

feature {AST_FACTORY} -- Initialization

	initialize (t: like terminal) is
			-- Create a new VALUE AST node.
		require
			t_not_void: t /= Void
		do
			terminal := t
		ensure
			terminal_set: terminal = t
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

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
				--| We must reset the current class type, since there is no feature here.
			ctxt.set_type_creation (Void)
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
