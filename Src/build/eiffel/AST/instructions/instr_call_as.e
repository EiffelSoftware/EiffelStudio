-- Abstract description of a call as an instruction

class INSTR_CALL_AS

inherit

	INSTRUCTION_AS
		redefine
			simple_format
		end

feature -- Attributes

	call: CALL_AS;
			-- Call instruction

feature -- Initialization

	set is
			-- Yacc initialization
		do
			call ?= yacc_arg (0);
		ensure then
			call_exists: call /= Void;
		end;

feature -- Equivalence

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

feature -- Formatter

    simple_format (ctxt: FORMAT_CONTEXT) is
    		-- Reconstitute text.
    	do
    		ctxt.put_breakable;
    		call.simple_format (ctxt);
    	end;

feature {INSTR_CALL_AS, CMD, USER_CMD} -- Replication

    set_call (c: like call) is
    	require
    		valid_arg: c /= Void
    	do
    		call := c;
    	end;

end
