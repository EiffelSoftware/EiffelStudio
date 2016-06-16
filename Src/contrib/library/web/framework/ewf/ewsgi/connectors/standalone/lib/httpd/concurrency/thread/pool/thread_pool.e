note
	description: "[
		A thread pool manager. Manages threads up to `capacity' and queue after that,
		till threads get available again.
		]"
	legal: "See notice at end of class."
	status: "Community Preview 1.0"
	date: "$Date$"
	revision: "$Revision$"

class
	THREAD_POOL [G]

inherit
	EXECUTION_ENVIRONMENT

create
	make

feature {NONE} -- Initialization

	make (n: like capacity)
			-- Initialize current pool with capacity `n'.
		require
			n_positive: n > 0
			n_not_too_large: n < {INTEGER_32}.max_value.as_natural_32
		local
			i: NATURAL
		do
			capacity := n
			create work_queue.make (n.to_integer_32)
			create work_queue_mutex.make
			create over_mutex.make
			create termination_mutex.make
			create work_semaphore.make (capacity.as_integer_32)
			from
				i := 1
			until
				i > capacity
			loop
				work_semaphore.wait
				i := i + 1
			end
			initialize_threads
			terminated_count := capacity
			is_over := False
		ensure
			capacity_set: capacity = n
			work_queue_set: work_queue.is_empty
		end

	initialize_threads
			-- Launches all threads
		local
			i: NATURAL
			thread: POOLED_THREAD [G]
		do
			from
				i := 1
			until
				i > capacity
			loop
				create thread.make (Current, work_semaphore)
				thread.launch
				i := i + 1
			end
		end

feature -- Access

	capacity: NATURAL
			-- Maximal number of threads allowed (queuing otherwise)

	queue_count: NATURAL
			-- Number of items in queue
		do
			work_queue_mutex.lock
			Result := work_queue.count.as_natural_32
			work_queue_mutex.unlock
		end

feature -- Status report

	valid_action (a_action: PROCEDURE): BOOLEAN
			-- Is `a_action' a valid action for the current pool.
		do
				-- There should be no open operands.
			Result := a_action.valid_operands (Void)
		end

feature -- Basic operations

	add_work (work: PROCEDURE)
			-- Launches a thread with the specified argument `arg'. Reuse of thread if possible.
		require
			valid_action: valid_action (work)
		do
			work_queue_mutex.lock
			work_queue.extend (work)
			if work_queue.count <= capacity.as_integer_32 then
					-- Let one thread wake up and do the work
				work_semaphore.post
			end
			work_queue_mutex.unlock
		end

	over: BOOLEAN
			-- Is the thread pool being terminated?
		do
			over_mutex.lock
			Result := is_over
			over_mutex.unlock
		end

	thread_terminated (a_thread: POOLED_THREAD [G])
			-- Notifies the thread pool that a thread has terminated its execution.
		do
			termination_mutex.lock
			terminated_count := terminated_count - 1
			termination_mutex.unlock
		end

	get_work (requester: POOLED_THREAD [G]): detachable PROCEDURE
			-- If there is work to do, it is returned
			-- Yields Void otherwise
		do
			if not over then
				work_queue_mutex.lock
				if not work_queue.is_empty then
					Result := work_queue.item
					work_queue.remove
				end
				work_queue_mutex.unlock
			end
		end

	wait_for_completion
			-- Wait until there is no more work to be completed
		local
			done: BOOLEAN
		do
			from

			until
				done
			loop
				work_queue_mutex.lock
				done := work_queue.is_empty
				work_queue_mutex.unlock
				if not done then
					sleep (1)
				end
			end
		end

	terminate
			-- Terminates all the threads after their execution
		do
			over_mutex.lock
			is_over := True
			over_mutex.unlock
			from
				termination_mutex.lock
			until
				terminated_count = 0
			loop
				work_semaphore.post
				termination_mutex.unlock
				termination_mutex.lock
			end
			termination_mutex.unlock
		end

feature {NONE} -- Implementation: Access

	work_queue: ARRAYED_QUEUE [PROCEDURE]
			-- Queue that holds unprocessed requests as agents
			-- Thread-safe access when accessor holds `queue_mutex'

	work_queue_mutex: MUTEX
			-- Mutex for the queue

	work_semaphore: SEMAPHORE
			-- Semaphore which hols the number of work to be done.
			-- Needed to wake up worker threads

	terminated_count: NATURAL
			--

	is_over: BOOLEAN
			-- Is the thread pool being terminated?

	over_mutex: MUTEX
			-- Mutex for the `is_over' variable

	termination_mutex: MUTEX
;note
	copyright: "2011-2012, Javier Velilla, Jocelyn Fiat and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
