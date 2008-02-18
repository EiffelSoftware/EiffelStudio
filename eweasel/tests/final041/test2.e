class TEST2

inherit
	TEST1 [STRING]
		redefine
			new_tuple
		end

feature

	new_tuple: TUPLE [INTEGER, STRING] is
		require else
			test (once "Test 2: OK") or else True
		do
			test (once "Test 3: OK").do_nothing
			Result := [1, once "Test 4: OK"]
		end

end
