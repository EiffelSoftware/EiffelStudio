-- Abstract class for instruction AS node

deferred class INSTRUCTION_AS

inherit

	AST_EIFFEL
		redefine
			byte_node,
			find_breakable
		end

feature

	byte_node: INSTR_B is
			-- Associated byte code
		do
		ensure then
			False
		end

feature -- Debugger
 
	find_breakable is
			-- Look for instruction (this node IS an instruction).
			-- This will be redefined for non-atomic instructions like loop
			-- or inspect statements to actually propagate the message.
		do
			record_break_node;		-- Most node are atomic instructions
		end;
 
end
