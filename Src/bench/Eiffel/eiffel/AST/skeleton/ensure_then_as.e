indexing
	description: "AST representation of a `ensure then' structure."
	date: "$Date$"
	revision: "$Revision$"

class ENSURE_THEN_AS

inherit
	ENSURE_AS
		redefine
			is_then
		end

feature -- Properties

	is_then: BOOLEAN is True
			-- Is the assertion list an "ensure then" part ?

end -- class ENSURE_THEN_AS
