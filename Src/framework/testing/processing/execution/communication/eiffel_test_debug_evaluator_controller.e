indexing
	description: "[
		Controller for evaluators running in the debugger.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_TEST_DEBUG_EVALUATOR_CONTROLLER

inherit
	EIFFEL_TEST_EVALUATOR_CONTROLLER
		rename
			make as make_controller
		end

	SHARED_DEBUGGER_MANAGER
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_assigner: like assigner; a_project_helper: like project_helper)
			-- Initialize `Current'.
			--
			-- `a_assigner': Assigner for retrieving test to be executed.
			-- `a_project_helper': Helper object for launching debugger
		do
			make_controller (a_assigner)
			project_helper := a_project_helper
		end

feature {NONE} -- Access

	project_helper: !EIFFEL_TEST_PROJECT_HELPER_I
			-- Project containing tests to be debugged.

feature -- Status report

	is_evaluator_running: BOOLEAN
			-- <Precursor>
		do
			Result := debugger_manager.application_initialized and then
				debugger_manager.application.is_running
		end

feature -- Status setting

	terminate_evaluator
			-- <Precursor>
		do
			if is_evaluator_running then
				debugger_manager.application.kill
			end
		end

	launch_evaluator (a_args: !LIST [!STRING]) is
			-- <Precursor>
		local
			l_param: !DEBUGGER_EXECUTION_PARAMETERS
			l_args: STRING
		do
			create l_param
			create l_args.make (50)
			from
				a_args.start
			until
				a_args.after
			loop
				l_args.append (a_args.item_for_iteration)
				l_args.append_character (' ')
				a_args.forth
			end
			l_param.set_arguments (l_args)

			project_helper.run (Void, l_args, Void)
		end

end
