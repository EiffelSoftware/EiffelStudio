note
	description: "[
			Objects that ...
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	SCM_CHANGE

inherit
	ANY
		rename
		export
		undefine
		redefine
		select
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		do
			
		end

feature -- Status

feature -- Access

feature -- Change

feature {NONE} -- Implementation

invariant
--	invariant_clause: True 

end
