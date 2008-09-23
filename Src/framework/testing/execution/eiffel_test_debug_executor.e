indexing
	description: "[
		Executor running tests in the debugger
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_TEST_DEBUG_EXECUTOR

inherit
	EIFFEL_TEST_EXECUTOR
		rename
			make as make_executor,
			make_with_launcher as make_executor_with_launcher
		redefine
			evaluator_count,
			evaluator_test_count,
			is_ready
		end

	EIFFEL_TEST_DEBUGGER_I
		undefine
			is_ready
		end

	SHARED_DEBUGGER_MANAGER
		export
			{NONE} all
		end

create
	make, make_with_launcher

feature {NONE} -- Initialization

	make (a_debugger_launcher: like debugger_launcher)
			-- Initialize `Current' with launcher.
			--
			-- `a_debugger_launcher': Launcher used to run project in debugger.
		do
			make_executor
			debugger_launcher := a_debugger_launcher
		ensure
			debugger_launcher_set: debugger_launcher = a_debugger_launcher
		end

	make_with_launcher (a_debugger_launcher: like debugger_launcher; a_compilation_launcher: like compilation_launcher)
			-- Initialize `Current' with launchers.
			--
			-- `a_debugger_launcher': Launcher used to run project in debugger.
			-- `a_compilation_launcher': Launcher used to compile project before running.
		do
			make_executor_with_launcher (a_compilation_launcher)
			debugger_launcher := a_debugger_launcher
		ensure
			compilation_launcher_set: compilation_launcher = a_compilation_launcher
			debugger_launcher_set: debugger_launcher = a_debugger_launcher
		end

feature -- Access

	frozen evaluator_test_count: NATURAL = 0
			-- <Precursor>

	frozen evaluator_count: NATURAL = 1
			-- <Precursor>

feature {NONE} -- Access

	debugger_launcher: !EIFFEL_TEST_DEBUGGER_LAUNCHER
			-- Launcher used to run project in debugger.

feature -- Status report

	is_ready (a_test_suite: !EIFFEL_TEST_SUITE_S): BOOLEAN
			-- <Precursor>
		do
			Result := Precursor {EIFFEL_TEST_EXECUTOR} (a_test_suite) and then
				debugger_launcher.is_ready (a_test_suite.eiffel_project)
		end

feature {NONE} -- Factory

	create_evaluator: !EIFFEL_TEST_EVALUATOR_CONTROLLER
			-- <Precursor>
		do
			create {EIFFEL_TEST_DEBUG_EVALUATOR_CONTROLLER} Result.make (map,test_suite.eiffel_project, debugger_launcher)
		end

end
