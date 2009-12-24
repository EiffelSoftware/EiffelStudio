note
	description: "Management of children threads in .NET. To be used only by THREAD_CONTROL and THREAD. It should not be used by users"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	THREAD_DOTNET_CONTROL

feature {THREAD_CONTROL} -- Implementation

	join_all
			-- The calling thread waits for all other threads to terminate.
		local
			l_list: like childrens
			l_item: detachable THREAD
			l_current_thread_id: like current_thread_id
			done: BOOLEAN
		do
			from
				l_current_thread_id := current_thread_id
			until
				done
			loop
				childrens_mutex.lock
				l_list := childrens (l_current_thread_id)
				if not l_list.is_empty then
					l_item := l_list.first
				else
					done := True
					l_item := Void
				end
				childrens_mutex.unlock
				if l_item /= Void then
					l_item.join
				end
			end
		end

	add_child_to_parent (parent_thread_id:  like current_thread_id; child_thread: THREAD)
		require
			thread_exists: child_thread /= Void
		local
			l_table: like childrens
		do
			childrens_mutex.lock
			l_table := childrens (parent_thread_id)
			l_table.extend (child_thread)
			childrens_mutex.unlock
		end

	remove_child_from_parent (parent_thread_id: like current_thread_id; child_thread: THREAD)
		require
			thread_exists: child_thread /= Void
		local
			l_table: like childrens
		do
			childrens_mutex.lock
			l_table := childrens (parent_thread_id)
			if l_table.has (child_thread) then
				l_table.prune_all (child_thread)
			end
			childrens_mutex.unlock
		end

	current_thread_id: POINTER
		do
			if attached {SYSTEM_THREAD}.current_thread as l_thread then
				Result := default_pointer + l_thread.managed_thread_id
			end
		end

feature {NONE} -- Implementation

	childrens_mutex: MUTEX
		note
			once_status: global
		once
			create Result.make
		end

	childrens_by_thread_id: HASH_TABLE [ARRAYED_LIST [THREAD], POINTER]
		note
			once_status: global
		once
			create Result.make (5)
		end

	childrens (a_thread_id: like current_thread_id): ARRAYED_LIST [THREAD]
			-- Get all the children threads of thread `a_thread_id'
			--| Call must be synchronized via `children_mutex'.
		do
			childrens_by_thread_id.search (a_thread_id)
			if childrens_by_thread_id.found and then attached childrens_by_thread_id.found_item as l_item then
				Result := l_item
			else
				create Result.make (1)
				childrens_by_thread_id.put (Result, a_thread_id)
			end
		end

	childrens_count (a_thread_id: like current_thread_id): INTEGER
			-- Number of child threads of thread `a_thread_id'
		do
			childrens_mutex.lock
			Result := childrens (a_thread_id).count
			childrens_mutex.unlock
		end

invariant
	is_thread_capable: {PLATFORM}.is_thread_capable

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"


end
