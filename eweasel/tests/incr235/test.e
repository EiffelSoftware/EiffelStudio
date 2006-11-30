class TEST

inherit
	THREAD
	$THREAD_CONTROL

create
	make

feature {NONE} -- Creation

	make is
			-- Run test.
		do
			set_thread_item (1)
			test_thread_item (1)
			set_process_item (2)
			test_process_item (2)
			set_thread_item (0)
			set_process_item (4)
			launch
			join_all
		end

feature {NONE} -- Thread execution

	execute is
		do
			test_thread_item (3)
			test_process_item (4)
		end

feature -- Access

	item: INTEGER is
			-- Current thread-specific value
		do
			Result := thread_storage.item
		end

	process_item: INTEGER is
			-- Current process-wide value
		do
			Result := process_storage.item
		end

feature -- Modification

	set_thread_item (new_item: like item) is
		do
			thread_storage.set_item (new_item)
		ensure
			item_set: item = new_item
		end

	set_process_item (new_item: like process_item) is
		do
			process_storage.set_item (new_item)
		ensure
			process_item_set: process_item = new_item
		end

feature -- Tests

	test_thread_item (value: like item) is
			-- Test that `item' is equal to `value'
		do
		        report_test_result (value, item = value)
		end

	test_process_item (value: like process_item) is
			-- Test that `process_item' is equal to `value'
		do
		        report_test_result (value, process_item = value)
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

feature {NONE} -- Storage

	thread_storage: INTEGER_REF is
		indexing
			once_status: "$THREAD_STATUS"
		once
			create Result
			Result.set_item (3)
		end

	process_storage: INTEGER_REF is
		indexing
			once_status: "$PROCESS_STATUS"
		once
			create Result
		end

end