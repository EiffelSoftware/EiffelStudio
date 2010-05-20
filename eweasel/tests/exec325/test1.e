class
	TEST1 [G]

feature

	f: INTEGER
		require
			test: test("pre: ", agent (a: G): BOOLEAN do Result := True end)
		do

		ensure
			test: test("post: ", agent (a: G): BOOLEAN do Result := True end)
		end

	test (s: STRING; a: ANY): BOOLEAN
		do
			print (s)
			print (a.generating_type)
			print ("%N")
			Result := True
		end

	do_something
		do
			print (({G}).generating_type)
			print ("%N")
		end

invariant
	test: test("inv: ", agent (a: G): BOOLEAN do Result := True end)

end
