class
	TEST1 [G]

feature

	f: INTEGER
		do

		ensure
			test: test(agent (a: G): BOOLEAN do Result := True end)
		end

	test (a: ANY): BOOLEAN
		do
			print (a.generating_type)
			print ("%N")
			Result := True
		end

	do_something
		do
			print (({G}).generating_type)
			print ("%N")
		end

end
