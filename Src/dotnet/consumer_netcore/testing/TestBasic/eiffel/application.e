note
	description: "[
			Objects that ...
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		local
			abc: ABC
		do
			create abc.make
		end

feature -- Status

feature -- Access

feature -- Change

feature {NONE} -- Implementation

invariant
--	invariant_clause: True

end
