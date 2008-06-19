class TEST

inherit
	THREAD
	$THREAD_CONTROL

create
	make,
	make1,
	make2

feature {NONE} -- Creation

	make is
			-- Execute all tests.
		local
			t1: TEST
			t2: TEST
		do
			create t1.make1
			create t2.make2
			create common_sem.make (0)
			create delay_sem.make (0)
			t1.start (common_sem, delay_sem)
			t2.start (common_sem, delay_sem)
			common_sem.post
			common_sem.post
			join_all
		end

	make1 is
			-- Create object for thread 1.
		do
			internal_number := 1
		end

	make2 is
			-- Create object for thread 2.
		do
			internal_number := 2
		end

feature -- Basic operations

	start (c: SEMAPHORE; d: SEMAPHORE) is
			-- Launch thread using synchronization objects `c' and `d'.
		require
			c_not_void: c /= Void
			d_not_void: d /= Void
		do
			common_sem := c
			delay_sem := d
			create thread_sem.make (0)
			launch
				-- Ensure thread initialization is completed
			thread_sem.wait
		end

	execute is
		local
			succeeded: BOOLEAN
		do
				-- Notify that this thread is ready
			thread_sem.post
				-- Wait until all threads are started
			common_sem.wait
			if internal_number = 2 then
					-- Make sure thread 1 starts once function evaluation before thread 2
				delay_sem.wait
			end
			succeeded := number = 1
			if internal_number = 2 then
					-- Make sure thread 1 produces output before thread 2
				delay_sem.wait
			end
			report_test_result (internal_number, succeeded)
			if internal_number = 1 then
					-- Make sure thread 1 produces output before thread 2
				delay_sem.post
			end
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
			-- Global once function
		indexing
			once_status: "global"
		once
			Result := internal_number
			if Result = 1 then
					-- Make sure thread 2 attempts to get result of once function
					-- that is not yet calculated by thread 1
				delay_sem.post;
				(create {EXECUTION_ENVIRONMENT}).sleep (1_000_000_000)
			end
		end

	internal_number: INTEGER
			-- Current test number

feature {NONE} -- Implementation

	thread_sem: SEMAPHORE
			-- Semaphore to synchronize thread creation

	common_sem: SEMAPHORE
			-- Semaphore to synchronize thread launch

	delay_sem: SEMAPHORE
			-- Semaphore to synchronize work of two threads

end
