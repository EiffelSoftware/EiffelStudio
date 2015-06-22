note
	description: "{MEMORY_MANAGER} handles memory allocation for ESTRINGs."
	author: "Mischael Schill"
	date: "$Date$"
	revision: "$Revision$"

class
	MEMORY_MANAGER

feature {MEMORY_MANAGER_ACCESS}

	allocate_memory (a_count: INTEGER_32): MANAGED_POINTER
		require
			a_count >= 0
		do
			create Result.make (a_count)
		end

end
