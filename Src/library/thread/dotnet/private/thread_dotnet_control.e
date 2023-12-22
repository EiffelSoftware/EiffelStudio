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
			l_list: like children
			l_item: detachable THREAD
			l_current_thread_id: like current_thread_id
			done: BOOLEAN
		do
			from
				l_current_thread_id := current_thread_id
			until
				done
			loop
				children_mutex.lock
				l_list := children (l_current_thread_id)
				if not l_list.is_empty then
					l_item := l_list.first
				else
					done := True
					l_item := Void
				end
				children_mutex.unlock
				if l_item /= Void then
					l_item.join
				end
			end
		end

	add_child_to_parent (parent_thread_id: like current_thread_id; child_thread: THREAD)
			-- Add `child_thread' to the list of threads own by thread of ID `parent_thread_id'.
		require
			thread_exists: child_thread /= Void
		do
			children_mutex.lock
			children (parent_thread_id).extend (child_thread)
			children_mutex.unlock
		end

	remove_child_from_parent (parent_thread_id: like current_thread_id; child_thread: THREAD)
			-- Remove `child_thread' to the list of threads own by thread of ID `parent_thread_id'.
		require
			thread_exists: child_thread /= Void
		local
			l_table: like children
		do
			children_mutex.lock
			l_table := children (parent_thread_id)
			if l_table.has (child_thread) then
				l_table.prune_all (child_thread)
			end
			children_mutex.unlock
		end

	current_thread_id: POINTER
			-- Thread identifier for current thread of execution.
		do
			if attached {SYSTEM_THREAD}.current_thread as l_thread then
				Result := default_pointer + l_thread.managed_thread_id
			end
		end

feature {NONE} -- Implementation

	children_mutex: MUTEX
			-- Synchronization object for all operations on `children_by_thread_id'.
--		note
--			once_status: global
		once ("PROCESS")
			create Result.make
		end

	children_by_thread_id: HASH_TABLE [ARRAYED_LIST [THREAD], POINTER]
			-- Table of all children threads for a given thread.
--		note
--			once_status: global
		once ("PROCESS")
			create Result.make (5)
		end

	children (a_thread_id: like current_thread_id): ARRAYED_LIST [THREAD]
			-- Get all the children threads of thread `a_thread_id'
			--| Call must be synchronized via `children_mutex'.
		do
			children_by_thread_id.search (a_thread_id)
			if children_by_thread_id.found and then attached children_by_thread_id.found_item as l_item then
				Result := l_item
			else
				create Result.make (1)
				children_by_thread_id.put (Result, a_thread_id)
			end
		end

	children_count (a_thread_id: like current_thread_id): INTEGER
			-- Number of child threads of thread `a_thread_id'
		do
			children_mutex.lock
			Result := children (a_thread_id).count
			children_mutex.unlock
		end

note
	copyright:	"Copyright (c) 1984-2023, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
