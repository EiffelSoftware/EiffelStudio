indexing

	description: "Node for Eiffel terminals.";
	date: "$Date$";
	revision: "$Revision$"

class VALUE_AS

inherit

	EXPR_AS

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

feature -- Simple formatting

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
