indexing
	description: "[
		Objects implementing {EIFFEL_TEST_SUITE_S}.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_TEST_SUITE

inherit
	EIFFEL_TEST_SUITE_S

	EIFFEL_TEST_PROJECT
		undefine
			events
		redefine
			remove_test
		end

create
	make

feature {NONE} -- Initialization

	make (a_project_helper: like eiffel_project_helper)
			-- Initialize `Current'.
		local
			l_project_factory: SHARED_EIFFEL_PROJECT
			l_project: !E_PROJECT
		do
				-- Create registrar
			create processor_registrar.make
			create active_processors.make

				-- Create events
			create processor_launched_event
			create processor_proceeded_event
			create processor_finished_event
			create processor_stopped_event
			create processor_error_event

			create l_project_factory
			l_project ?= l_project_factory.eiffel_project
			make_with_project (l_project, a_project_helper)

			register_locator (create {EIFFEL_TEST_COMPILED_LOCATOR})
			register_locator (create {EIFFEL_TEST_UNCOMPILED_LOCATOR}.make)

			synchronize
		end

feature -- Access

	processor_registrar: !EIFFEL_TEST_PROCESSOR_REGISTRAR
			-- <Precursor>

feature {NONE} -- Access

	active_processors: !DS_LINKED_LIST [!EIFFEL_TEST_PROCESSOR_I]
			-- Processors proceeding a task whenever `synchronize_processors' is called

feature -- Status report

	count_executed: NATURAL
			-- <Precursor>

	count_passing: NATURAL
			-- <Precursor>

	count_failing: NATURAL
			-- <Precursor>

feature -- Status setting

	synchronize_processors
			-- <Precursor>
		local
			l_cursor: DS_LINKED_LIST_CURSOR [!EIFFEL_TEST_PROCESSOR_I]
			l_proc: !EIFFEL_TEST_PROCESSOR_I
		do
			from
				l_cursor := active_processors.new_cursor
				l_cursor.start
			until
				l_cursor.after
			loop
				l_proc := l_cursor.item
				l_cursor.forth
				if l_proc.is_idle then
					if l_proc.is_finished then
						l_cursor.remove_left
						stop_task (l_proc)
					else
						proceed_task (l_proc)
					end
				end
			end
		end

	launch_processor (a_processor: !EIFFEL_TEST_PROCESSOR_I; a_arg: !ANY; a_blocking: BOOLEAN)
			-- <Precursor>
		do
			a_processor.start (a_arg, Current)
			processor_launched_event.publish ([Current, a_processor])

			if a_blocking then
				from until
					a_processor.is_finished
				loop
					proceed_task (a_processor)
				end
				stop_task (a_processor)
			else
				active_processors.force_last (a_processor)
			end
		end

feature {EIFFEL_TEST_PROCESSOR_I} -- Status setting

	propagate_error (a_error: !STRING; a_token_values: !TUPLE; a_processor: !EIFFEL_TEST_PROCESSOR_I)
			-- <Precursor>
		do
			processor_error_event.publish ([Current, a_processor, a_error, a_token_values])
		end

feature {EIFFEL_TEST_EXECUTOR_I} -- Status setting

	set_test_queued (a_test: !EIFFEL_TEST_I; a_executor: !EIFFEL_TEST_EXECUTOR_I) is
			-- <Precursor>
		do
			a_test.set_queued (a_executor)
			test_changed_event.publish ([Current, a_test])
			a_test.clear_changes
		end

	set_test_running (a_test: !EIFFEL_TEST_I) is
			-- <Precursor>
		do
			a_test.set_running
			test_changed_event.publish ([Current, a_test])
			a_test.clear_changes
		end

	add_outcome_to_test (a_test: !EIFFEL_TEST_I; a_outcome: !EQA_TEST_OUTCOME) is
			-- <Precursor>
		local
			l_old, l_new: NATURAL_8
		do
			if a_test.is_outcome_available then
				l_old := a_test.last_outcome.status
			else
				count_executed := count_executed + 1
			end
			l_new := a_outcome.status
			if l_old /= l_new then
				if l_new = {EQA_TEST_OUTCOME_STATUS_TYPES}.failed then
					count_failing := count_failing + 1
				elseif l_new = {EQA_TEST_OUTCOME_STATUS_TYPES}.passed then
					count_passing := count_passing + 1
				end
				if l_old = {EQA_TEST_OUTCOME_STATUS_TYPES}.failed then
					count_failing := count_failing - 1
				elseif l_new = {EQA_TEST_OUTCOME_STATUS_TYPES}.passed then
					count_passing := count_passing - 1
				end
			end
			a_test.add_outcome (a_outcome)
			test_changed_event.publish ([Current, a_test])
			a_test.clear_changes
		end

	set_test_aborted (a_test: !EIFFEL_TEST_I) is
			-- <Precursor>
		do
			a_test.abort
			test_changed_event.publish ([Current, a_test])
			a_test.clear_changes
		end

