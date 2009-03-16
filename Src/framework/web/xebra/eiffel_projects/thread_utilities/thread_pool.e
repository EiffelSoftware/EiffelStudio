note
	description: "[
		A thread pool manager. Manages threads up to `capacity' and queue after that,
		till threads get available again.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	THREAD_POOL [G]

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
			create {ARRAYED_QUEUE [PROCEDURE [G, TUPLE]]} work_queue.make (n.to_integer_32)
			--create queue_mutex.make
			create work_queue_mutex.make
			create over_mutex.make
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
			Result := work_queue.count.as_natural_32
		end

feature -- Status report

	valid_action (a_action: PROCEDURE [G, TUPLE]): BOOLEAN
			-- Is `a_action' a valid action for the current pool.
		do
				-- There should be no open operands.
			Result := a_action.valid_operands (Void)
		end

feature -- Basic operations

	add_work (work: PROCEDURE [G, TUPLE])
			-- Launches a thread with the specified argument `arg'. Reuse of thread if possible.
		require
			valid_action: valid_action (work)
		do
			work_queue_mutex.lock
			work_queue.extend (work)
			if work_queue.count < capacity.as_integer_32 then
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

	thread_terminated
			-- Notifies the thread pool that a thread has terminated its execution.
		do
			terminated_count := terminated_count - 1
		end

	get_work (requester: POOLED_THREAD [G]): detachable PROCEDURE [G, TUPLE]
			-- If there is work to do, it is returned
			-- Yields Void otherwise
		do
			work_queue_mutex.lock
			if not work_queue.is_empty then
				Result := work_queue.item
				work_queue.remove
			end
			work_queue_mutex.unlock
		end

	terminate
			-- Terminates all the threads after their execution
		do
			over_mutex.lock
			is_over := True
			over_mutex.unlock
			from

			until
				terminated_count = 0
			loop
				work_semaphore.post
			end
		end

feature {NONE} -- Implementation: Access

	work_queue: QUEUE [PROCEDURE [G, TUPLE]]
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

end
