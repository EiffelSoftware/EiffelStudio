class TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Execute test.
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i > 1
			loop
				io.put_string ("Test 1: OK")
				io.put_new_line
				i := i + 1
			end
			from
				i := 1
			variant
				2 - i
			until
				i > 1
			loop
				io.put_string ("Test 2: OK")
				io.put_new_line
				i := i + 1
			end
			from
				i := 1
			until
				i > 1
			loop
				io.put_string ("Test 3: OK")
				io.put_new_line
				i := i + 1
			variant
				2 - i
			end
		end

end