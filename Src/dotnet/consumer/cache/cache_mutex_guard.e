indexing
	description: "Mutex base lock to prevent mutlitple processes from concurrent access to IO sensitive functions."
	date: "$Date$"
	revision: "$Revision$"

class
	CACHE_MUTEX_GUARD

inherit
	CACHE_SETTINGS
		export
			{NONE} all
		end
		
	DISPOSABLE

create
	default_create

feature -- Basic Operation

	lock is
			-- lock cache
		do
			internal_count.set_item (count + 1)
			if count = 1 then
					-- first lock
				perform_locking
			end
		ensure
			count_incremented: count = old count + 1
			is_locked: is_locked
		end
		
	unlock is
			-- lock cache
		require
			count_positive: count > 0
			is_locked: is_locked
		do
			internal_count.set_item (count - 1)
			if count = 0 then
				perform_unlocking
			end
		ensure
			count_decremented: count = old count - 1
		end

feature -- Access

	count: INTEGER is
			-- number of locks
		do
			Result := internal_count.item
		ensure
			count_positive: count >= 0
		end
			
	is_locked: BOOLEAN is
			-- is cache locked?
		do
			Result := count > 0
		end
	
feature -- DISPOSABLE

	dispose is
			-- clean up
		do
			check
				not_is_locked: not is_locked
				zero_count: count = 0
			end
		end
			
feature {NONE} -- Implementation

	perform_locking is
			-- performs locking
		local
			l_wait: BOOLEAN
		do
			l_wait := guard.wait_one
		ensure
			is_locked: is_locked
		end

	perform_unlocking is
			-- performs locking
		do
			guard.release_mutex
		ensure
			not_locked: not is_locked
		end

	guard: SYSTEM_MUTEX is
			-- guard implementation
		once
			create Result.make (False, cache_lock_id)
		ensure
			result_not_void: Result /= Void
		end
		
	internal_count: INTEGER_REF is
			-- internal count
		once
			create Result
		end
	
end -- class CACHE_MUTEX_GUARD