feature {NONE} -- Element change

	remove_test (a_id: !STRING)
			-- <Precursor>
		local
			l_test: EIFFEL_TEST_I
		do
			l_test := test_routine_map.item (a_id)
			if l_test.is_outcome_available then
				count_executed := count_executed - 1
				if l_test.passed then
					count_passing := count_passing - 1
				elseif l_test.failed then
					count_failing := count_failing - 1
				end
			end
			Precursor (a_id)
		end

feature {NONE} -- Basic operations

	proceed_task (a_processor: !EIFFEL_TEST_PROCESSOR_I)
			-- Make `a_processor' proceed with its task. Notify observers of events.
		require
			a_processor_usable: a_processor.is_interface_usable
			a_processor_running: a_processor.is_running
			a_processor_idle: a_processor.is_idle
			not_a_processor_fininshed: not a_processor.is_finished
			a_processor_launched_by_current: a_processor.test_suite = Current
		do
			a_processor.proceed
			if a_processor.is_finished then
				processor_finished_event.publish ([Current, a_processor])
			else
				processor_proceeded_event.publish ([Current, a_processor])
			end
		end

	stop_task (a_processor: !EIFFEL_TEST_PROCESSOR_I)
			-- Stop `a_processor' and notify observers as long as processor is not running.
		require
			a_processor_usable: a_processor.is_interface_usable
			a_processor_running: a_processor.is_running
			a_processor_idle: a_processor.is_idle
			a_processor_fininshed: a_processor.is_finished
			a_processor_launched_by_current: a_processor.test_suite = Current
		do
			a_processor.stop
			processor_stopped_event.publish_if ([Current, a_processor],
				agent (ts: !like Current; p: !EIFFEL_TEST_PROCESSOR_I): BOOLEAN
					do
						Result := not p.is_running
					end)
		end

feature -- Events

	processor_launched_event: !EVENT_TYPE [TUPLE [test_suite: !EIFFEL_TEST_SUITE_S; processor: !EIFFEL_TEST_PROCESSOR_I]]
			-- <Precursor>

	processor_proceeded_event: !EVENT_TYPE [TUPLE [test_suite: !EIFFEL_TEST_SUITE_S; processor: !EIFFEL_TEST_PROCESSOR_I]]
			-- <Precursor>

	processor_finished_event: !EVENT_TYPE [TUPLE [test_suite: !EIFFEL_TEST_SUITE_S; processor: !EIFFEL_TEST_PROCESSOR_I]]
			-- <Precursor>

	processor_stopped_event: !EVENT_TYPE [TUPLE [test_suite: !EIFFEL_TEST_SUITE_S; processor: !EIFFEL_TEST_PROCESSOR_I]]
			-- <Precursor>

	processor_error_event: !EVENT_TYPE [TUPLE [test_suite: !EIFFEL_TEST_SUITE_S; processor: !EIFFEL_TEST_PROCESSOR_I; error: !STRING; token_values: !TUPLE]]
			-- <Precursor>

invariant
	active_processors_usable: active_processors.for_all (agent {!EIFFEL_TEST_PROCESSOR_I}.is_interface_usable)
	active_processors_running: active_processors.for_all (agent {!EIFFEL_TEST_PROCESSOR_I}.is_running)

end
