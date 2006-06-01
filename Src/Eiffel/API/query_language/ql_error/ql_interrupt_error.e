indexing
	description: "Error that interrupts a query language process."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_INTERRUPT_ERROR

inherit
	QL_ERROR

feature -- Access

	code: STRING is
			-- Interrupt code
		do
			Result := "INTERRUPT"
		end

	text: STRING is
			-- The error message.
		do
			Result := "Interrupted by user."
		end

end
