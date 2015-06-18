class TEST1 [G]

feature

	new_tuple: TUPLE [INTEGER]
		require
			test (once "Test 1: OK")
		do
			print (once "Test: Failed")
		end

	test (s: STRING): BOOLEAN
		require
			s_attached: s /= Void
		do
			io.put_string (s)
			io.put_new_line
		end

end
