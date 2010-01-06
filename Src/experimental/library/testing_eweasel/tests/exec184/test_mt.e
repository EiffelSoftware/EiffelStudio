class TEST_MT

inherit

	TEST
		rename
			make as execute,
			report_test_result as old_report_test_result
		end

	TEST
		rename
			make as execute
		redefine
			report_test_result
		select
			report_test_result
		end

	THREAD
	$THREAD_CONTROL

create

	make,
	start

feature {NONE} -- Creation

	make is
			-- Run test cases in multiple threads and report results.
		local
			t: TEST
			i: INTEGER
		do
				-- Create common structures
			create mutex.make
			create succeeded_tests.make (1, 0)
				-- Start threads
			from
				i := thread_count
			until
				i <= 0
			loop
				create {TEST_MT} t.start (mutex, succeeded_tests)
				i := i - 1
			end
				-- Wait for thread completion
			join_all
				-- Report test results
			from
				i := 1
			until
				i > succeeded_tests.count
			loop
				old_report_test_result (i, succeeded_tests.item (i) = thread_count)
				i := i + 1
			end
		end

	start (m: like mutex; t: like succeeded_tests) is
			-- Launch test cases in a new thread and register results in `t'.
		require
			m /= Void
			t /= Void
		do
			mutex := m
			succeeded_tests := t
			launch
		end

feature {NONE} -- Initialization

	thread_count: INTEGER is 5
			-- Number of threads to be launched

feature {NONE} -- Statistics

	succeeded_tests: ARRAY [INTEGER]
			-- Storage to keep the number of succeded tests

	report_test_result (test_number: INTEGER; succeeded: BOOLEAN) is
		do
			mutex.lock
			if succeeded_tests.count < test_number then
				succeeded_tests.force (0, test_number)
			end
			if succeeded then
				succeeded_tests.put (succeeded_tests.item (test_number) + 1, test_number)
			end
			mutex.unlock
		end

feature {NONE} -- Synchronization
	
	mutex: MUTEX
			-- Mutex to serialize access to `succeeded_tests'
			-- from different threads

invariant

	non_void_mutex: mutex /= Void
	non_void_succeeded_tests: succeeded_tests /= Void

end
