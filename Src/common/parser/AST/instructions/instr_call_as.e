indexing

	description: 
		"AST representation of a call as an instruction";
	date: "$Date$";
	revision: "$Revision$"

class INSTR_CALL_AS

inherit

	INSTRUCTION_AS

feature {AST_FACTORY} -- Initialization

	initialize (c: like call; s, l: INTEGER) is
			-- Create a new INSTR_CALL AST node.
		require
			c_not_void: c /= Void
		do
			call := c
			start_position := s
			line_number := l
		ensure
			call_set: call = c
			start_position_set: start_position = s
			line_number_set: line_number = l
		end

feature {NONE} -- Initialization

	set is
			-- Yacc initialization
		do
			call ?= yacc_arg (0);
			start_position := yacc_position;
			line_number    := yacc_line_number
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
