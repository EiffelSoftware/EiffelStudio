indexing

	description: "Abstract class for instruction AS node. Version for Bench.";
	date: "$Date$";
	revision: "$Revision$"

deferred class INSTRUCTION_AS_B

inherit

	INSTRUCTION_AS;

	AST_EIFFEL_B
		undefine
			byte_node
		redefine
			find_breakable, format
		end

feature

	byte_node: INSTR_B is
			-- Associated byte code
		deferred
		end

feature -- Debugger
 
	find_breakable is
			-- Look for instruction (this node IS an instruction).
			-- This will be redefined for non-atomic instructions like loop
			-- or inspect statements to actually propagate the message.
		do
			record_break_node;		-- Most node are atomic instructions
		end;

feature -- Output

	format (ctxt: FORMAT_CONTEXT_B) is
			-- Format Current instruction.
		do
			simple_format (ctxt)
		end;
 
end -- class INSTRUCTION_AS_B
