indexing
	description: "Mutex base lock to prevent mutlitple processes from concurrent access to IO sensitive functions."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
	
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class CACHE_MUTEX_GUARD
