indexing

	description: "[
		Test to ensure that assertion monitoring in one thread
		does not interfer with it in other thread.
	]"

class TEST

inherit

	THREAD
		redefine
			copy,
			is_equal
		end

create
	make, make1, make2

feature {NONE} -- Creation

	make is
			-- Run tests.
		local
			t1, t2: TEST
		do
			create t1.make1
			create t2.make2
		end

	make1
		do
			launch
			test_precondition_1
			join
			report_test_result (
				is_checked_1,
				is_checked_2,
				"precondition_1",
				"precondition_2",
				1)
			is_checked_1 := false
			is_checked_2 := false
		end

	make2
		do
			launch
			twin.do_nothing
			join
			report_test_result (
				is_checked_1,
				is_checked_2,
				"copy",
				"precondition_2",
				2)
		end

feature {NONE} -- Output

	report_test_result (c1, c2: BOOLEAN; m1, m2: STRING; n: INTEGER) is
			-- Report whether conditions `c1' and `c2' described by
			-- `m1' and `m2' are met or not in test `n'.
		do
			io.put_string ("Test ")
			io.put_integer (n)
			io.put_string (": ")
			if c1 and c2 then
				io.put_string ("OK")
			else
				io.put_string ("FAILED in ")
				if not c1 then
					io.put_string (m1)
				end
				if not c2 then
					if not c1 then
						io.put_string (" and ")
					end
					io.put_string (m2)
				end
			end
			io.put_new_line
		end

feature -- Tests

	is_checked_1, is_checked_2: BOOLEAN
			-- Flags for check points

	set_is_checked_1 (value: BOOLEAN) is
			-- Set `is_checked_1' to `value'.
		do
			is_checked_1 := value
		end

	precondition_1: BOOLEAN is
			-- Set `is_checked_1' to true, let thread 2 to go
			-- and wait until it is ready; return true
		do
			is_checked_1 := true
			semaphore_2.post
			semaphore_1.wait
			Result := true
		end

	copy (other: TEST) is
			-- Same as `precondition_1'.
		do
			precondition_1.do_nothing
			other.set_is_checked_1 (true)
		end

	is_equal (other: TEST): BOOLEAN is
			-- Always true to make `copy', `twin', etc. happy
		do
			Result := true
		end

	precondition_2: BOOLEAN is
			-- Set `is_checked_2' to true and let thread 1 to go;
			-- return true
		do
			is_checked_2 := true
			semaphore_1.post
			Result := true
		end

	test_precondition_1 is
			-- Test that `precondition_1' is checked.
		require
			precondition_1
		do
			if not is_checked_1 then
				semaphore_2.post
				semaphore_1.wait
			end
		end

	test_precondition_2 is
			-- Test that `precondition_2' is checked.
		require
			precondition_2
		do
			if not is_checked_2 then
				semaphore_1.post
			end
		end

	execute is
			-- Wait until thread 1 is ready and
			-- execute `test_precondition_2'.
		do
			semaphore_2.wait
			test_precondition_2
		end

feature {NONE} -- Synchronization objects

	semaphore_1: SEMAPHORE is
			-- Semaphore to control execution of thread 1
		indexing
			once_status: "global"
		once
			create Result.make (0)
		end

	semaphore_2: SEMAPHORE is
			-- Semaphore to control execution of thread 2
		indexing
			once_status: "global"
		once
			create Result.make (0)
		end

end
