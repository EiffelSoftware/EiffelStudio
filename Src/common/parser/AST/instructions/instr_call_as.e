indexing

	description: 
		"AST representation of a call as an instruction";
	date: "$Date$";
	revision: "$Revision$"

class INSTR_CALL_AS

inherit

	INSTRUCTION_AS

feature {NONE} -- Initialization

	set is
			-- Yacc initialization
		do
			call ?= yacc_arg (0);
			start_position := yacc_position
		ensure then
			call_exists: call /= Void;
		end;

feature -- Properties

	call: CALL_AS;
			-- Call instruction

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (call, other.call)
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_breakable;
			ctxt.format_ast (call)
		end;

feature {INSTR_CALL_AS, CMD, USER_CMD, ROUTINE_AS_B} -- Replication

	set_call (c: like call) is
			-- Set `call' to `c'.
		require
			valid_arg: c /= Void
		do
			call := c;
		end;

end -- class INSTR_CALL_AS
