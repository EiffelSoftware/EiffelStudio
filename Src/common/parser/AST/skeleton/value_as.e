indexing
	description: 
		"AST representation for Eiffel terminals."
	date: "$Date$"
	revision: "$Revision$"

class
	VALUE_AS

inherit
	EXPR_AS

create
	initialize

feature {AST_FACTORY, EIFFEL_PARSER} -- Initialization

	initialize (t: like terminal) is
			-- Create a new VALUE AST node.
		require
			t_not_void: t /= Void
		do
			terminal := t
		ensure
			terminal_set: terminal = t
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_value_as (Current)
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

--feature {AST_EIFFEL} -- Output
--
--	simple_format (ctxt: FORMAT_CONTEXT) is
--			-- Reconstitute text.
--		do
--			ctxt.format_ast (terminal)
--		end

feature {VALUE_AS}	-- Replication

	set_terminal (t: like terminal) is
		require
			valid_arg: t /= Void
		do
			terminal := t
		end

end -- class VALUE_AS
