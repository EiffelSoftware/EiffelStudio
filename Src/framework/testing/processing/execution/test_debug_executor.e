indexing
	description: "[
		Executor running tests in the debugger
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_DEBUG_EXECUTOR

inherit
	TEST_EXECUTOR
		rename
			make as make_executor
		redefine
			evaluator_count,
			is_ready,
			start_process_internal,
			stop_process
		end

	TEST_DEBUGGER_I
		undefine
			is_ready
		end

	SHARED_DEBUGGER_MANAGER
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_test_suite: like test_suite)
			-- Initialize `Current' with launcher.
		do
			make_executor (a_test_suite)
		end

feature -- Access

	frozen evaluator_count: NATURAL = 1
			-- <Precursor>

feature {NONE} -- Access

	breakpoints: ?DS_ARRAYED_LIST [!BREAKPOINT]
			-- Breakpoints of test routines which have been defined by `Current'

feature -- Status report

	is_ready: BOOLEAN
			-- <Precursor>
		do
			Result := Precursor {TEST_EXECUTOR} and then
				test_suite.eiffel_project_helper.can_run
		end

feature {NONE} -- Status setting

	set_breakpoints
			-- Set breakpoint at first slot of all test features
		require
			running: is_running
		local
			l_cursor: DS_LINEAR_CURSOR [!TEST_I]
			l_manager: BREAKPOINTS_MANAGER
			l_loc: BREAKPOINT_LOCATION
			l_test: TEST_I
			l_feat: ?E_FEATURE
			i: INTEGER
		do
			create breakpoints.make (test_map.count)
			l_manager := debugger_manager.breakpoints_manager
			from
				l_cursor := test_map.new_cursor
				l_cursor.start
			until
				l_cursor.after
			loop
				l_test := l_cursor.item
				l_feat := test_suite.feature_for_test (l_test)
				if l_feat /= Void then
					i := l_feat.first_breakpoint_slot_index
					if not l_manager.is_breakpoint_enabled (l_feat, i) then
						l_manager.set_user_breakpoint (l_feat, i)
						if {l_bp: !BREAKPOINT} l_manager.user_breakpoint (l_feat, i) then
							breakpoints.force_last (l_bp)
						end
					end
				end
				l_cursor.forth
			end
		end

	remove_breakpoints
			-- Remove all breakpoints stored in `breakpoints' from project.
		require
			breakpoint_attached: breakpoints /= Void
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
				l_manager.delete_breakpoint (l_point)
				breakpoints.remove_last
			end
			breakpoints := Void
		end

feature {NONE} -- Implementation

	start_process_internal (a_conf: like conf_type)
			-- <Precursor>
		do
			Precursor (a_conf)
			set_breakpoints
		end

	stop_process
			-- <Precursor>
		do
			Precursor
			remove_breakpoints
		end

feature {NONE} -- Factory

	create_evaluator: !TEST_EVALUATOR_CONTROLLER
			-- <Precursor>
		do
			if {l_assigner: !like assigner} assigner then
				create {TEST_DEBUG_EVALUATOR_CONTROLLER} Result.make (l_assigner, test_suite.eiffel_project_helper)
			end
		end

invariant
	running_equals_breakpoints_not_void: is_running = (breakpoints /= Void)

end
