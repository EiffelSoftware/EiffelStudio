-- Node for Eiffel terminals

class VALUE_AS

inherit

	EXPR_AS
		redefine
			simple_format
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

feature -- Formatter

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			terminal.simple_format (ctxt);
		end;

feature {VALUE_AS, USER_CMD, CMD}	-- Replication

	set_terminal (t: like terminal) is
		require
			valid_arg: t /= Void
		do
			terminal := t
		end;

end
