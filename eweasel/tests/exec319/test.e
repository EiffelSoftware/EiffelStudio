class TEST

create
	make


feature {NONE} -- Creation

	make
			-- Run tests.
		do
			report (across <<1, 2, 3>> as c all c.item > 0 end)
		end

feature {NONE} -- Output

	count: NATURAL_8
			-- Number of tests executed so far

	report (b: BOOLEAN)
			-- Report that the current test is completed with result `b'.
		do
			count := count + 1
			io.put_string ("Test #")
			io.put_natural (count)
			io.put_string (": ")
			if b then
				io.put_string ("OK")
			else
				io.put_string ("FAILED")
			end
			io.put_new_line
		ensure
			count_incremented: count = old count + 1
		end

end
