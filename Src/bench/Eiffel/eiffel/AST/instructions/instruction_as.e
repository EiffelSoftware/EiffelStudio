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
			number_of_breakpoint_slots, 
			line_number,
			type_check
		end

feature -- Access

	line_number : INTEGER

	start_position: INTEGER
			-- Start position of AST

	number_of_breakpoint_slots: INTEGER is
			-- Number of stop points for AST
		do
			Result := 1
		end

	byte_node: INSTR_B is
			-- Associated byte code
		deferred
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
		end

feature {INTERNAL_AS} -- Status report

	starts_with_parenthesis: BOOLEAN is
			-- Is the first format item a "(".
			-- See: INTERNAL_AS.format_compound.
		do
			-- False
		end

end -- class INSTRUCTION_AS
