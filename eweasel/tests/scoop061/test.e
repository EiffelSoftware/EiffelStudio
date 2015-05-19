class TEST

inherit
	EXECUTION_ENVIRONMENT

create
	make,
	make_other,
	make_tuple

feature {NONE} -- Creation
	
	make
			-- Run the test.
		local
			other: separate TEST
		do
			create flag
			separate create {separate TEST}.make_tuple (3) as t do
				tuple := t.tuple
			end
			create other.make_other (flag, tuple)
			separate other as o do
				o.test_read
			end
			write (flag)
			separate other as o do
				o.test_write
			end
			read (flag)
		end

	make_other (f: like flag; t: like tuple)
		do
			flag := f
			tuple := t
		ensure
			flag = f
			tuple = t
		end

	make_tuple (v: INTEGER)
		do
			value := v
			create flag
			tuple := [v, Current, create {E}.make (Current)]
		end

feature -- Access

	value: INTEGER

feature -- Test

	write (f: like flag)
		require
			f.is_ready
		local
			x: separate TEST
		do
			create x.make_tuple (5)
			separate tuple as t do
				t.i := 5
				t.x := x
				t.e := create {E}.make (x)
			end
			f.reset
		end

	test_read
		do
			separate tuple as t do
					-- Test expected values.
				report_i (1, t.i, 3)
				report_x (2, t.x, 3)
				report_x (3, t.e.t, 3)
					-- Indicate that one reading operation has been completed.
				separate flag as f do f.set end
					-- Delay execution to let other processors update `t' if locking is not done for tuples.
				sleep (1_000_000_000)
					-- Re-test expected values.
				report_i (4, t.i, 3)
				report_x (5, t.x, 3)
				report_x (6, t.e.t, 3)
			end
		end

	read (f: like flag)
		require
			f.is_ready
		do
			separate tuple as t do
					-- Test expected values.
				report_i (7, t.i, 7)
				report_x (8, t.x, 7)
				report_x (9, t.e.t, 7)
			end
		end

	test_write
		local
			x: separate TEST
		do
			separate tuple as t do
					-- Write some values.
				create x.make_tuple (8)
				t.i := 8
				t.x := x
				t.e := create {E}.make (x)
					-- Indicate that one writing operation has been completed.
				separate flag as f do f.set end
					-- Delay execution to let other processors read `t' if locking is not done for tuples.
				sleep (1_000_000_000)
					-- Write expected values.
				create x.make_tuple (7)
				t.i := 7
				t.x := x
				t.e := create {E}.make (x)
			end
		end

	tuple: separate TUPLE [i: INTEGER; x: separate TEST; e: E]

feature -- Output

	report_i (n: INTEGER; v: INTEGER; e: INTEGER)
			-- Report whether for test #`n' the value `v' matches `e'.
		do
			io.put_string ("Test ")
			io.put_integer (n)
			if v = e then
				io.put_string (": OK")
			else
				io.put_string (": FAILED (expected ")
				io.put_integer (e)
				io.put_string (" but got ")
				io.put_integer (v)
				io.put_string (")")
			end
			io.put_new_line
		end

	report_x (n: INTEGER; t: detachable separate TEST; e: INTEGER)
			-- Report whether for test #`n' the value `t.value' matches `e'.
		do
			if attached t then
				report_i (n, t.value, e)
			else
				report_i (n, 0, e)
			end
		end

feature -- Synchronization

	flag: separate FLAG

end
