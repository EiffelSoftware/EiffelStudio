note
	description: "Control over thread execution."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	THREAD_CONTROL

feature -- Basic operations

	yield
			-- The calling thread yields its execution in favor of another
			-- thread.
		do
			thread_imp.sleep (0)
		end

	join_all
			-- The calling thread waits for all other threads to terminate.
		local
			l_list: LIST [THREAD]
			l_item: THREAD
		do
			debug ("EIFFEL_THREAD")
				print ("THREAD_CONTROL.join_all %N")
			end
			from
			until
				childrens_count = 0
			loop
				childrens_mutex.lock
				l_list := childrens
				l_list.start
				debug ("EIFFEL_THREAD")
					print ("%N["+ current_thread_id.out +"] Threads remaining:"+ l_list.count.out+"%N")
					print ("%NJoin " + l_list.item.thread_id.out + "%N")
				end
				l_item := l_list.item
				childrens_mutex.unlock
				l_item.join
				remove_children (l_item)
			end
		end

	join
			-- The calling thread waits for the current child thread to
			-- terminate.
		do
				-- If `internal_thread_id' is 0, it means  we haven't started the thread in which case
				-- there is nothing to do.
			if internal_thread_id /= 0 then
				thread_imp.join
			end
		end

	native_join (term: POINTER)
			-- Same as `join' except that the low-level architecture-dependant
			-- routine is used. The thread must not be created detached.
		do
			thread_imp.join
		end

feature -- Sleep

	sleep (nanoseconds: INTEGER_64)
			-- Suspend thread execution for interval specified in
			-- `nanoseconds' (1 nanosecond = 10^(-9) second).
		obsolete
			"Use {EXECUTION_ENVIRONMENT}.sleep instead."
		require
			non_negative_nanoseconds: nanoseconds >= 0
		do
			(create {EXECUTION_ENVIRONMENT}).sleep (nanoseconds)
		end

feature {NONE} -- Implementation

	terminated: BOOLEAN
			-- True if the thread has terminated.
		do
			Result := not thread_imp.is_alive
		end

	exit
			-- Exit calling thread. Must be called from the thread itself.
		do
			thread_imp.interrupt
		end

feature {THREAD_CONTROL} -- Threads id

	thread_imp: SYSTEM_THREAD
			-- .NET thread object.
		local
			l_thread: detachable SYSTEM_THREAD
		do
			l_thread := {SYSTEM_THREAD}.current_thread
			check l_thread_attached: l_thread /= Void end
			Result := l_thread
		end

	current_thread_id: INTEGER
			-- Id of current .NET thread.
		do
			if
				attached {SYSTEM_THREAD}.current_thread as l_thread and then
				attached l_thread.get_domain as l_domain
			then
				Result := l_domain.get_current_thread_id
			end
		end

feature {NONE} -- Threads management

	childrens_mutex: MUTEX
		note
			once_status: global
		once
			create Result.make
		end

	childrens_by_thread_id: HASH_TABLE [LIST [THREAD], INTEGER]
		note
			once_status: global
		once
			create Result.make (5)
		end

	add_children (th: THREAD)
		require
			thread_exists: th /= Void
		local
			l_table: LIST [THREAD]
		do
			childrens_mutex.lock
			debug ("EIFFEL_THREAD")
				print ("Add new children to thread [" + current_thread_id.out + "]%N")
			end
			l_table := childrens
			l_table.extend (th)
			childrens_mutex.unlock
		end

	remove_children (th: THREAD)
		require
			thread_exists: th /= Void
		local
			l_table: LIST [THREAD]
		do
			childrens_mutex.lock
			l_table := childrens
			if l_table.has (th) then
				l_table.prune (th)
			end
			childrens_mutex.unlock
		end

	childrens: LIST [THREAD]
		local
			l_curr_th_id: INTEGER
		do
			childrens_mutex.lock
			l_curr_th_id := current_thread_id

			childrens_by_thread_id.search (l_curr_th_id)

			if childrens_by_thread_id.found and then attached childrens_by_thread_id.found_item as l_item then
				Result := l_item
			else
				debug ("EIFFEL_THREAD")
					print ("New childrens list for " + l_curr_th_id.out + "%N")
				end
				create {LINKED_LIST [THREAD]} Result.make
				childrens_by_thread_id.put (Result, l_curr_th_id)
			end
			childrens_mutex.unlock
		end

	childrens_count: INTEGER
		do
			childrens_mutex.lock
			Result := childrens.count
			childrens_mutex.unlock
		end

	internal_thread_id: INTEGER
			-- Thread id of `Current' for a THREAD object, not  initialized in THREAD_CONTROL

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


end -- class THREAD_CONTROL

