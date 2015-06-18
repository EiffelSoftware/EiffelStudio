note
	description: "Utility functions to access a separate CP_EXECUTOR object."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	CP_EXECUTOR_UTILS

feature -- Status report

	is_executor_full (a_executor: separate CP_EXECUTOR): BOOLEAN
			-- Is `a_executor' full?
		do
			Result := a_executor.is_full
		end

feature -- Basic operations

	executor_put (a_executor: separate CP_EXECUTOR; a_task: separate CP_TASK)
			-- Put `a_task' in `a_executor'.
		require
			not_full: not a_executor.is_full
		do
			a_executor.put (a_task)
		end

	executor_stop (a_executor: separate CP_EXECUTOR)
			-- Stop `a_executor'.
		do
			a_executor.stop
		end

end
