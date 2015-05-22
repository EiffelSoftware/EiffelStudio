class A [S, T]

create
	make

feature {NONE} -- Creation

        make (a: S; b: BOOLEAN; i: INTEGER)
        	local
        		t: detachable T
        		s: detachable separate T
		do
				-- Object test.
			assert (attached a, i)
			assert (b = attached {T} a, i + 1)
			assert (attached {separate T} a, i + 2)
			assert (attached a as x, i + 3)
			assert (b = attached {T} a as x, i + 4)
			assert (attached {separate T} a as x, i + 5)
				-- Reverse assignment.
			t ?= a; assert (b = attached t, i + 6)
			s ?= a; assert (attached s, i + 7)
		end

feature {NONE} -- Output

	assert (b: BOOLEAN; i: INTEGER)
			-- Report whether test `i' is successful according to `b'.
		do
			io.put_string ("Test #")
			io.put_integer (i)
			io.put_string (": ")
			if b then
				io.put_string ("OK")
			else
				io.put_string ("FAILED")
			end
			io.put_character ('.')
			io.put_new_line
		end

end
