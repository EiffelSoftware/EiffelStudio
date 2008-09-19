indexing
	description: "[
		Executor running tests in separate processes.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_TEST_BACKGROUND_EXECUTOR

inherit
	EIFFEL_TEST_EXECUTOR
		redefine
			compile_project,
			evaluator_count,
			evaluator_test_count
		end

create
	make, make_with_launcher

feature -- Access

	evaluator_count: NATURAL = 3
			-- <Precursor>

	evaluator_test_count: NATURAL = 1

feature {NONE} -- Status setting

	compile_project
			-- <Precursor>
		local
			l_wkbench, l_tmp: FILE_NAME
		do
			Precursor
			-- Todo: copy wkbench executable to separate directory
		end

feature {NONE} -- Factory

	create_evaluator: !EIFFEL_TEST_EVALUATOR_CONTROLLER
			-- <Precursor>
		local
			l_exec: !STRING
		do
			l_exec ?= test_suite.eiffel_project.system.application_name (True)
			create {EIFFEL_TEST_BACKGROUND_EVALUATOR_CONTROLLER} Result.make (map, l_exec)
		end

end
