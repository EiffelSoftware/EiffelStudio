indexing
	description: "Abstract class for instruction AS node. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

deferred class INSTRUCTION_AS

inherit
	AST_EIFFEL
		redefine
			number_of_breakpoint_slots
		end

feature -- Access

	number_of_breakpoint_slots: INTEGER is
			-- Number of stop points for AST
		do
			Result := 1
		end

feature {INTERNAL_AS, AST_FORMATTER_VISITOR} -- Status report

	starts_with_parenthesis: BOOLEAN is
			-- Is the first format item a "(".
			-- See: INTERNAL_AS.format_compound.
		do
			-- False
		end

end -- class INSTRUCTION_AS
