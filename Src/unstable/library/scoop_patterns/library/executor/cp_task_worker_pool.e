note
	description: "Executor service for CP_TASK objects, implemented with a worker pool."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	CP_TASK_WORKER_POOL

inherit

	CP_EXECUTOR
		undefine
			is_full
		end

	CP_WORKER_POOL [CP_TASK, CP_DYNAMIC_TYPE_IMPORTER [CP_TASK]]

	CP_WORKER_FACTORY [CP_TASK, CP_DYNAMIC_TYPE_IMPORTER [CP_TASK]]

create
	make

feature {NONE} -- Initialization

	make (buffer_size: INTEGER; worker_count: INTEGER)
			-- Initialization for `Current'.
		do
			initialize_buffer (buffer_size)
			initialize_factory (worker_count, Current)
		end

feature {NONE} -- Worker factory

	new_worker (a_pool: separate CP_TASK_WORKER_POOL): separate CP_TASK_WORKER
			-- <Precursor>
		do
			create Result.make (Current)
		end

end
