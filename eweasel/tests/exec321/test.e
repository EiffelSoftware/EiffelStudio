class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run tests.
		local
			i: NATURAL_32
		do
			if i = 0 then
				check
					-- Nothing really
				then
				end
				io.put_string ("Test 1: OK")
				io.put_new_line
				check
					-- Nothing really
				then
					io.put_string ("Test 2: OK")
					io.put_new_line
				end
				check
					something: -- Comment is true
				then
					io.put_string ("Test 3: OK")
					io.put_new_line
				end
				check
					true
				then
					io.put_string ("Test 4: OK")
					io.put_new_line
				end
				check
					correct: Current = Current
				then
					io.put_string ("Test 5: OK")
					io.put_new_line
				end
				check
					Current = Current
					more: Current ~ Current
				then
					io.put_string ("Test 6: OK")
					io.put_new_line
				end
				check
					false
				then
				end
				io.put_string ("Test 7: FAILED")
				io.put_new_line
			elseif i = 1 then
				io.put_string ("Test 7: OK")
				io.put_new_line
				check
					false
				then
					io.put_string ("Test 8: FAILED")
					io.put_new_line
				end
			elseif i = 2 then
				io.put_string ("Test 8: OK")
				io.put_new_line
				check
					correct: Current /= Current
				then
					io.put_string ("Test 9: FAILED")
					io.put_new_line
				end
			elseif i = 3 then
				io.put_string ("Test 9: OK")
				io.put_new_line
				check
					Current = Current
					more: Current /~ Current
				then
					io.put_string ("Test 10: FAILED")
					io.put_new_line
				end
			elseif i = 4 then
				io.put_string ("Test 10: OK")
				io.put_new_line
				check
					Current /= Current
					more: Current ~ Current
				then
					io.put_string ("Test 11: FAILED")
					io.put_new_line
				end
			elseif i = 5 then
				io.put_string ("Test 11: OK")
				io.put_new_line
			else
				io.put_string ("Unknown test")
				io.put_new_line
			end
		rescue
			i := i + 1
			retry
		end

end
