-- Abstract class for byte node instruction

class INSTR_B 

inherit

	BYTE_NODE

feature -- Debugger

	make_breakable (ba: BYTE_ARRAY) is
			-- Allow current instruction to be followed by a breakpoint token
			-- hook when generating debuggable byte code.
		do
			if context.debug_mode then
				context.record_breakable (ba);
			end;
		end;

end
