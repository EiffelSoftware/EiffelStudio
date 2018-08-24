note
	description: "Assertion clause with its origin type."
	date: "$Date$"
	revision: "$Revision$"

class
	E2B_ASSERT_ORIGIN

create
	make

feature {NONE}	-- Initialization

	make (a_clause: ASSERT_B; a_origin: CLASS_C)
			-- Create an assertion with `a_clause' coming from `a_origin'.
		require
			clause_exists: attached a_clause
			origin_exists: attached a_origin
		do
			clause := a_clause
			origin := a_origin
		ensure
			clause_set: clause = a_clause
			origin_set: origin = a_origin
		end

feature -- Access

	clause: ASSERT_B
			-- Assertion clause.

	origin: CLASS_C
			-- The class where it was defined.

invariant
	clause_exists: attached clause
	origin_exists: attached origin

end
