indexing
	description: "Control over thread execution."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	THREAD_CONTROL

inherit

	IDENTIFIED

feature -- Basic operations

	yield is
			-- The calling thread yields its execution in favor of another
			-- thread.
		do
			thread_imp.sleep (0)
		end

	join_all is
			-- The calling thread waits for all other threads to terminate.
		local
			l_list: LIST [THREAD]
			l_any: ANY
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
					print ("%NJoin " + l_list.item.internal_thread_id.out + "%N")
				end
				l_item := l_list.item
				childrens_mutex.unlock
				l_item.join
				remove_children (l_item)
			end
		end

	join is
			-- The calling thread waits for the current child thread to
			-- terminate.
		do
			thread_imp.join
		end

	native_join (term: POINTER) is
			-- Same as `join' except that the low-level architecture-dependant
			-- routine is used. The thread must not be created detached.
		do
			thread_imp.join
		end
	
feature {NONE} -- Implementation

	terminated: BOOLEAN is
			-- True if the thread has terminated.
		do
			Result := not thread_imp.is_alive
		end

	exit is
			-- Exit calling thread. Must be called from the thread itself.
		do
			thread_imp.interrupt
		end

feature {THREAD_CONTROL} -- Threads id

	thread_imp: SYSTEM_THREAD is
		do
			Result := feature {SYSTEM_THREAD}.current_thread
		end

	current_thread_id: INTEGER is
		do
			Result := feature {SYSTEM_THREAD}.current_thread.get_domain.get_current_thread_id
		end

	internal_thread_id: INTEGER is
		do
			Result := object_id
		end

feature -- Sleep

	sleep (a_delay: INTEGER) is
			-- 
		do
			thread_imp.sleep (a_delay)
		end
		

feature {NONE} -- Threads management

	childrens_mutex: MUTEX is
		indexing
			once_status: global
		once
			create Result
		end

	childrens_by_thread_id: HASH_TABLE [LIST [THREAD], INTEGER] is
		indexing
			once_status: global
		once
			create Result.make (5)
		end

	add_children (th: THREAD) is
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

	remove_children (th: THREAD) is
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

	childrens: LIST [THREAD]  is
		local
			l_curr_th_id: INTEGER
		do
			childrens_mutex.lock
			l_curr_th_id := current_thread_id

			if childrens_by_thread_id.has (l_curr_th_id) then
				Result := childrens_by_thread_id.item (l_curr_th_id)
			else
				debug ("EIFFEL_THREAD")
					print ("New childrens list for " + l_curr_th_id.out + "%N")
				end
				create {LINKED_LIST [THREAD]} Result.make
				childrens_by_thread_id.put (Result, l_curr_th_id)
			end
			childrens_mutex.unlock
		end

	childrens_count: INTEGER is
		do
			childrens_mutex.lock
			Result := childrens.count
			childrens_mutex.unlock
		end
	
end -- class THREAD_CONTROL
