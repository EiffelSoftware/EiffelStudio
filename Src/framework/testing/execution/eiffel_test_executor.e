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
	EIFFEL_TEST_BACKGROUND_EXECUTOR_I
		rename
			start_process as start_process_frozen
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
			Result ?= map.tests
		end

	evaluator_test_count: NATURAL
			-- Number of tests an evaluator gets assigned per launch
			--
			-- Note: can be zero to indicate that all tests are assigned to a single evaluator.
		do
			Result := 0
		ensure
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

	map: !EIFFEL_TEST_EVALUATOR_MAP
			-- Map containing tests
		require
			test_suite_valid: is_test_suite_valid
		do
			Result ?= internal_map
		end

	internal_map: ?EIFFEL_TEST_EVALUATOR_MAP
			-- Internal storage for `map'

	cursor: ?DS_LINEAR_CURSOR [!EIFFEL_TEST_I]
			-- Cursor iterating through elements of `map'

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
			Result := cursor /= Void
		end

	is_finished: BOOLEAN
			-- <Precursor>
		do
			Result := evaluators.is_empty
		end

feature {NONE} -- Status report

	last_root_class_successful: BOOLEAN
			-- True if `write_root_class' was successful in writting a root class

	last_compilation_successful: BOOLEAN
			-- True if last melting triggered by `Current' was successful

	is_current_test_in_map: BOOLEAN
			-- Was last test traversed by `retrieve_results' and determined to be running in map?

feature -- Status setting

	skip_test (a_test: !EIFFEL_TEST_I)
			-- <Precursor>
		do
			remove_test (a_test)
			test_suite.set_test_aborted (a_test)
		end

feature {NONE} -- Status setting

	start_process (a_list: like active_tests)
			-- <Precursor>
		local
			l_cursor: DS_LINEAR_CURSOR [!EIFFEL_TEST_I]
			l_project: !E_PROJECT
		do
			create internal_map.make (a_list.count)
			cursor := map.tests.new_cursor
			from
				l_cursor := a_list.new_cursor
				l_cursor.start
			until
				l_cursor.after
			loop
				test_suite.set_test_queued (l_cursor.item, Current)
				map.add_test (l_cursor.item)
				l_cursor.forth
			end
			cursor.start
			write_root_class
			if last_root_class_successful then
				compile_project
				if last_compilation_successful then
					initialize_evaluators
				end
			end
		end

	proceed_process
			-- <Precursor>
		do
			syncronize_evaluators
		end

	stop_process
			-- <Precursor>
		do
			cursor := Void
			is_idle := False
		end

	write_root_class
			-- Write new root class
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
				source_writer.write_source (l_file, {!EIFFEL_TEST_EVALUATOR_MAP} #? map)
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
		do
			from until
				evaluators.count = evaluator_count.to_integer_32 or cursor.after
			loop
				l_new := create_evaluator
				launch_evaluator (l_new)
				evaluators.force_last (l_new)
			end
		end

	syncronize_evaluators is
			-- Fetch results from all evaluators. Evaluators which have stopped are relaunched with a new
			-- list of tests. If there are no more test left the evaluator is removed.
		local
			l_cursor: DS_LINKED_LIST_CURSOR [like create_evaluator]
			l_evaluator: like create_evaluator
			l_test: ?EIFFEL_TEST_I
		do
			l_cursor := evaluators.new_cursor
			from
				l_cursor.start
			until
				l_cursor.after
			loop
				l_evaluator := l_cursor.item
				if is_stop_requested and l_evaluator.is_running then
					l_evaluator.terminate
				end

					-- Note: the order of first checking if the evaluator is running and afterwards retrieving
					--       the results is crucial since results are added in a different thread.
				if not l_evaluator.is_running then
					retrieve_results (l_evaluator.status)
					if is_stop_requested or (cursor.after and l_evaluator.status.results_complete) then
						l_cursor.remove
					else
						launch_evaluator (l_evaluator)
						if not l_evaluator.is_launched then
							l_cursor.remove
						end
					end
				else
					retrieve_results (l_evaluator.status)
					if not (is_current_test_in_map and l_evaluator.status.has_remaining_tests) then
						l_evaluator.terminate
					end
				end
				if not l_cursor.after and l_evaluator = l_cursor.item then
					l_cursor.forth
				else
				end
			end
		ensure
			stop_requested_implies_evaluators_empty: is_stop_requested implies evaluators.is_empty
		end

	launch_evaluator (a_evaluator: like create_evaluator) is
			-- Try launching evaluator with tests which has not been tested yet.
			--
			-- Note: if evaluator has remaining tests from last execution and they have no caused evaluator
			--       to stop, also add them to list.
			--
			-- `a_evaluator': Evaluator to launch.
		require
			running: is_running
			a_evaluator_not_running: not a_evaluator.is_launched or else not a_evaluator.is_running
		local
			l_status: EIFFEL_TEST_EVALUATOR_STATUS
			l_remaining: !DS_LINEAR [!EIFFEL_TEST_I]
			l_list: !DS_ARRAYED_LIST [!EIFFEL_TEST_I]
			l_test: !EIFFEL_TEST_I
		do
			if evaluator_test_count = 0 then
				create l_list.make (map.tests.count)
			else
				create l_list.make (evaluator_test_count.to_integer_32)
			end
			if a_evaluator.is_launched then
				l_status := a_evaluator.status
				if l_status.has_remaining_tests then
					l_remaining := l_status.remaining_tests
						--| Note: `l_remaining' should not be empty since there should not be any other thread still
						--        adding results to the status. However to be on the safe side we check on more time.
					if not l_remaining.is_empty then
						l_remaining.start
						if not a_evaluator.is_terminated then
								-- Evaluator has not been stopped by `Current', which means that it encountered problems
								-- executing the first test in `l_remaining'. Currently we will no try to test it again.
							l_test := l_remaining.item_for_iteration
							remove_test (l_test)
							test_suite.set_test_aborted (l_test)
							l_remaining.forth
						end
						from until
							l_remaining.after
						loop
							if active_tests.has (l_remaining.item_for_iteration) then
								l_list.put_last (l_remaining.item_for_iteration)
							end
							l_remaining.forth
						end
					end
				end
				a_evaluator.reset
			end

				-- Fill `l_list' with tests from `cursor' up
			from until
				(evaluator_test_count > 0 and l_list.count = evaluator_test_count.to_integer_32)
					or cursor.after
			loop
				l_list.put_last (cursor.item)
				cursor.forth
			end
			if not l_list.is_empty then
				a_evaluator.launch (l_list)
				test_suite.set_test_running (l_list.first)
			end
		end

	retrieve_results (a_status: !EIFFEL_TEST_EVALUATOR_STATUS) is
			-- Retrieve all results in status and addopt `active_tests'.
			--
			-- `a_status': Status from which new results are fetched.
		local
			l_tuple: !TUPLE [test: ?EIFFEL_TEST_I; outcome: ?TEST_OUTCOME; next: ?EIFFEL_TEST_I]
			l_done: BOOLEAN
			l_test: !EIFFEL_TEST_I
			l_outcome: !TEST_OUTCOME
		do
			from until
				l_done
			loop
				l_tuple := a_status.retrieve
				if l_tuple.test /= Void then
					l_test ?= l_tuple.test
					if map.tests.has (l_test) then
						l_outcome ?= l_tuple.outcome
						remove_test (l_test)
						test_suite.add_outcome_to_test (l_test, l_outcome)
					end
				else
					l_done := True
				end
				is_current_test_in_map := False
				if l_tuple.next /= Void then
					l_test ?= l_tuple.next
						-- If map does not contain `l_test', we could abort here. However if the evaluator has
						-- already produced a result, we simply won't propagate it and let it execute the next
						-- test in the queue.
					if map.tests.has (l_test) then
						if not l_test.is_running then
							test_suite.set_test_running (l_test)
						end
						is_current_test_in_map := True
					end
				else
					l_done := True
				end
			end
		end

	remove_test (a_test: !EIFFEL_TEST_I) is
			-- Remove test from `active_tests' and notify observers.
			--
			-- `a_test': Test to be removed.
		require
			running: is_running
			active_tests_has_a_test: active_tests.has (a_test)
		do
			map.remove_test (a_test)
			test_removed_event.publish ([Current, a_test])
		end

feature {EIFFEL_TEST_SUITE_S} -- Events

	on_test_removed (a_collection: !ACTIVE_COLLECTION_I [!EIFFEL_TEST_I]; a_test: !EIFFEL_TEST_I) is
			-- <Precursor>
			--
			-- Note: if `a_test' is part of active tests, we abort its execution
		do
			if active_tests.has (a_test) then
				skip_test (a_test)
			end
			Precursor (a_collection, a_test)
		end

feature {NONE} -- Factory

	create_evaluator: !EIFFEL_TEST_EVALUATOR_CONTROLLER
			-- Create new evaluator state
		require
			running: is_running
		deferred
		ensure
			result_uses_map: Result.map = map
		end

invariant
	cursor_attached_implies_map_attached: cursor /= Void implies map /= Void
	cursor_valid: cursor /= Void implies cursor.container = map.tests
	evaluators_launched: evaluators.for_all (agent {like create_evaluator}.is_launched)

end
