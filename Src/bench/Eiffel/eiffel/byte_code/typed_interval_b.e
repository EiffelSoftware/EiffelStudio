indexing
	description: "Inspect interval of particular type."
	date: "$Date$"
	revision: "$Revision$"

class TYPED_INTERVAL_B [reference G -> INTERVAL_VAL_B]

inherit
	INTERVAL_B
		redefine
			lower
		end

create
	make

feature -- Access

	lower: G
			-- Lower bound

end
