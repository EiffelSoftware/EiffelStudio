indexing
	description: "AST representation of binary comparison operation."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	COMPARISON_AS

inherit
	BINARY_AS
		redefine
			balanced
		end

feature -- Properties

	balanced: BOOLEAN is True
			-- Is the current binary operation subject to the balancing
			-- rule proper to simple numeric types ?

end -- class COMPARISON_AS
