indexing

	description: 
		"AST representation for Eiffel terminals.";
	date: "$Date$";
	revision: "$Revision$"

class VALUE_AS

inherit

	EXPR_AS

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

feature {NONE} -- Initilization

	set is
			-- Yacc initialization
		do
			terminal ?= yacc_arg (0);
		ensure then
			terminal_exists: terminal /= Void
		end;

feature -- Properties

	terminal: ATOMIC_AS;
			-- terminal

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (terminal, other.terminal)
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.format_ast (terminal)
		end;

feature {VALUE_AS, USER_CMD, CMD}	-- Replication

	set_terminal (t: like terminal) is
		require
			valid_arg: t /= Void
		do
			terminal := t
		end;

end -- class VALUE_AS
