note
	description: "Summary description for {MEMORY_MANAGER_ACCESS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	MEMORY_MANAGER_ACCESS

feature {NONE}

	manager: separate MEMORY_MANAGER
		once ("PROCESS")
			create Result
		end

	allocate_memory (a_count: INTEGER_32): separate MANAGED_POINTER
		require
			a_count > 0
		do
			Result := allocate_memory_wrapper (a_count, manager)
		end

	allocate_memory_wrapper (a_count: INTEGER_32; a_manager: like manager): separate MANAGED_POINTER
		require
			a_count > 0
		do
			Result := a_manager.allocate_memory (a_count)
		end

	retrieve_item (a_separate_area: separate MANAGED_POINTER): POINTER
		do
			Result := a_separate_area.item
		end

end
