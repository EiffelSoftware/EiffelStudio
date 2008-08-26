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
		ensure
			test_queue_equals_a_list: (a_list.count = test_queue.count) and a_list.for_all (agent test_queue.has)
			result_queue_empty: result_queue.is_empty
		end

feature -- Access

	current_test: ?EIFFEL_TEST_I
			-- Test currently beeing tested.
		do
			queue_mutex.lock
			if not remaining_tests.is_empty then
				Result := remaining_tests.first
			end
			queue_mutex.unlock
		end

	remaining_tests: !DS_LINEAR [!EIFFEL_TEST_I]
			-- Tests for which no result is available yet.
		do
			queue_mutex.lock
			create {DS_ARRAYED_LIST [!EIFFEL_TEST_I]} Result.make_from_linear (test_queue)
			queue_mutex.unlock
		end

	next_result: ?TUPLE [test: !EIFFEL_TEST_I; outcome: !TEST_OUTCOME]
			-- First result pair in queue of received results if available, Void otherwise.
			--
			-- Note: result pair is removed.
		do
			queue_mutex.lock
			if not result_queue.is_empty then
				Result ?= result_queue.first
				result_queue.remove_first
			end
			queue_mutex.unlock
		end

feature {NONE} -- Access

	queue_mutex: MUTEX
			-- Mutex for accessing `Current'

	test_queue: !DS_LINKED_LIST [!like current_test]
			-- Tests interpreter is iterating through

	result_queue: !DS_LINKED_LIST [!like next_result]
			-- Result interpreter has produced so far

feature -- Status report

	has_remaining_tests: BOOLEAN
			-- Are there any remaining tests?
		do
			queue_mutex.lock
			Result := not test_queue.is_empty
			queue_mutex.unlock
		end

feature -- Status setting

	add_result (a_outcome: !TEST_OUTCOME)
			-- Add outcome for `current_test'.
		do
			queue_mutex.lock
			if not test_queue.is_empty then
				result_queue.put_last ([test_queue.first, a_outcome])
				test_queue.remove_first
			end
			queue_mutex.unlock
		end

end
