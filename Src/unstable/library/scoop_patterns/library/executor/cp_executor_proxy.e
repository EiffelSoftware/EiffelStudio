note
	description: "Processor-local access to a separate CP_EXECUTOR object."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	CP_EXECUTOR_PROXY

inherit

	CP_EXECUTOR

	CP_GLOBAL_PROCESSORS

	CP_PROXY [CP_EXECUTOR, CP_EXECUTOR_UTILS]

create
	make, make_global

feature {NONE} -- Initialization

	make_global
			-- Initialize `Current' with the global worker pool.
		local
			l_procs: CP_GLOBAL_PROCESSORS
		do
			create l_procs
			make (l_procs.global_worker_pool)
		end

feature -- Basic operations

	put (a_task: separate CP_TASK)
			-- <Precursor>
			-- May block if full.
		do
			utils.executor_put (subject, a_task)
		end

	put_and_get_promise (a_task: separate CP_TASK): CP_PROMISE_PROXY
			-- Execute `a_task' asynchronously and return a promise.
		do
			Result := new_promise
			a_task.set_promise (Result.subject)
			put (a_task)
		ensure
			same_promise: Result.subject = a_task.promise
		end

	stop
			-- <Precursor>
		do
			utils.executor_stop (subject)
		end

feature -- Factory functions

	new_promise: CP_PROMISE_PROXY
			-- Create a new promise on the global processor.
		do
			create Result.make (new_promise_on_processor (my_promise_processor))
		end

feature {NONE} -- Implementation

	my_promise_processor: separate CP_PROMISE_UTILS
			-- The processor to be used for promise objects.
		attribute
			Result := promise_processor
		end

end
