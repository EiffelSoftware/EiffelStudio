indexing
	description: "Abstract class for instruction AS node. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

deferred class INSTRUCTION_AS

inherit
	AST_EIFFEL
		undefine
			byte_node
		redefine
			number_of_stop_points, line_number,
			find_breakable, format, type_check
		end

feature -- Access

	line_number : INTEGER

	start_position: INTEGER
			-- Start position of AST

	number_of_stop_points: INTEGER is
			-- Number of stop points for AST
		do
			Result := 1
		end

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
			record_break_node		-- Most node are atomic instructions
		end

feature -- Output

	format (ctxt: FORMAT_CONTEXT) is
			-- Format Current instruction.
		do
			simple_format (ctxt)
		end

feature -- Update

	type_check is
			-- Record the current position and type check the AST node.
		do
			Error_handler.set_error_position (start_position)
			perform_type_check
		end

	perform_type_check is
			-- Type check the AST node.
		deferred
		end;	
 
end -- class INSTRUCTION_AS
