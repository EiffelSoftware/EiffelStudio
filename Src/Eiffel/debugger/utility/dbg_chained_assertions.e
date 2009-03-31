note
	description: "Summary description for {DBG_CHAINED_ASSERTIONS}."
	date: "$Date$"
	revision: "$Revision$"

class
	DBG_CHAINED_ASSERTIONS

create
	make

feature {NONE} -- Initialization

	make (a_written_in: INTEGER; a_precondition: detachable REQUIRE_AS; a_postcondition: detachable ENSURE_AS)
			-- Initialize Current
		require
			a_written_in_valid: a_written_in > 0
		do
			written_in := a_written_in
			precondition := a_precondition
			postcondition := a_postcondition
		end

feature -- Access

	written_in: INTEGER
			-- Class id where assertion are written

	precondition: REQUIRE_AS
			-- preconditions

	postcondition: ENSURE_AS
			-- postconditions

end
