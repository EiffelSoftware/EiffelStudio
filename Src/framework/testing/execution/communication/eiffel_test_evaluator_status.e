indexing
	description: "[
		Objects representing testing progress of an evaluator. Since result retreival is done in a
		separate thread, mutexes are used to controll access.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_TEST_EVALUATOR_STATUS

create
	make

feature {NONE} -- Initialization

	make (a_list: !DS_LINEAR [!EIFFEL_TEST_I])
			-- Initialize `Current'
			--
			-- `a_list': List of tests that evaluator is going to tests
		do
			create test_queue.make
			a_list.do_all (agent test_queue.put_last)
			create result_queue.make
			create queue_mutex.make
			is_listening := True
		ensure
			test_queue_equals_a_list: (a_list.count = test_queue.count) and a_list.for_all (agent test_queue.has)
			result_queue_empty: result_queue.is_empty
			listening: is_listening
		end

feature -- Access

	remaining_tests: !DS_LINEAR [!EIFFEL_TEST_I]
			-- Tests for which no result is available yet.
		do
			queue_mutex.lock
			create {DS_ARRAYED_LIST [!EIFFEL_TEST_I]} Result.make_from_linear (test_queue)
			queue_mutex.unlock
		end

	retrieve: !TUPLE [test: ?EIFFEL_TEST_I; outcome: ?EQA_TEST_OUTCOME; next: ?EIFFEL_TEST_I]
			-- Snapshot of current testing progress.
			--
			-- Note: by calling `status', any available outcome will be removed together with its
			--       corresponding test.
			--
			-- test:    Test for which current outcome is available, Void if no outcome is available.
			-- outcome: Outcome for test, Void if no outcome is available.
			-- next:    Test which next outcome will be available, Void if all tests have been tested.
		local
			l_test, l_next: ?EIFFEL_TEST_I
			l_outcome: ?EQA_TEST_OUTCOME
		do
			queue_mutex.lock
			if not result_queue.is_empty then
				l_test := test_queue.first
				test_queue.remove_first
				l_outcome := result_queue.first
				result_queue.remove_first
			end
			if not test_queue.is_empty then
				l_next := test_queue.first
			end
			Result := [l_test, l_outcome, l_next]
			queue_mutex.unlock
		ensure
			result_valid: (Result.test /= Void) = (Result.outcome /= Void)
		end

feature {NONE} -- Access

	queue_mutex: MUTEX
			-- Mutex for accessing `Current'

	test_queue: !DS_LINKED_LIST [!EIFFEL_TEST_I]
			-- Tests interpreter is iterating through

	result_queue: !DS_LINKED_LIST [!EQA_TEST_OUTCOME]
			-- Result interpreter has produced so far

feature -- Status report

	is_listening: BOOLEAN
			-- Is receiver still waiting for connection?

	is_receiving: BOOLEAN
			-- Are more results expected?

	results_complete: BOOLEAN
			-- Are results for all remaining tests available?
		do
			queue_mutex.lock
			Result := test_queue.count = result_queue.count
			queue_mutex.unlock
		end

	has_remaining_tests: BOOLEAN
			-- Are there any remaining tests?
		do
			queue_mutex.lock
			Result := not test_queue.is_empty
			queue_mutex.unlock
		end

feature -- Status setting

	set_receiving
			-- Change status from `is_listening' to `is_receiving'
		do
			is_listening := False
			is_receiving := True
		end

	add_result (a_outcome: !EQA_TEST_OUTCOME)
			-- Add outcome for `current_test'.
		do
			queue_mutex.lock
			if is_receiving then
				if result_queue.count < test_queue.count then
					result_queue.put_last (a_outcome)
				end
			end
			queue_mutex.unlock
		end

	stop_receiving
			-- Set `is_receiving' to False
		do
			queue_mutex.lock
			is_receiving := False
			is_listening := False
			queue_mutex.unlock
		end

end
