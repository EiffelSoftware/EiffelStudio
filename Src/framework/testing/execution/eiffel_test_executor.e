indexing
	description: "[
		Objects that compile and execute eiffel tests.

		The actual compilation and execution are done in separate processes.
		See {EIFFEL_TEST_PROCESS_I} for more details.

	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EIFFEL_TEST_EXECUTOR

inherit
	EIFFEL_TEST_EXECUTOR_I
		redefine
			is_ready
		end

	EIFFEL_TEST_PROCESSOR
		rename
			make as make_processor,
			tests as active_tests,
			argument as active_tests,
			is_valid_typed_argument as is_valid_test_list
		undefine
			is_ready
		redefine
			on_test_removed
		end

	KL_SHARED_OPERATING_SYSTEM
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	make
			-- Initialize `Current'
		do
			make_with_launcher (default_compilation_launcher)
		end

	make_with_launcher (a_launcher: like compilation_launcher)
			-- Initialize `Current' with eiffel compilation launcher
			--
			-- `a_launcher': Launcher used to compile project.
		do
			make_processor
			create evaluators.make
			compilation_launcher := a_launcher
		ensure
			launcher_set: compilation_launcher = a_launcher
		end

feature -- Access

	active_tests: !DS_LINEAR [!EIFFEL_TEST_I]
			-- <Precursor>
		do
			if {l_values: !DS_LINEAR [!EIFFEL_TEST_I]} test_map then
				Result := l_values
			end
		end

	evaluator_test_count: NATURAL
			-- Number of tests an evaluator gets assigned per launch
			--
			-- Note: can be zero to indicate that all tests are assigned to a single evaluator.
		do
			Result := 0
		end

	evaluator_count: NATURAL
			-- Number of evaluators running at the same time
		do
			Result := 1
		ensure
			positive: Result > 0
			test_count_zero_implies_result_one: evaluator_test_count = 0 implies Result = 1
		end

feature {EIFFEL_TEST_EVALUATOR_CONTROLLER} -- Access

	source_writer: !EIFFEL_TEST_EVALUATOR_SOURCE_WRITER
			-- Source writer for writing evaluator root class
		once
			create Result
		end

feature {NONE} -- Access

	test_map: ?DS_HASH_TABLE [!EIFFEL_TEST_I, NATURAL]
			-- Test map containing test and their indices to be executed.
			--
			-- values: Tests which are executed by `Current'.
			-- keys: Corresponding indices.

	assigner: ?EIFFEL_TEST_EXECUTION_ASSIGNER
			-- Assigner for evaluators

	evaluators: !DS_LINKED_LIST [like create_evaluator]
			-- Evaluators executing tests

	compilation_launcher: like default_compilation_launcher
			-- Launcher used to compile eiffel project

	default_compilation_launcher: !EIFFEL_TEST_COMPILATION_LAUNCHER
			-- Default compilation launcher
		once
			create Result
		end

feature -- Status report

	is_ready (a_test_suite: !EIFFEL_TEST_SUITE_S): BOOLEAN
		do
			Result := Precursor (a_test_suite) and compilation_launcher.is_ready (a_test_suite.eiffel_project)
		ensure then
			result_implies_launcher_ready: Result implies compilation_launcher.is_ready (a_test_suite.eiffel_project)
		end

	is_running: BOOLEAN is
			-- <Precursor>
		do
			Result := assigner /= Void
		end

	is_finished: BOOLEAN
			-- <Precursor>
		do
			Result := evaluators.is_empty
		end

feature {NONE} -- Status report

	is_compiled: BOOLEAN
			-- Has project been compiled yet?

	last_root_class_successful: BOOLEAN
			-- True if `write_root_class' was successful in writting a root class

	last_compilation_successful: BOOLEAN
			-- True if last melting triggered by `Current' was successful

feature -- Status setting

	skip_test (a_test: !EIFFEL_TEST_I)
			-- <Precursor>
		do
			abort_test (a_test, False)
		end

