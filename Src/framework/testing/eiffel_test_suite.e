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
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		local
			l_project_factory: SHARED_EIFFEL_PROJECT
			l_project: !E_PROJECT
		do
				-- Create registrar
			create processor_registrar.make

				-- Create events
			create processor_launched_event
			create processor_proceeded_event
			create processor_finished_event
			create processor_stopped_event

			create l_project_factory
			l_project ?= l_project_factory.eiffel_project
			make_with_project (l_project)

			register_locator (create {EIFFEL_TEST_COMPILED_LOCATOR})
			register_locator (create {EIFFEL_TEST_UNCOMPILED_LOCATOR}.make)

			synchronize
		end

feature -- Access

	processor_registrar: !EIFFEL_TEST_PROCESSOR_REGISTRAR
			-- <Precursor>

feature -- Status report

	count_passing: NATURAL
			-- <Precursor>

	count_failing: NATURAL
			-- <Precursor>

feature -- Status setting

	synchronize_processors
			-- <Precursor>
		do
			processor_registrar.processors.do_all (
				agent (a_proc: !EIFFEL_TEST_PROCESSOR_I)
					do
						if a_proc.is_idle then
							if a_proc.is_finished then
								a_proc.stop
								processor_stopped_event.publish_if ([Current, a_proc], {!PREDICATE [ANY, TUPLE [!like Current, !EIFFEL_TEST_PROCESSOR_I]]} #?
									agent (ts: like Current; p: !EIFFEL_TEST_PROCESSOR_I): BOOLEAN
										do
											Result := not p.is_running
										end)
							else
								a_proc.proceed
								if a_proc.is_finished then
									processor_finished_event.publish ([Current, a_proc])
								end
							end
						end
					end)
		end

	launch_processor (a_processor: !EIFFEL_TEST_PROCESSOR_I; a_arg: !ANY; a_blocking: BOOLEAN)
			-- <Precursor>
		do
			a_processor.start (a_arg, Current)
			processor_launched_event.publish ([Current, a_processor])
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

	add_outcome_to_test (a_test: !EIFFEL_TEST_I; a_outcome: !TEST_OUTCOME) is
			-- <Precursor>
		local
			l_old, l_new: NATURAL_8
		do
			if a_test.is_outcome_available then
				l_old := a_test.last_outcome.status
			end
			l_new := a_outcome.status
			if l_old /= l_new then
				if l_new = {TEST_OUTCOME_STATUS_TYPES}.failed then
					count_failing := count_failing + 1
				elseif l_new = {TEST_OUTCOME_STATUS_TYPES}.passed then
					count_passing := count_passing + 1
				end
				if l_old = {TEST_OUTCOME_STATUS_TYPES}.failed then
					count_failing := count_failing - 1
				elseif l_new = {TEST_OUTCOME_STATUS_TYPES}.passed then
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


feature -- Basic functionality

	synchronize_tests (a_class: !EIFFEL_CLASS_I)
			-- <Precursor>
		local
		do
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


end
