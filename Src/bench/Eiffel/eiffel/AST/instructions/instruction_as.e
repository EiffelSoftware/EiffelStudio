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
			type_check
		end

feature -- Access

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
			perform_type_check
		end

	perform_type_check is
			-- Type check the AST node.
		deferred
		end

feature {INTERNAL_AS, AST_FORMATTER_VISITOR} -- Status report

	starts_with_parenthesis: BOOLEAN is
			-- Is the first format item a "(".
			-- See: INTERNAL_AS.format_compound.
		do
			-- False
		end

end -- class INSTRUCTION_AS
