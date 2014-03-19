note
	description: "[
			Objects that ...
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	DEP

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		do
			create fake.make
		end

feature -- Access

	fake: FAKE

feature -- Change

feature {NONE} -- Implementation

invariant
--	invariant_clause: True 

end
