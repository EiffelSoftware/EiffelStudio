note
	description: "Executor service to run CP_TASK objects asynchronously."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CP_EXECUTOR

feature -- Status report

	is_full: BOOLEAN
			-- Is the executor full?
		do
			Result := False
		end

feature -- Basic operations

	put (a_task: separate CP_TASK)
			-- Execute `a_task' asynchronously.
		require
			not_full: not is_full
		deferred
		end

	stop
			-- Stop the executor service.
		deferred
		end

end
