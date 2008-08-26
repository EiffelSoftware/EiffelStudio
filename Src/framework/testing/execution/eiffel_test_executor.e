indexing
	description: "[
		Objects that compile and execute eiffel tests.

		The actual compilation and execution are done in separate processes.
		See {EIFFEL_TEST_PROCESS_I} for more details.

	]"
	author: "fivaa"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_TEST_EXECUTOR

inherit
	EIFFEL_TEST_BACKGROUND_EXECUTOR_I

	EIFFEL_TEST_PROCESSOR
		rename
			tests as active_tests,
			argument as active_tests,
			is_valid_typed_argument as is_valid_test_list
		redefine
			on_test_removed
		end

	KL_SHARED_OPERATING_SYSTEM
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'
		do
			create evaluators.make
		end

feature -- Access

	active_tests: !DS_LINEAR [!EIFFEL_TEST_I]
			-- <Precursor>
		do
			Result ?= map.tests
		end

	evaluator_test_count: NATURAL
			-- Number of tests an evaluator gets assigned per launch
		do
			Result := 10
		ensure
			positive: Result > 0
		end

	evaluator_count: NATURAL
			-- Number of evaluators running at the same time
		do
			Result := 1
		ensure
			positive: Result > 0
		end

feature {EIFFEL_TEST_EVALUATOR_CONTROLLER} -- Access

	source_writer: !EIFFEL_TEST_EVALUATOR_SOURCE_WRITER
			-- Source writer for writing evaluator root class
		once
			create Result
		end

feature {NONE} -- Access

	map: ?EIFFEL_TEST_EVALUATOR_MAP
			-- Map containing tests

	cursor: ?DS_LINEAR_CURSOR [!EIFFEL_TEST_I]
			-- Cursor iterating through elements of `map'

	evaluators: !DS_LINKED_LIST [like create_evaluator]
			-- Evaluators executing tests

feature -- Status report

	is_running: BOOLEAN is
			-- <Precursor>
		do
			Result := map /= Void
		end

	is_finished: BOOLEAN
			-- <Precursor>
		do
		end

feature {NONE} -- Initialization

	last_root_class_successful: BOOLEAN
			-- True if `write_root_class' was successful in writting a root class

feature -- Status setting

	skip_test (a_test: !EIFFEL_TEST_I)
			-- <Precursor>
		do
			a_test.abort
			remove_test (a_test)
		end

feature {EIFFEL_TEST_SUITE_S} -- Status setting

	stop
			-- <Precursor>
		do

		end

feature {NONE} -- Status setting

	start_process (a_list: like active_tests)
			-- <Precursor>
		do
			create map.make (a_list)
			cursor := map.tests.new_cursor
			cursor.start
		end

	proceed_process
			-- <Precursor>
		local
			l_project: E_PROJECT
		do
			if evaluators.is_empty then
					-- First call to `proceed_process'
				write_root_class
				l_project := test_suite.eiffel_project
				l_project.quick_melt
				initialize_evaluators
			else
				syncronize_evaluators
			end
--			syncronize_evaluators
--			if not is_stop_requested then
--				l_project := test_suite.eiffel_project
--				if l_project.able_to_compile then
--					prepare_new_evaluator
--					if next_evaluator /= Void then
--						fill_next_evaluator
--						write_root_class
--						l_project.melt (False)
--					end
--				end
--			end
--			server.mutex.unlock
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
			end
		end

	initialize_evaluators is
			--
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
			--
		local
			l_cursor: DS_LINKED_LIST_CURSOR [like create_evaluator]
			l_evaluator: like create_evaluator
		do
			l_cursor := evaluators.new_cursor
			from
				l_cursor.start
			until
				l_cursor.after
			loop
				l_evaluator := l_cursor.item
				fetch_results (l_evaluator.status)
				if not l_evaluator.is_running then
					if not l_evaluator.has_completed or not cursor.after then
						launch_evaluator (l_evaluator)
					else
						l_cursor.remove
					end
				end
				l_cursor.forth
			end
		end

	launch_evaluator (a_evaluator: like create_evaluator) is
			--
		require
			running: is_running
			a_evaluator_not_running: not a_evaluator.is_running
			cursor_not_after_or_not_completed: not cursor.after or not a_evaluator.has_completed
		local
			l_status: EIFFEL_TEST_EVALUATOR_STATUS
			l_remaining: !DS_LINEAR [!EIFFEL_TEST_I]
			l_list: !DS_ARRAYED_LIST [!EIFFEL_TEST_I]
			l_test: !EIFFEL_TEST_I
		do
			create l_list.make (evaluator_test_count.to_integer_32)
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
							l_test.abort
							remove_test (l_test)
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
			from

			until
				l_list.count = evaluator_test_count.to_integer_32 or cursor.after
			loop
				l_list.put_last (cursor.item)
				cursor.forth
			end
			a_evaluator.launch (l_list)
		ensure
			a_evaluator_launched: a_evaluator.is_launched
		end

	fetch_results (a_status: !EIFFEL_TEST_EVALUATOR_STATUS) is
			--
		local
			l_tuple: ?TUPLE [test: !EIFFEL_TEST_I; outcome: !TEST_OUTCOME]
		do
			from
				l_tuple := a_status.next_result
			until
				l_tuple = Void
			loop
				l_tuple.test.add_outcome (l_tuple.outcome)
				remove_test (l_tuple.test)
				l_tuple := a_status.next_result
			end
		end

	remove_test (a_test: !EIFFEL_TEST_I) is
			--
		require
			running: is_running
			active_tests_has_a_test: active_tests.has (a_test)
			a_test_not_running_or_queued: not (a_test.is_running or a_test.is_queued)
		do
			map.remove_test (a_test)
			test_removed_event.publish ([Current, a_test])
			test_suite.test_changed_event.publish ([test_suite, a_test])
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
		do

		end

invariant
	map_corresponds_to_cursor: (map /= Void) = (cursor /= Void)
	cursor_valid: cursor /= Void implies cursor.container = map.tests
	evaluators_launched: evaluators.for_all (agent {like create_evaluator}.is_launched)

end
