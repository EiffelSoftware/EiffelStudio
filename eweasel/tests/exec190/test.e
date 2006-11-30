class TEST

inherit
	MEMORY
	TEST_SETUP

create
	make

feature {NONE} -- Creation

	make is
			-- Run test.
		do
			a.set_thread_item (next)
			a.set_thread_constant (next)
			b.set_thread_item_2 (next)
			b.set_thread_constant_2 (next)
			a.set_process_item (next)
			b.set_process_item_2 (next)
			run_test
			b.set_thread_item (next)
			b.set_thread_constant (next)
			c.set_thread_item_2 (next)
			c.set_thread_constant_2 (next)
			b.set_process_item (next)
			c.set_process_item_2 (next)
			run_test
			c.set_thread_item (next)
			c.set_thread_constant (next)
			b.set_thread_item_2 (next)
			b.set_thread_constant_2 (next)
			c.set_process_item (next)
			b.set_process_item_2 (next)
			run_test
		end

	a: A [INTEGER] is
		do
			full_collect
			create Result
		end

	b: B [BOOLEAN] is
		do
			full_collect
			create Result
		end

	c: C [REAL] is
		do
			full_collect
			create Result
		end

	x: B [$X] is
		do
			full_collect
			create Result
		end

	y: B [$Y] is
		do
			full_collect
			create Result
		end

feature {NONE} -- Status

	item: INTEGER
			-- Last item value

	next: INTEGER is
			-- Get new item value
		do
			Result := item + 1
			item := Result
		end

feature {NONE} -- Tests

	test_thread_item (last: like item) is
		do
			report_test_result (
				last,
				a.thread_item = last and
				b.thread_item = last and
				c.thread_item = last and
				x.thread_item = last and
				y.thread_item = last
			)
		end
	
	test_process_item (last: like item) is
		do
			report_test_result (
				last,
				a.process_item = last and
				b.process_item = last and
				c.process_item = last and
				x.process_item = last and
				y.process_item = last
			)
		end

	test_thread_constant (last: like item) is
		do
			report_test_result (
				last,
				a.thread_constant = last and
				b.thread_constant = last and
				c.thread_constant = last and
				x.thread_constant = last and
				y.thread_constant = last
			)
		end

	test_thread_item_2 (last: like item) is
		do
			report_test_result (
				last,
				b.thread_item_2 = last and
				c.thread_item_2 = last and
				x.thread_item_2 = last and
				y.thread_item_2 = last
			)
		end

	test_process_item_2 (last: like item) is
		do
			report_test_result (
				last,
				b.process_item_2 = last and
				c.process_item_2 = last and
				x.process_item_2 = last and
				y.process_item_2 = last
			)
		end

	test_thread_constant_2 (last: like item) is
		do
			report_test_result (
				last,
				b.thread_constant_2 = last and
				c.thread_constant_2 = last and
				x.thread_constant_2 = last and
				y.thread_constant_2 = last
			)
		end

feature {NONE} -- Thread execution

	run_test is
		do
			item := item - 6
				-- Test thread-relative features in current thread
			test_thread_item (next)
			test_thread_constant (next)
			test_thread_item_2 (next)
			test_thread_constant_2 (next)
				-- Test process-relative features in other thread
			run
		end

	execute is
		do
			test_process_item (next)
			test_process_item_2 (next)
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

end