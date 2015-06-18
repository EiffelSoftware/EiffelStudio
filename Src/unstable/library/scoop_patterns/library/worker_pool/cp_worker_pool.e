note
	description: "Worker pools that accept work items of type G."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	CP_WORKER_POOL [G, IMPORTER -> CP_IMPORT_STRATEGY [G] create default_create end]

inherit
	CP_QUEUE [G, IMPORTER]

	CP_STARTABLE_UTILS

create
	make_with_factory

feature {NONE} -- Initialization

	make_with_factory (buffer_size: INTEGER; worker_count: INTEGER; a_worker_factory: separate CP_WORKER_FACTORY [G, IMPORTER])
			-- Initialization for `Current'.
		do
			initialize_buffer (buffer_size)
			initialize_factory (worker_count, a_worker_factory)
		end

	initialize_buffer (buffer_size: INTEGER)
			-- Initialize the buffer.
		do
			if buffer_size > 0 then
				make_bounded (buffer_size)
			else
				make_unbounded
			end
		ensure
			capacity_set: capacity = buffer_size
		end

	initialize_factory (worker_count: INTEGER; a_factory: separate CP_WORKER_FACTORY [G, IMPORTER])
			-- Initialize the worker factory and create the first `worker_count' workers.
		do
			preset_worker_count := worker_count
			worker_factory := a_factory
			adjust (a_factory)
		ensure
			factory_set: worker_factory = a_factory
			count_set: worker_count = preset_worker_count
			worker_started: actual_worker_count = preset_worker_count
		end

feature -- Access

	preset_worker_count: INTEGER
			-- The number of workers `Current' should have.

	actual_worker_count: INTEGER
			-- The actual number of workers in `Current'.

feature -- Worker control

	set_worker_count (a_size: INTEGER)
			-- Adjust the preset number of workers in `Current'.
		require
			positive: a_size > 0
		do
			preset_worker_count := a_size
			adjust (worker_factory)
		ensure
			correct: preset_worker_count = a_size
			immediately_increased: old preset_worker_count < a_size implies actual_worker_count = preset_worker_count
		end

	stop
			-- Stop all workers in `Current'.
		do
			preset_worker_count := 0
		ensure
			correct: preset_worker_count = 0
		end

feature {CP_WORKER} -- Worker support

	is_stop_requested: BOOLEAN
			-- Does the worker need to stop?
		do
			Result := actual_worker_count > preset_worker_count
		end

	remove_actual_worker
			-- Decrease the number of active workers.
		do
			actual_worker_count := actual_worker_count - 1
		ensure
			decreased: actual_worker_count + 1 = old actual_worker_count
		end

feature {NONE} -- Implementation

	worker_factory: separate CP_WORKER_FACTORY [G, IMPORTER]
			-- A factory for new worker objects.

	adjust (a_factory: like worker_factory)
			-- Add new workers to the pool if necessary.
		local
			l_worker: separate CP_WORKER [G, IMPORTER]
		do
			from
			until
				actual_worker_count >= preset_worker_count
			loop
				l_worker := a_factory.new_worker (Current)
				async_start (l_worker)
				actual_worker_count := actual_worker_count + 1
			end
		end
end
