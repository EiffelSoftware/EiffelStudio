-- Node for Eiffel terminals

class VALUE_AS

inherit

	EXPR_AS
		redefine
			type_check, byte_node
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

end
