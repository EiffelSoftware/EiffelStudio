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

	make (a_map: like map; a_project: like project; a_launcher: like debugger_launcher)
			-- Initialize `Current'.
			--
			-- `a_map': Mapping of tests and indexes in compiled evaluator.
			-- `a_project': Project containing tests to be debugged.
			-- `a_launcher': Launcher used to run project in debugger.
		do
			make_controller (a_map)
			debugger_launcher := a_launcher
			project := a_project
			create breakpoints.make (map.tests.count)
		end

feature {NONE} -- Access

	project: !E_PROJECT
			-- Project containing tests to be debugged.

	debugger_launcher: !EIFFEL_TEST_DEBUGGER_LAUNCHER
			-- Launcher used to run project in debugger.

	breakpoints: !DS_ARRAYED_LIST [BREAKPOINT]
			-- Breakpoints of test routines which have been defined by `Current'

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
			set_breakpoints
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
			debugger_manager.add_on_stopped_action (agent on_application_quit, True)
			debugger_launcher.launch (project, l_param)
		end

feature {NONE} -- Status setting

	set_breakpoints
			-- Set breakpoint at first slot of all test features
		local
			l_cursor: DS_LINEAR_CURSOR [!EIFFEL_TEST_I]
			l_manager: BREAKPOINTS_MANAGER
			l_test: EIFFEL_TEST_I
			l_feat: like breakpoint_feature
			i: INTEGER
		do
			l_manager := debugger_manager.breakpoints_manager
			from
				l_cursor := map.tests.new_cursor
				l_cursor.start
			until
				l_cursor.after
			loop
				l_test := l_cursor.item
				l_feat := breakpoint_feature (l_test)
				if l_feat /= Void then
					i := l_feat.first_breakpoint_slot_index
					if not l_manager.is_breakpoint_enabled (l_feat, i) then
						l_manager.set_user_breakpoint (l_feat, i)
						breakpoints.force_last (l_manager.user_breakpoint (l_feat, i))
					end
				end
				l_cursor.forth
			end
		end

	remove_breakpoints
			-- Remove all breakpoints stored in `breakpoints' from project.
		local
			l_manager: BREAKPOINTS_MANAGER
			l_point: BREAKPOINT
		do
			from
				l_manager := debugger_manager.breakpoints_manager
			until
				breakpoints.is_empty
			loop
				l_point := breakpoints.last
				if l_manager.is_user_breakpoint_set_at (l_point.location) then
					l_manager.remove_user_breakpoint (l_point.routine, l_point.body_index)
				end
				breakpoints.remove_last
			end
		end

feature {NONE} -- Query

	breakpoint_feature (a_test: EIFFEL_TEST_I): ?E_FEATURE
			-- Test procedure represented by `a_test'.
		local
			l_system: SYSTEM_I
			l_root: CONF_GROUP
			l_classi: CLASS_I
			l_classc: CLASS_C
		do
			l_system := project.system.system
			if not l_system.root_creators.is_empty then
				l_root := l_system.root_creators.first.cluster
				l_classi := project.universe.class_named (a_test.class_name, l_root)
			end
			if l_classi /= Void and then l_classi.is_compiled then
				l_classc := l_classi.compiled_class
				Result := l_classc.feature_with_name (a_test.name)
			end
		end

feature {NONE} -- Events

	on_application_quit (a_dbg_manager: DEBUGGER_MANAGER)
			-- Called when debugger terminates
		do
			remove_breakpoints
		end

end
