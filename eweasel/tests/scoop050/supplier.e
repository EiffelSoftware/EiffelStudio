note
	description: "A supplier class with a query."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	SUPPLIER

create
	make

feature {NONE} -- Initialization

	make (a_shared: like shared)
			-- Initialization for `Current'.
		do
			shared := a_shared
		end

feature -- Access

	shared: separate ANY
			-- The shared object.

	perform_query: INTEGER
			-- A stub query.
		do
			Result := do_query (shared)
		end

feature {NONE} -- Implementation

	do_query (a_shared: like shared): INTEGER
		do
			Result := a_shared.out.count
		end

end
