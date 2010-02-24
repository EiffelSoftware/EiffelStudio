deferred class
	BASE

feature -- Access

	test_a: attached STRING
		deferred
		end

	test_b: attached STRING
		attribute
			create Result.make_empty
		end

	test_c: attached STRING

feature -- Output

	display
		do
			print (test_a)
			print (test_b)
			print (test_c)
			print ('%N')
		end

end

