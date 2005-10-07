indexing
	description: "Shared cache mutex guard"
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_CACHE_MUTEX_GUARD

feature -- Access

	guard: CACHE_MUTEX_GUARD is
			-- singleton guard
		indexing
			once_status: "global"
		once
			create Result
		ensure
			result_not_void: Result /= Void
		end

end -- class SHARED_CACHE_MUTEX_GUARD
