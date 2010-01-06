class C

inherit
	THREAD

create
	make

feature {NONE} -- Creation

	make (test_number: INTEGER; delay: BOOLEAN; test_sem: SEMAPHORE) is
			-- Launch test number `test_number' that creates
			-- a thread that will be execute test when `test_sem'
			-- is open.
		require
			test_sem_not_void: test_sem /= Void
		do
			internal_number := test_number
			is_delayed := delay
			create thread_sem.make (0)
			common_sem := test_sem
			launch
			thread_sem.wait
		end

feature -- Basic operations

	execute is
		do
				-- Notify that this thread has been started
			thread_sem.post
				-- Wait until all other threads start
			common_sem.wait
			if not is_delayed then
					-- Let delayed threads to start execution.
					-- Delay execution for 0.5 second.
				execution_environment.sleep (500_000_000)
			end
				-- Test result of once function
			report_test_result (internal_number, number = internal_number)
		end

feature {NONE} -- Output

	report_test_result (test_number: INTEGER; succeeded: BOOLEAN) is
			-- Report whether a test number `test_number'
			-- is `succeeded' or not.
		require
			positive_test_number: test_number > 0
		do
			io.put_string ("Test " + test_number.out + ": ")
			if succeeded then
				io.put_string ("OK")
			else
				io.put_string ("FAILED")
			end
			io.put_new_line
		end

feature {NONE} -- Status

	number: INTEGER is
			-- Test number
		once
			Result := internal_number
			if is_delayed then
					-- Delay execution for 1 second.
				execution_environment.sleep (1_000_000_000)
			end
		end

	execution_environment: EXECUTION_ENVIRONMENT is
		once
			create Result
		end

	internal_number: INTEGER
			-- Current test number

	is_delayed: BOOLEAN
			-- Should execution be delayed to let other thread(s) to run?

feature {NONE} -- Data

	thread_sem: SEMAPHORE
			-- Semaphore for thread created by current object

	common_sem: SEMAPHORE
			-- Semaphore for all threads

end
