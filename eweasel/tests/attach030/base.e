deferred class
	BASE

feature -- Access

	test_a: !STRING
		deferred
		end

	test_b: !STRING
		attribute
			create Result.make_empty
		end

	test_c: !STRING

feature -- Output

	display
		do
			print (test_a)
			print (test_b)
			print (test_c)
			print ('%N')
		end

end

