class TEST

create
	default_create,
	make

feature {NONE} -- Creation

        make
        	local
        		s: detachable separate TEST
        		t: detachable TEST
        		ts: A [TEST, separate TEST]
        		st: A [separate TEST, TEST]
        		ss: A [separate TEST, separate TEST]
		do
			t := Current
			s := t
				-- Object test.
				-- Non-separate source type.
			assert (attached t, 1)
			assert (attached {TEST} t, 2)
			assert (attached {separate TEST} t, 3)
			assert (attached t as x, 4)
			assert (attached {TEST} t as x, 5)
			assert (attached {separate TEST} t as x, 6)
				-- Separate source type, non-separate object.
			assert (attached s, 7)
			assert (attached {TEST} s, 8)
			assert (attached {separate TEST} s, 9)
			assert (attached s as x, 10)
			assert (attached {TEST} s as x, 11)
			assert (attached {separate TEST} s as x, 12)
				-- Separate source type, separate object.
			create s.default_create
			assert (attached s, 13)
			assert (not attached {TEST} s, 14)
			assert (attached {separate TEST} s, 15)
			assert (attached s as x, 16)
			assert (not attached {TEST} s as x, 17)
			assert (attached {separate TEST} s as x, 18)
				-- Reverse assignment.
				-- Non-separate source type.
			t ?= t; assert (attached t, 19)
			s ?= t; assert (attached s, 20)
				-- Separate source type, non-separate object.
			t ?= s; assert (attached t, 21)
			s ?= s; assert (attached s, 22)
				-- Separate source type, separate object.
			create s.default_create
			t ?= s; assert (not attached t, 23)
			s ?= s; assert (attached s, 24)
				-- Generic types.
			create s.default_create
			create ts.make (Current, True, 25)
			create st.make (Current, True, 33)
			create st.make (s, False, 41)
			create ss.make (Current, True, 49)
			create ss.make (s, True, 57)
				-- Separate source type, non-conforming object.
			assert (not attached {A [TEST, TEST]} s, 65)
			assert (not attached {separate A [TEST, TEST]} s, 66)
			assert (not attached {A [TEST, TEST]} s as x, 67)
			assert (not attached {separate A [TEST, TEST]} s as x, 68)
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
