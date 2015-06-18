note
	description: "Processor-local access to a separate CP_WORKER_POOL."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	CP_WORKER_POOL_PROXY [G]

inherit

	CP_PROXY [CP_WORKER_POOL [G, CP_IMPORT_STRATEGY [G]], CP_WORKER_POOL_UTILS [G]]

create
	make

feature -- Access

	actual_worker_count: INTEGER
			-- The actual number of workers in the pool.
		do
			Result := utils.wp_actual_worker_count (subject)
		end

	preset_worker_count: INTEGER
			-- The number of workers that the pool should have.
		do
			Result := utils.wp_preset_worker_count (subject)
		end

feature -- Basic operations

	put (a_work: separate G)
			-- Submit `a_work' to the worker pool.
			-- May block if the worker pool buffer is full.
		do
			utils.queue_put (subject, a_work)
		end

	set_worker_count (a_count: INTEGER)
			-- Set the number of workers to `a_count'
		do
			utils.wp_set_worker_count (subject, a_count)
		end

	stop
			-- Stop the worker pool.
		do
			utils.wp_stop (subject)
		end

end
