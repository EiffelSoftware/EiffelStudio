indexing
	description: "Shared reference to unique instance of NAMES_HEAP"
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_NAMES_HEAP

feature -- Access

	names_heap: NAMES_HEAP is
			-- Unique instance of NAMES_HEAP in system,
			-- ie SYSTEM_I.names.
		once
			Result := (create {SHARED_WORKBENCH}).System.names
		ensure
			Result_not_void: Result /= Void
		end

end -- class SHARED_NAMES_HEAP
