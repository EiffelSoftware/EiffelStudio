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
		ensure then
			call_exists: call /= Void;
		end;

feature -- Properties

	call: CALL_AS;
			-- Call instruction

feature -- Comparison

	is_equiv (other: INSTRUCTION_AS): BOOLEAN is
			-- Is `other' instruction equivalent to Current?
		local
			instr_call_as: INSTR_CALL_AS
		do
			instr_call_as ?= other
			if instr_call_as /= Void then
				-- May be equivalent
				Result := equiv (instr_call_as)
			else
				-- NOT equivalent
				Result := False
			end
		end;

	equiv (other: like Current): BOOLEAN is
			-- Is `other' instr_call_as equivalent to Current?
		do
			Result := deep_equal (call, other.call)
		end;

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_breakable;
			ctxt.format_ast (call)
		end;

feature {INSTR_CALL_AS, CMD, USER_CMD} -- Replication

	set_call (c: like call) is
			-- Set `call' to `c'.
		require
			valid_arg: c /= Void
		do
			call := c;
		end;

end -- class INSTR_CALL_AS
