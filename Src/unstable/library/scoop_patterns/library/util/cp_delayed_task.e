note
	description: "Tasks that wrap around other tasks and can be used to introduce a small delay before execution."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	CP_DELAYED_TASK

inherit

	CP_TASK

create
	make, make_from_separate

feature {NONE} -- Initialization

	make (a_task: CP_TASK; a_delay: like delay)
			-- Create `Current' with `a_task' and `a_delay' (in nanoseconds).
		require
			positive_delay: a_delay >= 0
		do
			task := a_task
			initialize (a_delay)
		ensure
			delay_set: delay = a_delay
			promise_set: promise = a_task.promise
			equal_task: task ~ a_task
		end

	initialize (a_delay: like delay)
			-- Finish initializion of `Current'.
		require
			task_initialized: attached task
		do
			delay := a_delay
			create environment
		ensure
			delay_set: delay = a_delay
			promise_set: promise = task.promise
		end

feature {CP_DYNAMIC_TYPE_IMPORTER}-- Initialization

	make_from_separate (other: separate like Current)
			-- <Precursor>
		local
			importer: CP_DYNAMIC_TYPE_IMPORTER [CP_TASK]
		do
			create importer
			task := importer.import (other.task)
			initialize (other.delay)
		ensure then
			same_delay: delay = other.delay
		end

feature -- Access

	promise: detachable separate CP_SHARED_PROMISE
			-- A stable communication object.
		do
			Result := task.promise
		end

	delay: INTEGER_64
			-- The delay time in nanoseconds.

	task: CP_TASK
			-- The task to be executed.

feature -- Basic operations

	set_promise (a_promise: like promise)
			-- Set the promise in the actual task object.
		do
			task.set_promise (a_promise)
		ensure then
			aliased: a_promise = task.promise
		end

	run
			-- <Precursor>
		do
			environment.sleep (delay)
			if attached promise as l_promise and then is_promise_cancelled (l_promise) then
				-- Do nothing. Task has been cancelled.
			else
					-- Invoke `run' as opposed to `start', because exception handling is done in `Current'.
				task.run
			end
		end

feature {NONE} -- Implementation

	environment: EXECUTION_ENVIRONMENT
			-- An execution environment instance.

end
