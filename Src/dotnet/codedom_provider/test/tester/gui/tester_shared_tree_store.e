indexing
	description: "Shared instance of {TESTER_TREE_STORE}"
	date: "$Date$"
	revision: "$Revision$"

class
	TESTER_SHARED_TREE_STORE

feature -- Access

	Store: TESTER_TREE_STORE is
			-- Store
		once
			create Result.load
		end
		
end -- class TESTER_SHARED_TREE_STORE
