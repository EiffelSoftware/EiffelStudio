indexing
	description: "[
		Interface for launching the debugger.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EIFFEL_TEST_DEBUGGER_LAUNCHER

feature -- Status report

	is_ready (a_project: !E_PROJECT): BOOLEAN
			-- Can the debugger be launched?
			--
			-- `a_project': Project which should be debugged.
		deferred
		end

feature -- Status setting

	launch (a_project: !E_PROJECT; a_param: !DEBUGGER_EXECUTION_PARAMETERS)
			-- Launch debugger to execute project.
			--
			-- `a_project': Project which should be debugged.
			-- `a_param': Parameters passed to the debugee.
		require
			ready: is_ready (a_project)
		deferred
		end

end
