class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run test.
		do
			t := Current
			if attached t as a then
				f (a, "Test 1: OK")
			end
			if attached t as b then
				f (b, "Test 2: OK")
			end
			if attached t as c then
				f (c, "Test 3: OK")
			end
		end

feature {NONE} -- Access

	t: detachable TEST

feature {NONE} --  Output

	f (x: attached TEST; s: attached STRING)
		do
			if attached io as o then
				o.put_string (s)
				o.put_new_line
			end
		end

end