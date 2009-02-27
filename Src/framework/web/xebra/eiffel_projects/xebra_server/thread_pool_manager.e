note
	description: "[
		A thread pool manager. Manages threads up to a certain size and queue after that,
		till threads get available again.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	THREAD_POOL_MANAGER [G]

create
	make

feature {THREAD_POOL_MANAGER} -- Access

	thread_pool: POOL [POOLED_THREAD [G]]
			-- The thread pool that holds all the threads

	pool_mutex: MUTEX
			-- A mutex that locks the thread pool

	max_threads: NATURAL
			-- Maximal number of threads allowed (queuing otherwise)

	work_queue: QUEUE [PROCEDURE [G, TUPLE]]
			-- Qeue that holds unprocessed requests as agents

feature -- Access

	count: NATURAL
			-- Returns the total number of spawned threads
		do
			Result := thread_pool.count
		end

	available_count: NATURAL
			-- Returns the number of available threads (not in use)
		do
			Result := thread_pool.unused_objects_count
		end

	maximal_thread_number: NATURAL
			-- Number of maximally managed threads
		do
			Result := max_threads
		end

feature {NONE} -- Initialization

	make (max_number_of_threads: NATURAL)
			-- The maximal number of threads that can be spawned is stored in `max_number_of_threads'. If this limit is
			-- reached, the requests are queued, until one of the threads is completed.
		require
			non_negative_number: max_number_of_threads > 0
		do
			max_threads := max_number_of_threads
			create thread_pool.make (max_number_of_threads, agent spawn_thread)
			create pool_mutex.make
			create {ARRAYED_QUEUE [PROCEDURE [G, TUPLE]]} work_queue.make (max_number_of_threads.as_integer_32)
		ensure
			work_queue_set: work_queue.is_empty
		end

feature -- Processing

	add_work (work: PROCEDURE [G, TUPLE])
			-- Launches a thread with the specified argument `arg'. Reuse of thread if possible.
		local
			thread: POOLED_THREAD [G]
		do
				-- Wait, till possible to lock
			pool_mutex.lock

			if thread_pool.unused_objects_count = 0 and thread_pool.count = max_threads then
				internal_queue (work)
				print ("queue " + count.out + " data " +  work_queue.count.out+ " " + available_count.out + "%N")
			else
				thread := internal_retrieve_available_thread
				thread.launch_with_work(work)
				print ("launch " + count.out + " data " +  work_queue.count.out+ " " + available_count.out + "%N")
			end

				-- Let the other threads launch/lock		
			pool_mutex.unlock
		end

feature {THREAD_POOL_MANAGER} -- Internal

	internal_retrieve_available_thread: POOLED_THREAD [G]
			-- Returns an unused thread, this method is thread safe
		require
			not_too_many_threads: count <= maximal_thread_number
		do
			if not thread_pool.has_unused_objects then
				thread_pool.spawn_new_object
			end
			Result := thread_pool.retrieve_available_object
		ensure
			not_too_many_threads: thread_pool.count <= max_threads
		end

	internal_queue (work: PROCEDURE [G, TUPLE])
			-- Queues an argument `arg'.
		do
			work_queue.put (work)
		end

	internal_make_thread_available (thread: POOLED_THREAD [G])
			-- This method only exists to make the ensure thread safe
		do
			thread_pool.internal_ready (thread)
			thread.wait
		ensure
			more_threads_available: thread_pool.unused_objects_count > old thread_pool.unused_objects_count
		end

	spawn_thread: POOLED_THREAD [G]
			-- spawns threads
		do
			create Result.make (Current)
		end

feature {POOLED_THREAD} -- Internal

	internal_ready (thread: POOLED_THREAD [G])
			-- Internal use. Thread signals, that it has completed its task and is ready for reuse.
		do
			pool_mutex.lock
			internal_make_thread_available (thread)
			pool_mutex.unlock

			if not work_queue.is_empty then
				add_work (work_queue.item)
				work_queue.remove
			end
		end

end
