indexing
	description: "[
		Implementation of {EIFFEL_TEST_DEBUGGER_LAUNCHER} using {EB_DEBUG_RUN_CMD}.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EIFFEL_TEST_DEBUGGER_LAUNCHER

inherit
	EIFFEL_TEST_DEBUGGER_LAUNCHER

	EB_SHARED_GRAPHICAL_COMMANDS
		export
			{NONE} all
		end

feature -- Status report

	is_ready (a_project: !E_PROJECT): BOOLEAN
			-- <Precursor>
		do
			Result := run_project_cmd.executable
		end

feature -- Basic operations

	launch (a_project: !E_PROJECT; a_param: !DEBUGGER_EXECUTION_PARAMETERS)
			-- <Precursor>
		do
			run_project_cmd.launch_with_parameters ({EXEC_MODES}.run, a_param)
		end

end
