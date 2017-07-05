class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run test.
		local
			a: A
			x: COMPARABLE
		do
			x := ""

			io.put_string ("Test #1: ")
			print (if q then x else 5 end)
			io.put_new_line

			io.put_string ("Test #2: ")
			print (if q then True else 5 end)
			io.put_new_line

			io.put_string ("Test #3: ")
			print (if q then x else a end)
			io.put_new_line

			io.put_string ("Test #4: ")
			print (if q then True else a end)
			io.put_new_line
		end

feature {NONE} -- Status report

	q: BOOLEAN
			-- A boolean value `False`.
		do
		end

end