feature {NONE} -- Status setting

	start_process_internal (a_list: like active_tests)
			-- <Precursor>
		local
			l_cursor: DS_LINEAR_CURSOR [!EIFFEL_TEST_I]
			l_old_map: like test_map
			l_count: NATURAL
		do
			l_old_map := test_map
			create test_map.make (a_list.count)
			if l_old_map /= Void then
				tests_reset_event.publish ([Current])
				l_old_map := Void
			end

			from
				l_cursor := a_list.new_cursor
				l_cursor.start
			until
				l_cursor.after
			loop
				l_count := l_count + 1
				test_suite.set_test_queued (l_cursor.item, Current)
				test_map.force_last (l_cursor.item, l_count)
				test_added_event.publish ([Current, l_cursor.item])
				l_cursor.forth
			end
			create assigner.make (l_count)
			is_compiled := False
			initialize_evaluators
		ensure then
			not_compiled: not is_compiled
		end

	proceed_process
			-- <Precursor>
		do
			if not (is_compiled or is_stop_requested) then
				write_root_class (test_map)
				if last_root_class_successful then
					compile_project
					if not last_compilation_successful then
						request_stop
					end
				end
					-- Lets write an empty root class back to prevent compiler errors in next compilation
				write_root_class (Void)
				is_compiled := True
			end
			syncronize_evaluators
		end

	stop_process
			-- <Precursor>
		do
			assigner := Void
		end

	write_root_class (a_list: ?DS_LINEAR [!EIFFEL_TEST_I])
			-- Write new root class
			--
			-- `a_list': List of test routines to be referenced by root class.
		require
			running: is_running
		local
			l_dir: PROJECT_DIRECTORY
			l_file: KL_TEXT_OUTPUT_FILE
			l_file_name: FILE_NAME
		do
			last_root_class_successful := False
			l_dir := test_suite.eiffel_project.project_directory
			create l_file_name.make_from_string (l_dir.eifgens_cluster_path)
			l_file_name.set_file_name (source_writer.class_name.as_lower)
			l_file_name.add_extension ("e")
			create l_file.make (l_file_name)
			l_file.recursive_open_write
			if l_file.is_open_write then
				source_writer.write_source (l_file, a_list)
				last_root_class_successful := True
				l_file.flush
				l_file.close
			end
		end

	compile_project
			-- Melt eiffel project
		require
			running: is_running
		local
			l_project: E_PROJECT
			l_class, l_feature: !STRING
		do
			last_compilation_successful := False
			l_project := test_suite.eiffel_project
			l_class := {EIFFEL_TEST_EVALUATOR_SOURCE_WRITER}.class_name
			l_feature := {EIFFEL_TEST_EVALUATOR_SOURCE_WRITER}.root_feature_name
			if not l_project.system.system.is_explicit_root (l_class, l_feature) then
				l_project.system.system.add_explicit_root (Void, l_class, l_feature)
			end
			if compilation_launcher.is_ready (l_project) then
				compilation_launcher.compile (l_project)
				if l_project.successful then
					last_compilation_successful := True
				end
			end
			l_project.system.system.remove_explicit_root (l_class, l_feature)
		end

	initialize_evaluators is
			-- Create new evaluators and launch
		require
			running: is_running
			evaluators_empty: evaluators.is_empty
		local
			l_new: like create_evaluator
			l_count: INTEGER
		do
			if test_map.count < evaluator_count.to_integer_32 then
				l_count := test_map.count
			else
				l_count := evaluator_count.to_integer_32
			end

			from until
				evaluators.count = l_count
			loop
				l_new := create_evaluator
				evaluators.force_last (l_new)
			end
		end

	syncronize_evaluators is
			-- Fetch results from all evaluators. Evaluators which have stopped are relaunched with a new
			-- list of tests. If there are no more test left the evaluator is removed.
		local
			l_cursor: DS_LINKED_LIST_CURSOR [like create_evaluator]
			l_evaluator: like create_evaluator
			l_status: EIFFEL_TEST_EVALUATOR_STATUS
			l_test: ?EIFFEL_TEST_I
			l_stop, l_remove: BOOLEAN
		do
			l_stop := is_stop_requested
			l_cursor := evaluators.new_cursor
			from
				l_cursor.start
			until
				l_cursor.after
			loop
				l_remove := False
				l_evaluator := l_cursor.item

				if not (l_stop or l_evaluator.is_running) then
					l_evaluator.launch
				else
					l_status := l_evaluator.status
					l_remove := l_stop or l_status.is_finished
					if l_remove or l_status.is_disconnected then
						if l_evaluator.is_running then
							l_evaluator.terminate
						end
						if not l_remove then
							l_evaluator.launch
						end
					end
				end
				retrieve_results (l_evaluator)
				if l_remove then
					l_cursor.remove
				else
					l_cursor.forth
				end
			end
			if l_stop then
				abort
			end
		ensure
			stop_requested_implies_evaluators_empty: is_stop_requested implies evaluators.is_empty
		end

	retrieve_results (a_evaluator: !EIFFEL_TEST_EVALUATOR_CONTROLLER)
			-- Retrieve all available results from evaluator and add them to tests in `test_map'. If
			-- evaluator is running a test which is not in `test_map', terminate it.
			--
			-- `a_evaluator': Evaluator from which new results are fetched.
		local
			l_tuple: !TUPLE [index: NATURAL; outcome: ?EQA_TEST_OUTCOME; attempts: NATURAL]
			l_done, l_terminate: BOOLEAN
			l_test: !EIFFEL_TEST_I
		do
			from
			until
				l_done
			loop
				l_terminate := False
				l_tuple := a_evaluator.status.fetch_progress
				if l_tuple.index /= 0 then
					test_map.search (l_tuple.index)
					if test_map.found and not assigner.is_aborted (l_tuple.index) then
						l_test := test_map.found_item
						if not l_test.is_running then
							test_suite.set_test_running (l_test)
						end
						if {l_outcome: !EQA_TEST_OUTCOME} l_tuple.outcome then
							test_suite.add_outcome_to_test (l_test, l_outcome)
						end
					else
							-- If map does not contain test, we could terminate here. However if the evaluator has
							-- already produced a result, we simply won't propagate it and let it execute the next
							-- test in the queue.
						l_terminate := True
					end
					l_done := l_tuple.outcome = Void
				else
					l_done := True
				end
			end
			if l_terminate then
				a_evaluator.status.set_forced_termination
				a_evaluator.terminate
			end
		end

	abort
			-- Abort testing by moving cursor to end and aborting each test which is still queued or running.
		require
			running: is_running
		do
			from
				test_map.start
			until
				test_map.after
			loop
				if test_map.item_for_iteration.is_running then
					test_suite.add_outcome_to_test (test_map.item_for_iteration, create {EQA_TEST_OUTCOME}.make_without_response (create {DATE_TIME}.make_now, True))
				elseif test_map.item_for_iteration.is_queued then
					test_suite.set_test_aborted (test_map.item_for_iteration)
				end
				test_map.forth
			end
		end

	abort_test (a_test: !EIFFEL_TEST_I; a_remove: BOOLEAN)
			-- Flag test as aborted if queued or running. Remove it from `test_map' if `a_remove' is True.
		do
			from
				test_map.start
			until
				test_map.after
			loop
				if test_map.item_for_iteration = a_test then
					if is_running then
						assigner.set_aborted (test_map.key_for_iteration)
						if (a_test.is_queued or a_test.is_running) then
							if a_test.executor = Current and not a_remove then
								if a_test.is_running then
									test_suite.add_outcome_to_test (test_map.item_for_iteration, create {EQA_TEST_OUTCOME}.make_without_response (create {DATE_TIME}.make_now, True))
								else
									test_suite.set_test_aborted (a_test)
								end
							end
						end
					end
					if a_remove then
						test_map.remove (test_map.key_for_iteration)
						test_removed_event.publish ([Current, a_test])
					end
					test_map.go_after
				else
					test_map.forth
				end
			end
		end

feature {EIFFEL_TEST_SUITE_S} -- Events

	on_test_removed (a_collection: !ACTIVE_COLLECTION_I [!EIFFEL_TEST_I]; a_test: !EIFFEL_TEST_I) is
			-- <Precursor>
			--
			-- Note: if `a_test' is part of active tests, we abort its execution
		local
			l_cursor: DS_HASH_TABLE_CURSOR [!EIFFEL_TEST_I, NATURAL]
		do
			abort_test (a_test, True)
			Precursor (a_collection, a_test)
		end

feature {NONE} -- Factory

	create_evaluator: !EIFFEL_TEST_EVALUATOR_CONTROLLER
			-- Create new evaluator state
		require
			running: is_running
		deferred
		ensure
			result_uses_map: Result.assigner = assigner
		end

end
