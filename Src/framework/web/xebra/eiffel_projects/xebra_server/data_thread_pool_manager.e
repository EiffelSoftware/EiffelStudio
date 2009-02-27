note
	description: "Summary description for {DATA_THREAD_POOL_MANAGER}."
	author: "sandro"
	date: "$Date$"
	revision: "$Revision$"

class
	DATA_THREAD_POOL_MANAGER [G]

inherit
	THREAD_POOL_MANAGER [G]
		redefine
			internal_retrieve_available_thread,
			internal_make_thread_available,
			add_work
		end

create
	make_with_managed_data

feature {NONE} -- Access

	data_pool: POOL [G]
			-- Holds data for reuse, if needed

feature -- Access

	data_count: NATURAL
			-- Counts the number of spawned data objects

feature {NONE} -- Initialization

	make_with_managed_data (max_number_of_threads: NATURAL; a_data_spawner: FUNCTION [ANY, TUPLE, G])
		-- The threads are defined by the `instantiator'
		-- The maximal number of threads that can be spawned is stored in `max_number_of_threads'.
		-- If this limit is reached, the requests are queued, until one of the threads is completed.
	require
		data_spawner_has_no_open_arguments: a_data_spawner.valid_operands (Void)
		non_negative_number: max_number_of_threads >= 0
	do
		make (max_number_of_threads)
		data_count := 0
		create data_pool.make (max_number_of_threads, a_data_spawner)
	end

feature -- Access

	add_work (a_work: PROCEDURE [G, TUPLE])
			-- Launches a thread with the specified argument `arg'. Reuse of thread if possible.
		local
			thread: POOLED_THREAD [G]
			data: G
		do
				-- Wait, until possible to lock
			pool_mutex.lock

			if thread_pool.unused_objects_count = 0 and thread_pool.count = max_threads then
				internal_queue (a_work)
				print ("queue " + count.out + " data " +  work_queue.count.out+ " " + available_count.out + "%N")
			else
				thread := internal_retrieve_available_thread
				data := internal_retrieve_available_data
				thread.launch_work_with_data(a_work, data)
				print ("launch " + count.out + " data " +  work_queue.count.out+ " " + available_count.out + "%N")
			end

				-- Let the other threads launch/lock		
			pool_mutex.unlock
		end

feature {DATA_THREAD_POOL_MANAGER} -- Internal

	internal_retrieve_available_thread: POOLED_THREAD [G]
			-- Returns an unused thread, this method is thread safe
		require else
			not_too_many_threads: count <= maximal_thread_number
		do
			if not thread_pool.has_unused_objects then
				thread_pool.spawn_new_object
			end
			Result := thread_pool.retrieve_available_object
		ensure then
			not_too_many_threads: thread_pool.count <= max_threads
		end

	internal_retrieve_available_data: G
			-- Returns an unused thread, this method is thread safe
		require else
			not_too_many_data_objects: data_count <= maximal_thread_number
		do
			if not thread_pool.has_unused_objects then
				data_pool.spawn_new_object
			end
			Result := data_pool.retrieve_available_object
		ensure then
			not_too_many_data_objects: data_pool.count <= max_threads
		end

	internal_make_thread_available (a_thread: POOLED_THREAD [G])
			-- This method only exists to make the ensure thread safe
		do
			print ("reentrant thread " + count.out + " " + data_count.out + " " +  work_queue.count.out+ " " + available_count.out + "%N")
			data_pool.internal_ready (a_thread.fetch_data)
			thread_pool.internal_ready (a_thread)
			a_thread.wait
		ensure then
			more_threads_available: thread_pool.unused_objects_count > old thread_pool.unused_objects_count
		end

end
