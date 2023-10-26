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
			b: BAR
		do
			create b.make (123)
			print (b.bargen ("BarOuch"))
			
		end

feature -- Status

feature -- Access

feature -- Change

feature {NONE} -- Implementation

invariant
--	invariant_clause: True

end
