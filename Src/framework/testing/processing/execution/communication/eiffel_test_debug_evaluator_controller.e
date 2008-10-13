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

	make (a_assigner: like assigner; a_project: like project; a_launcher: like debugger_launcher)
			-- Initialize `Current'.
			--
			-- `a_assigner': Assigner for retrieving test to be executed.
			-- `a_project': Project containing tests to be debugged.
			-- `a_launcher': Launcher used to run project in debugger.
		do
			make_controller (a_assigner)
			debugger_launcher := a_launcher
			project := a_project
		end

feature {NONE} -- Access

	project: !E_PROJECT
			-- Project containing tests to be debugged.

	debugger_launcher: !EIFFEL_TEST_DEBUGGER_LAUNCHER
			-- Launcher used to run project in debugger.

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
			debugger_launcher.launch (project, l_param)
		end

end
