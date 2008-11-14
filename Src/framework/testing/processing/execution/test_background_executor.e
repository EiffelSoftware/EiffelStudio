indexing
	description: "[
		Executor running tests in separate processes.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_BACKGROUND_EXECUTOR

inherit
	TEST_EXECUTOR
		redefine
			compile_project,
			evaluator_count,
			relaunch_evaluators
		end

	TEST_BACKGROUND_EXECUTOR_I
		undefine
			is_ready
		end

create
	make

feature -- Access

	evaluator_count: NATURAL = 4
			-- <Precursor>

feature {NONE} -- Status report

	relaunch_evaluators: BOOLEAN = True
			-- <Precursor>

feature {NONE} -- Status setting

	compile_project
			-- <Precursor>
		local
			l_wkbench, l_tmp: FILE_NAME
		do
			Precursor
				-- TODO: copy wkbench executable to separate directory
		end

feature {NONE} -- Factory

	create_evaluator: !TEST_EVALUATOR_CONTROLLER
			-- <Precursor>
		local
			l_exec: !STRING
		do
				-- TODO: use temporary executable
			create l_exec.make_from_string (test_suite.eiffel_project.system.application_name (True))
			if {l_assigner: !like assigner} assigner then
				create {TEST_BACKGROUND_EVALUATOR_CONTROLLER} Result.make (l_assigner, l_exec)
			end
		end

end
