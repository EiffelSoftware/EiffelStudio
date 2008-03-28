class TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Run test.
		do
			t := Current
			if {a: like t} t then
				f (a, "Test 1: OK")
			end
			if {b: ?like t} t then
				f (b, "Test 2: OK")
			end
			if {c: !like t} t then
				f (c, "Test 3: OK")
			end
		end

feature {NONE} -- Access

	t: ?TEST

feature {NONE} --  Output

	f (x: !TEST; s: !STRING)
		do
			if {o: like io} io then
				o.put_string (s)
				o.put_new_line
			end
		end

end