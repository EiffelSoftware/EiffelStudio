indexing
	description: "Binary comparison operation. Version for Bench"
	date: "$Date$"
	revision: "$Revision$"

deferred class COMPARISON_AS

inherit
	BINARY_AS
		redefine
			balanced, operator_is_special, operator_is_keyword
		end

feature -- Properties

	balanced: BOOLEAN is True
			-- Is the current binary operation subject to the balancing
			-- rule proper to simple numeric types ?

	operator_is_special: BOOLEAN is True
	
	operator_is_keyword: BOOLEAN is False

end -- class COMPARISON_AS
