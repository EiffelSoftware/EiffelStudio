class TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Run test.
		do
			b := f (b)
		end

feature {NONE} -- Implementation

	b: B [ANY]

	f (a: B [ANY]): B [ANY] is
		local
			l: B [ANY]
		do
			a.set_b (1)
			b.set_b (2)
			create l
			l.set_b (3)
			create Result
			Result.set_b (4)
			output (a)
			output (b)
			output (l)
			output (Result)
		end

feature {NONE} -- Output

	output (v: B [ANY]) is
		do
			io.put_string (v.a)
			io.put_string (": ")
			io.put_integer (v.b)
			io.put_new_line
		end

end
